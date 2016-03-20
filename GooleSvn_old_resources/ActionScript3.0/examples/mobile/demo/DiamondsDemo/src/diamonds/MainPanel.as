package diamonds
{
	//import flash.display.Sprite;

	import com.greensock.TimelineMax;
	import com.greensock.TweenAlign;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Elastic;
	import com.greensock.events.TweenEvent;
	
	import diamonds.house.HouseResource;
	import diamonds.resource.Diamonds;
	import diamonds.vo.AddDiamondsVO;
	import diamonds.vo.MoveDiamondsVO;
	import diamonds.vo.RecordDiamondsNumVO;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.TouchEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.Timer;
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import managers.PanelManager;
	import managers.SceneManager;
	
	import net.jt_tech.ui.JTPanelBase;
	import net.jt_tech.ui.dispelscene.ResourceDiamondsBgAndContainer;
	import net.jt_tech.ui.dispelscene.ResourceMenuElements;
	
	import panel.gamepause.GamePausePanel;
	
	import sounds.SingleMusic;
	import sounds.SoundType;
	import sounds.SounderManager;

	public class MainPanel extends JTPanelBase
	{

		/////////////////////////////////////////vars /////////////////////////////////
		
			/////////// Timer 定时器  ////////////////////
		private var diamondsGameTimer:DiamondsGameTimer;
			/////////// Timer 定时器  ////////////////////
		
			/////////// 数值变量 Number  ////////////////////
		/** 上一次有效消除点击的时间 */
		private var lastClickTime:int;
		/** 计时器 */
		private var setIntervalID:int;
		/** 总得分  */
		private var totalResult:int			= 0;
		private var totalResultToServer:int = 0;
		/** 连续消除的次数(控制是否进入极速状态  */
		private var continueRemoveNum:int	= 0;
		/** 连击次数 */
		private var continuousClickNum:int  = 0;
		/** 消除后新添加的钻石数目 */
		private var addDiamondsNum:int		= 0;
		/** 上一次自动检查是否有不能消除的时间 */
		private var lastCheckTime:Number	= -1;
		/** 在使用道具或者在兴奋模式下的达到新添道具的id */
		private var addPropId:int 			= DiamondType.statusDefault;
		private var pauseTimeTotal:Number	= 0;
			/////////// 数值变量 Number  ////////////////////
		
			/////////// Boolean 类型  ////////////////////
		/** 当前使用道具 */
		private var usePropCurrent:Boolean		= false;
		/** 正在使用道具 */
		private var isUseingProp:Boolean		= false;
		/** 是否是兴奋状态 */
		private var isExcitementStart:Boolean	= false;
		/** 本次点击后是否是有效的消除 */
		private var removeSuccessed:Boolean		= false;
		/** 开关，控制点击是否有效 */
		private var canClick:Boolean			= false;
		/** 提示开关 */
		private var isNeedPromp:Boolean			= true;
		/** 是否是时间到了之后使用时间停止道具 */
		private var isTimeOverStop:Boolean 		= false;
			/////////// Boolean 类型  ////////////////////
		
			/////////// Array 类型  ////////////////////
		/** 使用5x5大小方正消除的道具，存储内圈砖石  */
		private var insideDiamArr:Vector.<Diamonds>;
		/** 使用5x5大小方正消除的道具，存储外圈砖石  */
		private var outerDiamArr:Vector.<Diamonds>;
		/** 添加新钻石 Array */
		private var addNewDiamondArr:Vector.<AddDiamondsVO>;
		/** 下移动钻石 Array */
		private var moveOldDiamondArr:Vector.<MoveDiamondsVO>;
		/** 地图二维数组，存储卡片 */
		private var mapTotalDiamondArr:Array;
		/** 记录开始布局时的缓动 */
		private var tweenTotalArr:Array			= new Array();
		/** 钻石类型 */
		private var diamondTypeArray:Array 		= DiamondType.diamondTypeArray;
		/** 解锁道具 */
		private var diamondPropArray:Array 		= DiamondType.diamondPropArray;
			/////////// Array 类型  ////////////////////
		
			/////////// 常量 const //////////////////////
		/** 两次有效点击之间的间隔时间 */
		private var clickIntervalTime:int			= 1100;
		/** 使用道具需要在钻石移除舞台后在 UsePropEffect 中延迟回调用回调函数的时间*/
		private const usePropDelayTime:int			= 300;
		private const prompCardDelayTime:int = 3000;
		/**  */
		private const tweenTime:Number				= 0.2;
		/** 兴奋（极速）状态持续时间 */
		private const continueExcitingTime:int 	= 5000;
		
		private const excitementNumber:int        = 7;
		
		private var theExcitingTimeSecond:int     = 0;
		
		/* 五种能量槽的当前数目; */
		/** yellow 1 当前数目*/
		private var energy_yellow:Number	= 0;
		/** blue 2 当前数目 */
		private var energy_blue:Number		= 0;
		/** red 3 当前数目 */
		private var energy_red:Number		= 0;
		/** yellow 4 当前数目 */
		private var energy_purple:Number	= 0;
		/** yellow 5 当前数目 */
		private var energy_green:Number		= 0;
		
			/////////// 常量 const //////////////////////

			//////////////// container ////////////////////
		/** 地图容器  */
		private var diamondsContainer:Sprite; //地图容器
		/** 特效容器  */
		private var effectContainer:Sprite; // 
		/** 移除方块时方块特效 */
		private var removeEffectContainer:Sprite;
		/** 抖动动画容器*/
		private var animationContainer:MovieClip;
			//////////////// container ////////////////////
		
			//////////////// Resources ////////////////////
		/** ready 准备提示动画资源 */
		private var readyRes:MovieClip;
		/** go 准备提示动画资源 */
		private var goRes:MovieClip;
		/** 游戏时间计时结束 (time's up)提示动画资源 */
		private var timeUpRes:MovieClip;
		/** 界面资源内容 */
		private var dispelPane:ResourceDiamondsBgAndContainer;
		/** -2秒时间动画提示 */
		private var cutTimeAnimationRes:MovieClip;
		/** 使用沙漏道具增加 6 秒动画资源 */
		private var addSixSecondsRes:MovieClip;
		/** 最后10秒倒计时音乐 */
		private var lastTenTimeMusic:SingleMusic;
		/** 进入兴奋状态后 火焰燃烧的声音*/
		private var fireBurnMusic:SingleMusic;
		/** 同色消除连接钻石间的特效 */
		private var ligaturePurpleDis:Sprite;
		
		private var continuousClickEffect:ContinuousClickNumberEffect;
		
		private var menuElements:ResourceMenuElements;
			//////////////// Resources ////////////////////
		
			////////// public ////////////////
		/** 加成的 百分比 */
		public var additionPercent:Number	= 0.02;
		/** 定义游戏时间 */
		public var timeNum:uint				= 60;
		/** 是否是新手引导 */
		public var isNoviceGuide:Boolean	= false;
		/** 房子等级 */
		public var houseLevel:int			= 0;
		
		public var playOverCallFunction:Function;
			////////// public ////////////////
		
		/** 加时间道具使用次数  */
		internal var timePropNum:int = 0;
		
		
		/** diamond 对象池存取固定字段 */
		public static const poolString:String = "pool";

		public function MainPanel()
		{
			super();

			initGame();
		}

				//////////////// public /////////////////
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 初始化面板及数据
		 */
		public function initialization():void
		{
			initAndClearVars();
			setGameTimeChange();
			
			while (diamondsContainer.numChildren > 0) diamondsContainer.removeChildAt(0);
			setScroceTxtAndChange(0);
			mapTotalDiamondArr	= new Array(DiamondType.Rows);
			diamondTypeArray 	= DiamondType.diamondTypeArray;
			tweenTotalArr		= [];
			
			if (this.stage) startInit(); 
			else this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		public function setOpenProp(arr:Array):void
		{
			diamondPropArray = arr;
		}
		
		/**
		 * 启动 和 暂停计时器
		 * @param isStart 是否启动计时器
		 */
		public function startAndStopTimer(isStart:Boolean):void
		{
			if (isStart)
			{
				lastClickTime=getTimer();
				if (diamondsGameTimer) diamondsGameTimer.start();
				if (fireBurnMusic) fireBurnMusic.rePlay();
				if (lastTenTimeMusic)
				{
					if (timeNum < 10)
					{
						lastTenTimeMusic.currentPosition=(10 - timeNum) * 0.1 * lastTenTimeMusic.length;
						lastTenTimeMusic.rePlay();
					}
					else
					{
						lastTenTimeMusic.stop();
					}
				}
			}
			else
			{
				if (diamondsGameTimer) diamondsGameTimer.pause();
				if (fireBurnMusic) fireBurnMusic.pause(); 
				if (lastTenTimeMusic) lastTenTimeMusic.stop(); 
			}
		}
		
		/**
		 * 清楚计时器及变量
		 */
		public function clearVars():void
		{
			isNeedPromp=true;
			setAllCardvised();
			moveAndAddCardFun();
			
			clearEffectContainer();
			clearTimerMain();
			clearFireBurnMusic();
			setMouseEnbled(true);
			
			killTween();
			removeEvent();
			
			dispelPane.bg.gotoAndStop(1);
			
			// 将记录“连续添加的方块是同种颜色的次数”变量值清零
			AddDiamondProbabilityCalculations.clear();
			
			if (Global.isDebug)
			{
				test_RemoveEvents();
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		////////////////////////////////////////////////////////////////////////
		
		/**
		 * 初始化游戏
		 */
		private function initGame():void
		{	
			initResourceAndContainer();
			
//			initContinuousClickEffect(); // 显示连击次数
			
			setDisplayObjectEnabled();
			
			animationContainer.gotoAndStop(1);
		}
		
		/**
		 * 初始化特效容器
		 */
		private function initResourceAndContainer():void
		{
			animationContainer = this.createUIItem(DiamondType.TYPE_RESOURCE_ROCK_FRAME_EFFECT) as MovieClip;
			
			dispelPane = new ResourceDiamondsBgAndContainer();
			removeEffectContainer = dispelPane.effectContainer;
			effectContainer = dispelPane.effectContainer;
			diamondsContainer = dispelPane.diamondsContainer;
			dispelPane.x = - dispelPane.width * 0.5;
			dispelPane.y = - dispelPane.height* 0.5;
			
			animationContainer.x = 242;
			animationContainer.y = 448;
			animationContainer.con.addChild(dispelPane);
			
			menuElements = new ResourceMenuElements();
			
			var bg:Sprite = this.createUIItem(DiamondType.TYPE_RESOURCE_SCENE_DISPEL_DIAMONDS) as Sprite;
			this.addChild(bg);
			
			this.addChild(menuElements);
			this.addChild(animationContainer);
		}
		
		private function setDisplayObjectEnabled():void
		{
			removeEffectContainer.mouseChildren	= 
			removeEffectContainer.mouseEnabled	= 
			effectContainer.mouseChildren		=
			effectContainer.mouseEnabled		= 
			effectContainer.mouseEnabled		= 
			effectContainer.mouseChildren		= 
			dispelPane.mouseEnabled				=
			animationContainer.mouseEnabled 	= 
			animationContainer.con.mouseEnabled = 
			this.mouseEnabled					= false;
		}
		
		private function initContinuousClickEffect():void
		{
			continuousClickEffect = new ContinuousClickNumberEffect();
			continuousClickEffect.container = effectContainer;
			continuousClickEffect.setTargetXY(480, 295);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			startInit();
		}
		
		private function startInit():void
		{
			// ready go
			readyResInitialization();
			
			// 开始布局
			initStartLayout();
			
			// 启动布局动画效果
			initTimers();
			
			// 开场声音
			SounderManager.instance.playSound(SoundType.Sounds354);
			
			if (Global.isDebug)
			{
				test_AddEvents();
			}
		}
		
		private function initAndChangeTheScroceRateLength():void
		{	
			menuElements.scoreTxt.text = totalResult.toString();
		}
		
		private function initAndClearVars():void
		{
			diamondsContainer.mouseEnabled 	= false;
			diamondsContainer.mouseChildren = false;
			isExcitementStart  = false;
			isUseingProp = false;
			isTimeOverStop = false;
			this.visible = true;
			continueRemoveNum = 0;
			continuousClickNum = 0;
			totalResult	= 0;
			timePropNum	= 0;
			pauseTimeTotal = 0;
		}
		
		private function initStartLayout():void
		{
			const diamondsLength:int = diamondTypeArray.length;
			const rows:int = DiamondType.Rows;
			const cols:int = DiamondType.Cols;
			for (var j:int=0; j < cols; j++)
			{
				var tempArrTimeLine:Array=[];
				var tempTimeLineMax:TimelineMax=new TimelineMax();
				for (var i:int=rows - 1; i >= 0; i--)
				{
					if (mapTotalDiamondArr[i] == null) mapTotalDiamondArr[i]=[];
					var card:Diamonds;
					var rnd:int	= int(Math.random() * diamondsLength);
					var id:int	= diamondTypeArray[rnd];
					var moveAfterEnd_y:Number = i * Diamonds.DIAMONDS_HEIGHT;
					var poolNamestr:String = poolString + id;
					if (DiamondsPool.hasObject(poolNamestr)) card = DiamondsPool.getObject(poolNamestr) as Diamonds;
					else card = new Diamonds(id);
					diamondsContainer.addChild(card);
					card.x		= j * Diamonds.DIAMONDS_WIDTH;
					card.y		= -200 - (rows - i) * Diamonds.DIAMONDS_HEIGHT;
					card.moveAfterEnd_y	= moveAfterEnd_y;
					card.setIndex(i, j);
					mapTotalDiamondArr[i].push(card);
					tempArrTimeLine.push(TweenMax.to(card, 0.3, {y: moveAfterEnd_y, onCompleteListener: initCardsObjectSingleHandler}));
				}
				tempTimeLineMax.pause();
				tempTimeLineMax.addEventListener(TweenEvent.COMPLETE, initObjectsCompletedHandler);
				tempTimeLineMax.appendMultiple(tempArrTimeLine, 0, TweenAlign.START, 0.01);
				tweenTotalArr.push(tempTimeLineMax);
			}
		}
		
		/**
		 * 根据id改变能量槽的高度和昌泡
		 * @param id 能量槽的类型
		 * @param num  增加的高度
		 * @param init  初始化
		 * @return
		 *
		 */
		private function changeEnergygroove(id:int, num:int, init:Boolean=false):void
		{
			if (theDiamonIdCanUpdatePropValue(id) || init) //判断有没有被锁定
			{
				switch (id)
				{
					case DiamondType.diamondBlue:
						energy_blue += num;
						if (energy_blue >= DiamondType.ENERGY_BLUE_RANGE)
						{
							addPropId = DiamondType.PropCrossBlue;
							energy_blue = energy_blue - DiamondType.ENERGY_BLUE_RANGE;
						}
						break;
					case DiamondType.diamondGreen:
						energy_green += num;
						if (energy_green >= DiamondType.ENERGY_GREEN_RANGE)
						{
							addPropId = DiamondType.PropHourglassGreen;
							energy_green = energy_green - DiamondType.ENERGY_GREEN_RANGE;
						}
						break;
					case DiamondType.diamondPurple:
						energy_purple += num;
						if (energy_purple >= DiamondType.ENERGY_PURPLE_RANGE)
						{
							var ty:int = int(Math.random() * (DiamondType.diamondPropSameColor.length - 1));
							var tyId:int = DiamondType.diamondPropSameColor[ty + 1];
							addPropId = tyId;
							energy_purple = energy_purple - DiamondType.ENERGY_PURPLE_RANGE;
						}
						break;
					case DiamondType.diamondRed:
						energy_red += num;
						if (energy_red >= DiamondType.ENERGY_RED_RANGE)
						{
							addPropId = DiamondType.PropMatrixRed;
							energy_red = energy_red - DiamondType.ENERGY_RED_RANGE;
						}
						break;
					case DiamondType.diamondYellow:
						energy_yellow += num;
						if (energy_yellow >= DiamondType.ENERGY_YELLOW_RANGE)
						{
							addPropId = DiamondType.PropMatrixYellow;
							energy_yellow = energy_yellow - DiamondType.ENERGY_YELLOW_RANGE;
						}
						break;
					
				}
			}
		}
		
		private function clearFireBurnMusic():void
		{
			if (fireBurnMusic)
			{
				fireBurnMusic.stop();
			}
		}
		
		private function clearEffectContainer():void
		{
			if (effectContainer.numChildren > 0)
			{
				if (effectContainer.getChildAt(0) is UsePropEffect)
				{
					UsePropEffect(effectContainer.getChildAt(0)).clear();
				}
				else
				{
					effectContainer.removeChildAt(0);
				}
			}
		}
		
		/**
		 * 初始化 计时器
		 */
		private function initTimers():void
		{
			var tempTimerMax:Timer=new Timer(10);
			tempTimerMax.addEventListener(TimerEvent.TIMER, tempTimerMaxHandler);
			playLayoutTimeLine();
			tempTimerMax.start();
			tempTimerMax = null;
			
			clearTimerMain();
			
			diamondsGameTimer = new DiamondsGameTimer();
			diamondsGameTimer.callBackFunction = diamondsGameTimerCallFunction;
		}
		
		private function clearTimerMain():void
		{
			if (diamondsGameTimer)
			{
				diamondsGameTimer.stopAndClear();
				diamondsGameTimer = null;
			}
		}

		////////////////////////////////////////////////////////////////////////

		/**
		 * 播放起始布局的缓动
		 * @param $num
		 *
		 */
		private function playLayoutTimeLine():void
		{
			var timeLineM:TimelineMax=tweenTotalArr.shift();
			timeLineM.play();
			timeLineM=null;
		}
		
		/**
		 * 开局时的 ready 动画资源初始化
		 */
		private function readyResInitialization():void
		{
			if (readyRes == null)
			{
				readyRes = this.createUIItem(DiamondType.TYPE_RESOURCE_DISPEL_WORDS_READY) as MovieClip;
				setReadyGoTimesUpWordsPoint(readyRes);
			}
			if (readyRes.parent == null) this.addChild(readyRes);
			readyRes.addEventListener(Event.ENTER_FRAME, readyResEnterEventHandler);
			readyRes.gotoAndPlay(1);
		}
		
		/**
		 * 开局  go 动画资源初始化
		 */
		private function goResInitialization():void
		{
			if (goRes == null)
			{
				goRes = this.createUIItem(DiamondType.TYPE_RESOURCE_DISPEL_WORDS_GO) as MovieClip;
				setReadyGoTimesUpWordsPoint(goRes);
			}
			if (goRes.parent == null) this.addChild(goRes);
			goRes.addEventListener(Event.ENTER_FRAME, goResEnterEventHandler);
			goRes.gotoAndPlay(1);
		}
		
		private function setReadyGoTimesUpWordsPoint($dis:DisplayObject):void
		{
			var rect:Rectangle = $dis.getBounds($dis);
			var rect2:Rectangle = dispelPane.getBounds(dispelPane);
			var point:Point = dispelPane.parent.localToGlobal(new Point(-dispelPane.bg.width * 0.5, -dispelPane.bg.height * 0.5));
			
			$dis.x = point.x + (dispelPane.width - $dis.width) * 0.5 - rect.x;
			$dis.y = point.y + (dispelPane.height- $dis.height) * 0.5 - rect.y;
		}
		
		/**
		 * 参见游戏结束时分数加成的数字对象
		 * @param $num 
		 */
		private function createTotalResultNumRes($addNum:int, $realNum:int):void
		{
//			if (totalResultNumRes)
//			{
//				if (totalResultNumRes.parent) totalResultNumRes.parent.removeChild(totalResultNumRes);
//				totalResultNumRes=null;
//			}
//			totalResult = $realNum + $addNum;
//			initAndChangeTheScroceRateLength();
//			
//			var nums:int				= totalResult * additionPercent - $addNum;
//			totalResultNumRes			= Numeric.getNumericMovieClip("+" + Numeric.getNumericString(nums));
//			totalResultNumRes.width		= (30 / totalResultNumRes.height) * totalResultNumRes.width;
//			totalResultNumRes.height	= 30;
//			totalResultNumRes.x			= scoreBonusAddRes.x + (scoreBonusAddRes.width - totalResultNumRes.width) + scoreBonusAddRes.getBounds(scoreBonusAddRes).x;
//			totalResultNumRes.y			= scoreBonusAddRes.y - totalResultNumRes.height - 5 + scoreBonusAddRes.getBounds(scoreBonusAddRes).y;
//			addScoreAnimation.addChild(totalResultNumRes);
		}
		
		/**
		 * 初始化或启动兴奋（极速）状态持续时间计时器
		 */
		private function initExcitementSomeVars():void
		{
			isExcitementStart=true;
			theExcitingTimeSecond = continueExcitingTime * 0.001;
		}
		
		private function accountNumClick():void
		{
			var time:Number = getTimer();
			if (isExcitementStart || getTimer() - lastClickTime <= clickIntervalTime)
			{
				continuousClickNum++;
				continueRemoveNum++;
			}
			else
			{
				continueRemoveNum=1;
				continuousClickNum = 1;
			}
			
			if (continuousClickEffect) continuousClickEffect.play(continuousClickNum);
			
//			trace("accountNumClick:++++++++++++"+(getTimer() - time));
		}

		/**
		 * 根据连击的次数获取相应的声音资源
		 * @param num
		 * @return 
		 */
		private function moreHitClickSoundType(num:int):String
		{
			var str:String=SoundType.Sounds445;
			switch (num)
			{
				case 1:
					str=SoundType.Sounds445;
					break;
				case 2:
					str=SoundType.Sounds446;
					break;
				case 3:
					str=SoundType.Sounds447;
					break;
				case 4:
					str=SoundType.Sounds448;
					break;
				case 5:
					str=SoundType.Sounds449;
					break;
				case 6:
					str=SoundType.Sounds450;
					break;
				case 7:
					str=SoundType.Sounds451;
					break;
				case 8:
					str=SoundType.Sounds452;
					break;
				case 9:
					str=SoundType.Sounds366;
					break;
				case 10:
					str=SoundType.Sounds367;
					break;
				case 11:
					str=SoundType.Sounds8;
					break;
				case 12:
					str=SoundType.Sounds41;
					break;
			}
			return str;
			return "";
		}

		/**
		 * 开始消除卡片
		 * @param pathArr  要消除卡片的数组
		 * @param $diamond 
		 * @return
		 *
		 */
		private function removeCard($checkResultArray:Vector.<Diamonds>, $diamond:Diamonds, $isExcitement:Boolean=false):void
		{
			if ($checkResultArray)
			{
				var cardID:int = $diamond.id;
				var localX:Number = $diamond.x;
				var localY:Number = $diamond.y;
				removeSuccessed = true;
				lastClickTime = getTimer();
				setScroceTxtAndChange($checkResultArray.length);
				// 清除前次点击消除特效未完成
//				clearRemoveEffectContainerChild();
				
				addNewDiamondArr = new Vector.<AddDiamondsVO>();
				moveOldDiamondArr = new Vector.<MoveDiamondsVO>();
				
				var tempDiamond:Diamonds;
				var recordDiamondsVO:RecordDiamondsNumVO;
				var changCardNumArr:Vector.<RecordDiamondsNumVO> = new Vector.<RecordDiamondsNumVO>();
				for each (tempDiamond in $checkResultArray)
				{
					var index_i:int = tempDiamond.index_i;
					var index_j:int = tempDiamond.index_j;
					var t_id:int=tempDiamond.id;
					var isInCCNA:Boolean=false;
					
					setMoveDiamondsVO($checkResultArray, index_i, index_j);
					setAddDiamondsVO(index_j);
					
					if (cardID != DiamondType.PropMatrixRed)
					{
						//增加移除特效
						if (diamondTypeArray.indexOf(tempDiamond.id) >= 0)
						{
							createRemoveEffect(tempDiamond.x, tempDiamond.y, $isExcitement);
						}
						// 移除方块
						removeOrRedrawDiamon(tempDiamond);
					}
					for each (recordDiamondsVO in changCardNumArr)
					{
						if (recordDiamondsVO.diamondId == t_id)
						{
							recordDiamondsVO.diamondNumber++;
							isInCCNA=true;
							break;
						}
					}
					if (!isInCCNA)
					{
						recordDiamondsVO = new RecordDiamondsNumVO();
						recordDiamondsVO.diamondNumber = 1;
						recordDiamondsVO.diamondId = t_id;
						changCardNumArr.push(recordDiamondsVO);
					}
				}
				
				for each (recordDiamondsVO in changCardNumArr)
				{
					changeEnergygroove(recordDiamondsVO.diamondId, recordDiamondsVO.diamondNumber);
				}
				
				if (cardID == DiamondType.PropMatrixRed)
				{
					shakeMatrixDiamond($checkResultArray);
				}
				
				$checkResultArray = null;
				
//				trace("数据查找阶段："+(getTimer() - startTimeNumber));
				
				// 消除类型音效设置
				playClickSoundType($diamond, $isExcitement);
			}
		}
		
		private function checkCurrentClickIsRight($checkResultArray:Vector.<Diamonds>, $diamond:Diamonds):Boolean
		{
			var $diamondId:int = $diamond.id;
			if ($checkResultArray.length < 3)
			{
				if ($diamondId != DiamondType.PropHourglassGreen && $diamondId != DiamondType.PropSameColorPurple)
				{
					for each($diamond in $checkResultArray)
					{
						$diamond.goToStopDarkle();
					}
					clickErrorReduceTwoSecond();/*无效点击，定时器缩短两秒*/
					$checkResultArray = null;
					canClick = true;
					setMouseEnbled(true);
					return false;
				}
			}
			return true;
		}
		
		private function setMoveDiamondsVO(tempCheckResultArray:Vector.<Diamonds>, $index_i:int, $index_j:int):void
		{
			if ($index_i < 0) return ;
			var i:int;
			for (i = $index_i; i > 0; i--)
			{
				/** 移出卡片上面的所有卡片 */
				var tempCard:Diamonds = mapTotalDiamondArr[i - 1][$index_j] as Diamonds;
				/**判断要移动的卡片是否在要移出的卡片数组中 */
				var isInArr:Boolean = Boolean(tempCheckResultArray.indexOf(tempCard) > -1);
				if (!isInArr)
				{
					/** 判断要移动的卡片是否已经在移动的卡片数组中,如果是则移动位置加1，否则添加到数组中 */
					var isInMoveCardArr:Boolean = false;
					var objvo:MoveDiamondsVO;
					var index_i:int = tempCard.index_i;
					var index_j:int = tempCard.index_j;
					for each (objvo in moveOldDiamondArr)
					{
						if (objvo.i == index_i && objvo.j == index_j)
						{
							isInMoveCardArr=true;
							objvo.moveDistance++;
							break;
						}
					}
					if (!isInMoveCardArr)
					{
						objvo = new MoveDiamondsVO();
						objvo.diamond = tempCard;
						objvo.i = index_i;
						objvo.j = index_j;
						objvo.moveDistance = 1;
						moveOldDiamondArr.push(objvo);
					}
				}
			}
		}
		
		private function setAddDiamondsVO($index_j:int):void
		{
			var isInAddArr:Boolean = false;
			var addov:AddDiamondsVO;
			for each (addov in addNewDiamondArr)
			{
				if (addov.xCoor == $index_j)
				{
					isInAddArr = true;
					addov.addNumber++;
					break;
				}
			}
			if (!isInAddArr)
			{
				addov	= new AddDiamondsVO();
				addov.xCoor	= $index_j;
				addov.addNumber = 1;
				addNewDiamondArr.push(addov);
			}
		}
		
		private function playClickSoundType($diamond:Diamonds, $isExcitement:Boolean = false):void
		{
			var cardID:int = $diamond.id;
			var localX:Number = $diamond.x;
			var localY:Number = $diamond.y;
			if (cardID == DiamondType.PropCrossBlue)
			{
				usePropCardPlayEffect(cardID, localX, localY);
				SounderManager.instance.playSound(SoundType.Sounds52);
				SounderManager.instance.playSound(SoundType.Sounds640);
			}
			else if (cardID == DiamondType.PropMatrixRed)
			{
				usePropCardPlayEffect(cardID, localX, localY, usePropDelayTime);
				SounderManager.instance.playSound(SoundType.Sounds249);
			}
			else if (DiamondType.diamondPropSameColor.indexOf(cardID) >= 0)
			{
				usePropCardPlayEffect(cardID, localX, localY, 0);
				SounderManager.instance.playSound(SoundType.Sounds249);
			}
			else if (cardID == DiamondType.PropHourglassGreen) // 增加6秒道具 沙漏
			{
				timePropNum++;
				addSixSecondTime();
				usePropCardPlayEffect(cardID, localX, localY);
				SounderManager.instance.playSound(SoundType.Sounds102);
			}
			else if (cardID == DiamondType.PropMatrixYellow)
			{
				usePropCardPlayEffect(cardID, localX, localY);
				SounderManager.instance.playSound(SoundType.Sounds249);
			}
			else
			{
//				moveAndAddCardFun();
				setIntervalID=flash.utils.setTimeout(moveAndAddCardFun, 50);
				if ($isExcitement) // 兴奋消除
				{
					SounderManager.instance.playSound(SoundType.Sounds249);
					if (fireBurnMusic == null) fireBurnMusic = new SingleMusic(SoundType.Sounds604, int.MAX_VALUE);
					else fireBurnMusic.rePlay();
				}
				else // 普通消除
				{
					SounderManager.instance.playSound(moreHitClickSoundType(continueRemoveNum));
					clearFireBurnMusic();
				}
				usePropCurrent = false;
			}
		}
		
		private function clearRemoveEffectContainerChild():void
		{
			while (removeEffectContainer.numChildren > 0)
			{
				var dis:DisplayObject = removeEffectContainer.getChildAt(0);
				if (dis is DiamondsRemoveEffect) 
					DiamondsRemoveEffect(dis).clearVars();
				else
					removeEffectContainer.removeChildAt(0);
			}
		}
		
		/**
		 * 点击出现无效消除时间减2秒，显示动画
		 */
		private function clickErrorReduceTwoSecond():void
		{
			if (timeNum > 10)
			{
				timeNum	-= 2;
				timeNum	= timeNum < 10 ? 10 : timeNum;
				setGameTimeChange();
				if (cutTimeAnimationRes == null)
				{
					cutTimeAnimationRes		= this.createUIItem(DiamondType.TYPE_RESOURCE_DISPEL_MINUS_TIME_SECONDS_TWO) as MovieClip;
					var titleTimeMc:DisplayObject = menuElements.timeTxt;
					var tPoint:Point		= titleTimeMc.parent.localToGlobal(new Point(titleTimeMc.x, titleTimeMc.y));
					var tRects:Rectangle	= cutTimeAnimationRes.getBounds(cutTimeAnimationRes);
					cutTimeAnimationRes.x	= tPoint.x + (titleTimeMc.width - tRects.width)*0.5 - tRects.x;
					cutTimeAnimationRes.y	= tPoint.y + (titleTimeMc.height - tRects.height)*0.5 - tRects.y;
					addChild(cutTimeAnimationRes);
				}
				cutTimeAnimationRes.visible=true;
				cutTimeAnimationRes.addEventListener(Event.ENTER_FRAME, cutTimeAnimationResEnterHandler);
				cutTimeAnimationRes.gotoAndPlay(1);
			}
			SounderManager.instance.playSound(SoundType.Sounds248);
		}
		
		/**
		 * 使用加时道具，时间增加6秒，动画播放
		 */
		private function addSixSecondTime():void
		{
			if (addSixSecondsRes == null)
			{
				addSixSecondsRes		= this.createUIItem(DiamondType.TYPE_RESOURCE_DISPEL_ADD_TIME_SECONDS_SIX) as MovieClip;
				var titleTimeMc:DisplayObject = menuElements.timeTxt;
				var tPoint2:Point 		= titleTimeMc.parent.localToGlobal(new Point(titleTimeMc.x, titleTimeMc.y));
				var tRects2:Rectangle	= addSixSecondsRes.getBounds(addSixSecondsRes);
				addSixSecondsRes.x		= tPoint2.x+(titleTimeMc.width-tRects2.width)*0.5-tRects2.x;
				addSixSecondsRes.y		= tPoint2.y+(titleTimeMc.height-tRects2.height)*0.5-tRects2.y;
				this.addChild(addSixSecondsRes);
			}
			addSixSecondsRes.visible=true;
			addSixSecondsRes.addEventListener(Event.ENTER_FRAME, addSixSecondsResEnterEventHandler);
			addSixSecondsRes.gotoAndPlay(1);
			
			timeNum += 6;
			setGameTimeChange();
			if (timeNum > 10 && lastTenTimeMusic && lastTenTimeMusic.isRunning) lastTenTimeMusic.stop();
		}
		
		/**
		 * 指定钻石id对应的解锁道具是否已被解锁
		 * @param $id 指定的钻石id
		 * @return 
		 * 
		 */
		private function theDiamonIdCanUpdatePropValue($id:int):Boolean
		{
			var boo:Boolean = false;
			switch ($id)
			{
				case DiamondType.diamondBlue:
					boo = diamondPropArray.indexOf(DiamondType.PropCrossBlue) 		>= 0;
					break;
				case DiamondType.diamondGreen:
					boo = diamondPropArray.indexOf(DiamondType.PropHourglassGreen) 	>= 0;
					break;
				case DiamondType.diamondPurple:
					boo = diamondPropArray.indexOf(DiamondType.PropSameColorPurple) >= 0;
					break;
				case DiamondType.diamondRed:
					boo = diamondPropArray.indexOf(DiamondType.PropMatrixRed) 		>= 0;
					break;
				case DiamondType.diamondYellow:
					boo = diamondPropArray.indexOf(DiamondType.PropMatrixYellow) 	>= 0;
					break;
			}
			return boo;
		}

		/**
		 *移动和增加卡片
		 *
		 */
		private function moveAndAddCardFun():void
		{
			var time:Number = getTimer();
			flash.utils.clearTimeout(setIntervalID);
			moveCard(moveOldDiamondArr);
			addCard(addNewDiamondArr);
//			trace("moveAndAddCardFun:=:"+(getTimer() - time));
			trace("----------------------------------------------------"+(getTimer() - startTimeNumber - 50));
			moveOldDiamondArr=null;
			addNewDiamondArr=null;
			canClick=true;
			setMouseEnbled(true);
			if (addPropId != DiamondType.statusDefault && isTimeOverStop == false)
			{
				useProp(addPropId);
				addPropId = DiamondType.statusDefault;
			}
		}

		/** 把所有卡片复位，并设置为未被访问的状态  */
		private function setAllCardvised():void
		{
			if (isNeedPromp == false)
				return;
			
			for each (var ary:Array in mapTotalDiamondArr)
			{
				for each (var card:Diamonds in ary)
				{
					card.isVisied=false;
					if (diamondPropArray.indexOf(card.id) == -1)
					{
						card.goToStopBack();
					}
				}
			}

		}

		/**
		 * 移动卡片
		 * @param mcs 移动卡片的数组
		 *
		 */
		private function moveCard(mcs:Vector.<MoveDiamondsVO>):void
		{
			if (isTimeOverStop) return ;
			var time:Number = getTimer();
			if (mcs)
			{
				var mcsObj:MoveDiamondsVO;
				for each (mcsObj in mcs)
				{
					var tempCard:Diamonds = mcsObj.diamond;
					var moveNum:int = mcsObj.moveDistance;
					var oldI:int = tempCard.index_i;
					var oldJ:int = tempCard.index_j;
					var newI:int = oldI + moveNum;
					var endY:Number = tempCard.y + Diamonds.DIAMONDS_HEIGHT * moveNum;
					mapTotalDiamondArr[newI][oldJ] = tempCard;
					tempCard.moveAfterEnd_y = endY;
					tempCard.setIndex(newI, oldJ);
					TweenMax.to(tempCard, 0.2, {y: endY , ease:Elastic.easeOut, onCompleteListener: moveObjctSingleHandler});
				}
			}
//			trace("moveCard ========= "+ (getTimer() - time));
			mcs=null;
		}

		/**
		 * 填充卡片
		 * @param addCardArr 填充卡片的数组
		 *
		 */
		private function addCard(addCardArr:Vector.<AddDiamondsVO>):void
		{
			if (isTimeOverStop) return ;
			var time:Number = getTimer();
			if (addCardArr)
			{
				var i:int;
				var addov:AddDiamondsVO;
				var arrTempProp:Array=[];/* 临时存储添加的钻石类型 */
				var arrTempId:Array=[0, 1, 2, 3, 4];/* 定义一个数组序列号 */
				var leng:int = AddDiamondProbabilityCalculations.probabilityCalculations(addDiamondsNum);/* 选取 需要添加的钻石的种类数目 */
//				len = usePropCurrent ? 5 : len;// 当前使用道具与否
				// 根据种类数随机顺序生成不重复的钻石类型
				for (i = 0; i < leng; i++)
				{
					var rd:int = int(Math.random() * arrTempId.length);
					var ar:Array = arrTempId.splice(rd, 1);
					arrTempProp[i] = diamondTypeArray[int(ar[0])];
				}
				for each (addov in addCardArr)
				{
					var num:int = addov.addNumber - 1;
					var xcoor:int = addov.xCoor;
					var timeLineMaxAdd:TimelineMax = new TimelineMax();
					var arrTimeLineAdd:Array = [];
					for (i = num; i >= 0; i--)
					{
						var t_diamond:Diamonds;
						var rnd:int	= int(Math.random() * leng);
						var id:int	= arrTempProp[rnd];
						var moveAfterEnd_y:Number = i * Diamonds.DIAMONDS_HEIGHT;
						var poolNameStr:String = poolString + id;
						if (DiamondsPool.hasObject(poolNameStr)) t_diamond = DiamondsPool.getObject(poolNameStr) as Diamonds;
						else t_diamond = new Diamonds(id);
						diamondsContainer.addChild(t_diamond);
						t_diamond.x = xcoor * Diamonds.DIAMONDS_WIDTH;
						t_diamond.y = moveAfterEnd_y - 420;
						t_diamond.moveAfterEnd_y = moveAfterEnd_y;
						mapTotalDiamondArr[i][xcoor] = t_diamond;
						t_diamond.setIndex(i, xcoor);
						arrTimeLineAdd.push(TweenMax.to(t_diamond, 0.2, {y:moveAfterEnd_y, onCompleteListener: addCardsObjectSingleHandler}));
					}
					timeLineMaxAdd.addEventListener(TweenEvent.COMPLETE, addObjectsCompletedHandler);
					timeLineMaxAdd.appendMultiple(arrTimeLineAdd, 0, TweenAlign.START, 0.05);
					timeLineMaxAdd = null;
					arrTimeLineAdd = null;
				}
			}
//			trace("addCard ========= "+ (getTimer() - time));
			addCardArr=null;
		}

		/**
		 * 消除剩余的缓动
		 */
		private function killTween():void
		{
			var time:Number = getTimer();
			var diamond:Diamonds;
			for each (var ar:Array in mapTotalDiamondArr)
			{
				for each (diamond in ar)
				{
					TweenMax.killTweensOf(diamond);
					diamond.y = diamond.moveAfterEnd_y;
				}
			}
//			trace("killTween****************"+(getTimer() - time));
		}
		
		/**
		 * 同化 是否有不可消除情况判断 并给予更正
		 * 
		 */
		private function assimilation():void
		{
			if (isNeedPromp == false) return;
			var time:Number = getTimer();
			var arr3:Array		= []; // 大于等于3个相连的数组
			var arr2:Array		= []; // 等于2个相连的数组
			var arrThree:Array	= []; // 記錄 >=3个相连对象id
			var arrTwo:Array	= []; // 记录 2个相连对象id
			var str:String;
			
			checkCardCanClickStatus(arr3, arr2, arrThree, arrTwo);
			
			var strTwo:String = arrThree.toString();
			var strThree:String = arrTwo.toString();
			if (arr3.length <= 2)
			{
				var boolean:Boolean = false;
				while (boolean == false)
				{
					var tempN:Number=int(Math.random() * arr2.length);
					var ttcard:Diamonds;
					if (arr2[tempN])
					{
						var tt:int=int(Math.random() * 2);
						if (arr2[tempN][tt])
						{
							var tCard:Diamonds=Diamonds(arr2[tempN][tt]);
							if (tCard.index_i - 1 >= 0)
							{
								ttcard=Diamonds(mapTotalDiamondArr[tCard.index_i - 1][tCard.index_j]);
								boolean = checkCardStatusAndReturnBoolean(ttcard, tCard.id);
								if (boolean == true) return ;
							}
							
							if (tCard.index_i + 1 < DiamondType.Rows)
							{
								ttcard=Diamonds(mapTotalDiamondArr[tCard.index_i + 1][tCard.index_j]);
								boolean = checkCardStatusAndReturnBoolean(ttcard, tCard.id);
								if (boolean == true) return ;
							}
							
							if (tCard.index_j - 1 >= 0)
							{
								ttcard=Diamonds(mapTotalDiamondArr[tCard.index_i][tCard.index_j - 1]);
								boolean = checkCardStatusAndReturnBoolean(ttcard, tCard.id);
								if (boolean == true) return ;
							}
							
							if (tCard.index_j + 1 < DiamondType.Cols)
							{
								ttcard=Diamonds(mapTotalDiamondArr[tCard.index_i][tCard.index_j + 1]);
								boolean = checkCardStatusAndReturnBoolean(ttcard, tCard.id);
								if (boolean == true) return ;
							}
						}
					}
				}
			}
			
			trace("assimilation ========= "+ (getTimer() - time));
			
			function checkCardStatusAndReturnBoolean($ttcard:Diamonds, $redraw:int):Boolean
			{
				str=$ttcard.index_i + ":" + $ttcard.index_j;
				if (canReplaceDiamond($ttcard) && strTwo.indexOf(str) == -1 && strThree.indexOf(str) == -1)
				{
					$ttcard.redraw($redraw);
					lastCheckTime = getTimer();
					autoPromptTargetChangeToEffect($ttcard);
					return true;
				}
				return false;
			}
			arr3 = arr2 = arrTwo = arrThree = null;
		}
		
		private function checkCardCanClickStatus(recordThreeCardArr:Array, recordTwoCardArr:Array, recordThreeIddArr:Array, recordTwoIddArr:Array):void
		{
			var arr2:Vector.<Diamonds>;
			var startNum:int = DiamondType.Rows * DiamondType.Cols - 1;
			var cols:int = DiamondType.Cols;
			var rows:int = DiamondType.Rows;
			for (var i:int = startNum; i > 0; i--)
			{
				var cardCheck:Diamonds = Diamonds(mapTotalDiamondArr[int(i / cols)][i % rows]);
				var boo:Boolean = diamondPropArray.indexOf(cardCheck.id) > -1;
				if (cardCheck.isVisied == false)
				{
					if (boo)
					{
						arr2 = new Vector.<Diamonds>();
						arr2.push(cardCheck);
					}
					else arr2 = searchDiamons(DiamondType.statusDefault, cardCheck);
					if (arr2)
					{
						var leng:int = arr2.length;
						if (leng == 2)
						{
							pushCardInArray(recordTwoCardArr, recordTwoIddArr);
						}
						else if (leng >= 3 || boo)
						{
							pushCardInArray(recordThreeCardArr, recordThreeIddArr);
							if (recordThreeCardArr.length >= 4)
							{
								break;
							}
						}
					}
					arr2		= null;
					cardCheck 	= null;
				}
			}
			setCardIsvisied(recordTwoCardArr);
			setCardIsvisied(recordThreeCardArr);
			
			function pushCardInArray($cardArr:Array, $idArr:Array):void
			{
				$cardArr.push(arr2);
				for each (var c:Diamonds in arr2)
				{
					c.isVisied = true;
					$idArr.push(c.index_i + ":" + c.index_j);
				}
			}
			
			function setCardIsvisied($array:Array):void
			{
				for each (var vec:Vector.<Diamonds> in $array)
				{
					for each (var _card:Diamonds in vec)
					{
						_card.isVisied = false;
					}
				}
			}
		}

		///////////////////////////  钻石消除查询计算方法   ///////////////////////////////////////////////////////////////
		
		/**
		 * 钻石消除查询计算方法
		 * @param $type 查找对象的type
		 * @param $card 点击的查找对象
		 * @return Array
		 * 
		 */
		private function searchDiamons($type:int, $card:Diamonds):Vector.<Diamonds>
		{
			var arr:Vector.<Diamonds> = new Vector.<Diamonds>();
			switch ($type)
			{
				case DiamondType.PropCrossBlue:
					arr = SearchDiamons.findCrossCard(mapTotalDiamondArr, $card);
					break;
				case DiamondType.PropHourglassGreen:
					arr.push($card);
					break;
				case DiamondType.PropSameColorPurple:
					arr = SearchDiamons.findAllPurpleCard(mapTotalDiamondArr, $card);
					break;
				case DiamondType.PropSameColorBlue:
					arr = SearchDiamons.findAllPurpleCard(mapTotalDiamondArr, $card);
					break;
				case DiamondType.PropSameColorGreen:
					arr = SearchDiamons.findAllPurpleCard(mapTotalDiamondArr, $card);
					break;
				case DiamondType.PropSameColorRed:
					arr = SearchDiamons.findAllPurpleCard(mapTotalDiamondArr, $card);
					break;
				case DiamondType.PropSameColorYellow:
					arr = SearchDiamons.findAllPurpleCard(mapTotalDiamondArr, $card);
					break;
				case DiamondType.PropMatrixRed:
					arr = SearchDiamons.findMatrixCard(mapTotalDiamondArr, $card, 5, 5);
					break;
				case DiamondType.PropMatrixYellow:
					arr = SearchDiamons.findMatrixCard(mapTotalDiamondArr, $card, 3, 3);
					break;
				case DiamondType.statusDefault:
					arr = SearchDiamons.findCard(mapTotalDiamondArr, $card);
					break;
				case DiamondType.statusExciting:
					arr = SearchDiamons.findExcitingCard(mapTotalDiamondArr, $card);
					break;
				default:
					arr = SearchDiamons.findCard(mapTotalDiamondArr, $card);
			}
			setAllCardvised();
			return arr;
		}

		////////////////////////////  钻石消除查询计算方法   ///////////////////////////////////////////////////////////////

		/**
		 * 显示得分  记录总得分
		 * @param num 得到的分数
		 */
		private function setScroceTxtAndChange(num:int):void
		{
			var currentScore:int = ScorePrice.resultValue(num);
			addDiamondsNum	 	 = num;
			if (totalResultToServer > 0)
			{
				totalResultToServer *= -1;
				this.dispatchEvent(new MainPanelEvent(MainPanelEvent.CHECK_CHEAT));
			}
			var temp:Number = -(totalResultToServer * 100);
			if (totalResult != temp)
			{
				if (temp < totalResult) totalResult = temp;
				else totalResultToServer = -totalResult * 0.01;
			}
			totalResult			+= currentScore;
			totalResultToServer	-= currentScore * 0.01;
			
			initAndChangeTheScroceRateLength();
		}

		/**
		 * 开始播放使用道具特效动画
		 * @param $cardId id(type)
		 * @param $x 位置x
		 * @param $y 位置y
		 * @param $delay 需要将计时器延迟的时间
		 */
		private function usePropCardPlayEffect($cardId:int, $x:Number, $y:Number, $delayTime:int=0):void
		{
			isUseingProp=true;
			usePropCurrent = true;
			var usePropEffect:UsePropEffect;
			var poolStringName:String = DiamondType.usePropEffectName+$cardId;
			if (DiamondsPool.hasObject(poolStringName))
			{
				usePropEffect = DiamondsPool.getObject(poolStringName) as UsePropEffect;
				usePropEffect.initialization($cardId, $x, $y, usePropEffectCallBack, $delayTime);
			}
			else
			{
				usePropEffect = new UsePropEffect($cardId, $x, $y, usePropEffectCallBack, $delayTime);
			}
			effectContainer.addChild(usePropEffect);
			if (timeNum > 10)
			{
				if (diamondsGameTimer) diamondsGameTimer.pause();
				if (lastTenTimeMusic) lastTenTimeMusic.stop(); 
			}
			else
			{
				if ($cardId == DiamondType.PropHourglassGreen && lastTenTimeMusic)
				{
					lastTenTimeMusic.currentPosition=((10 - timeNum) * 0.1) * lastTenTimeMusic.length;
					lastTenTimeMusic.rePlay();
				}
			}

		}

		/**
		 * 使用道具播放特效后，回调函数
		 * @param $id
		 */
		private function usePropEffectCallBack($cardId:int):void
		{
			lastClickTime = getTimer();
			isUseingProp=false;
			moveAndAddCardFun();
			if (diamondsGameTimer) diamondsGameTimer.start();
			if (timeNum < 10)
			{
				if ($cardId == DiamondType.PropHourglassGreen)
				{
					if (lastTenTimeMusic && lastTenTimeMusic.isRunning == false)
					{
						lastTenTimeMusic.currentPosition=(10 - timeNum) * 0.1 * lastTenTimeMusic.length;
						lastTenTimeMusic.rePlay();
					}
				}
			}
		}

		/**
		 * 随机更换卡片
		 * @param id  卡片的id
		 * @return
		 *
		 */
		private function useProp(id:int):void
		{
			var rndi:int = int(Math.random() * DiamondType.Rows);
			var rndj:int = int(Math.random() * DiamondType.Cols);
			var oldCard:Diamonds = Diamonds(mapTotalDiamondArr[rndi][rndj]);
			
			if (diamondPropArray.indexOf(oldCard.id) == -1)
			{
				var ary:Vector.<Diamonds> = searchDiamons(DiamondType.statusDefault, oldCard);
				if (ary.length > 2 || oldCard.parent == null)
				{
					useProp(id);
					return ;
				}
				oldCard.redraw(id);

				// 道具入场声音
				SounderManager.instance.playSound(SoundType.Sounds453);
			}
			else
			{
				useProp(id);
			}

		}

		/**
		 *游戏结束
		 */
		private function playOver():void
		{
			GamePauseTotalTime.pauseTime();
			clearVars();
			
			if (playOverCallFunction != null)
			{
				playOverCallFunction.apply(this);
				playOverCallFunction = null;
			}
			
			SceneManager.instance.removeChild(this);
			
		}

		/**
		 * 判断指定的目标对象能否替换
		 * @param $card 需要判断替换的目标对象
		 * @return  Boolean
		 */
		private function canReplaceDiamond($card:Diamonds):Boolean
		{
			if (DiamondType.diamondTypeArray.indexOf($card.id) >= 0) return true;
			else return false;
		}

		/**
		 * 5*5范围消除，remove时的抖动效果
		 * @param $arr 
		 */
		private function shakeMatrixDiamond($arr:Vector.<Diamonds>):void
		{
			insideDiamArr = new Vector.<Diamonds>();
			outerDiamArr = new Vector.<Diamonds>();
			var leng:int=$arr.length;
			var diamond:Diamonds=$arr[0] as Diamonds;
			var idi:int=diamond.index_i;
			var idj:int=diamond.index_j;
			insideDiamArr.push(diamond);
			for (var i:int=1; i < leng; i++)
			{
				diamond = $arr[i] as Diamonds;
				var idx:int = diamond.index_i;
				var idy:int = diamond.index_j;
				if ((idi == idx && idj + 1 == idy) || (idi == idx && idj - 1 == idy) || 
					(idj == idy && idi + 1 == idx) || (idj == idy && idi - 1 == idx) || 
					(idi + 1 == idx && idj + 1 == idy) || (idi + 1 == idx && idj - 1 == idy) || 
					(idi - 1 == idx && idj + 1 == idy) || (idi - 1 == idx && idj - 1 == idy))
				{
					insideDiamArr.push(diamond);
				}
				else
				{
					outerDiamArr.push(diamond);
				}
			}
			var shakeTimer:Timer=new Timer(int(usePropDelayTime / 6), 6);
			shakeTimer.addEventListener(TimerEvent.TIMER, shakeMatrixDiamondUpdateTimerHandler);
			shakeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, shakeMatrixDiamondCompletedTimerHandler);
			shakeTimer.start();
			shakeTimer = null;
		}
		
		/**
		 * 根据是否使用时间停止道具进行控制当前的对象是移除还是重新绘制一个空白的对象
		 * @param $card 
		 */
		private function removeOrRedrawDiamon($card:Diamonds):void
		{
			if (isTimeOverStop)
			{
				$card.redraw(DiamondType.statusBlank);
			}
			else 
			{
				var t_id:int = $card.id;
				$card.rotation = 0;
				if (DiamondType.diamondTypeArray.indexOf(t_id) >= 0)
				{
					DiamondsPool.setObject($card, poolString + t_id);
				}
				$card.removeDiamonds();
			}
		}
		
		////////////////////////////// events ////////////////////////////////
		
		/**
		 * 增加鼠标侦听事件
		 */
		private function addEvents():void
		{
			diamondsContainer.mouseChildren = false;
			diamondsContainer.mouseEnabled = true;
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			menuElements.menuBtn.addEventListener(MouseEvent.CLICK, btnMenuClickHandler);
			
			if (Multitouch.supportsTouchEvents)
			{
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
				diamondsContainer.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchHandler);
				diamondsContainer.mouseChildren = true;
				diamondsContainer.mouseEnabled = false;
			}
			else 
			{
				Multitouch.inputMode = MultitouchInputMode.NONE;
				diamondsContainer.addEventListener(MouseEvent.MOUSE_DOWN, onClickHandler);
				diamondsContainer.buttonMode = true;
				diamondsContainer.mouseChildren = true;
				diamondsContainer.mouseEnabled = false;
			}
		}
		
		/**
		 * 移除鼠标侦听事件
		 */
		private function removeEvent():void
		{
			Multitouch.inputMode = MultitouchInputMode.NONE;
			
			diamondsContainer.removeEventListener(MouseEvent.MOUSE_DOWN, onClickHandler);
			
			diamondsContainer.removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchHandler);
			
			menuElements.menuBtn.removeEventListener(MouseEvent.CLICK, btnMenuClickHandler);
		}
		
		private function removedFromStageHandler(e:Event):void
		{
			isTimeOverStop = false;
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			while (diamondsContainer.numChildren > 0)
			{
				var dis:DisplayObject = diamondsContainer.getChildAt(0);
				if (dis is Diamonds)
					removeOrRedrawDiamon(Diamonds(dis));
				else
					diamondsContainer.removeChildAt(0);
			}
		}
		
		private function btnMenuClickHandler(e:MouseEvent):void
		{
			if (isUseingProp == false)
			{
				startAndStopTimer(false);
				PanelManager.instance.addPanel(GamePausePanel.instance);
				GamePausePanel.instance.initialization();
				GamePausePanel.instance.exitCallBackFun = exitGameFun;
				GamePausePanel.instance.continueCallBackFun = continueGameFun;
			}
		}
		
		private function exitGameFun():void
		{
			playOver();
			PanelManager.instance.removePanel(GamePausePanel.instance);
		}
		
		private function continueGameFun():void
		{
			startAndStopTimer(true);
			PanelManager.instance.removePanel(GamePausePanel.instance);
		}
		
		private function initObjectsCompletedHandler(e:TweenEvent):void
		{
			e.target.removeEventListener(TweenEvent.COMPLETE, initObjectsCompletedHandler);
		}
		
		private function readyResEnterEventHandler(e:Event):void
		{
			if (readyRes.currentFrame == readyRes.totalFrames)
			{
				readyRes.stop();
				readyRes.removeEventListener(Event.ENTER_FRAME, readyResEnterEventHandler);
				readyRes.parent.removeChild(readyRes);
				readyRes=null;
				goResInitialization();
			}
		}
		
		private function goResEnterEventHandler(e:Event):void
		{
			if (goRes.currentFrame == goRes.totalFrames)
			{
				setMouseEnbled(true);
				canClick=true;
				goRes.stop();
				goRes.removeEventListener(Event.ENTER_FRAME, goResEnterEventHandler);
				goRes.parent.removeChild(goRes);
				goRes=null;
				addEvents();
				lastClickTime=getTimer();
				// 计时器启动  开始计时
				
				diamondsGameTimer.start();
				
				// 自动点击测试程序
				if (Global.isOpenAutoClickProgram) autoClickDiamons();
			}
		}
		private var autoClickTimer:Timer;
		private function autoClickDiamons():void
		{
			autoClickTimer = new Timer(300);
			autoClickTimer.addEventListener(TimerEvent.TIMER, autoClickDiamondsHandler);
			autoClickTimer.start();
		}
		
		private function clearAutoClickTImer():void
		{
			if (autoClickTimer)
			{
				autoClickTimer.stop();
				autoClickTimer.removeEventListener(Event.ENTER_FRAME, autoClickDiamondsHandler);
				autoClickTimer = null;
			}
		}
		
		private function autoClickDiamondsHandler(e:TimerEvent):void
		{
			autoClickTestProgram();
		}
		
		private function initCardsObjectSingleHandler(e:TweenEvent):void
		{
			TweenMax.killTweensOf(e.target.target);
			// 宝石掉落的声音
			SounderManager.instance.playSound(SoundType.Sounds613);
		}
		
		private function tempTimerMaxHandler(e:TimerEvent):void
		{
			var timerInit:Timer = e.target as Timer;
			if (tweenTotalArr.length == 0)
			{
				timerInit.removeEventListener(TimerEvent.TIMER, tempTimerMaxHandler);
				timerInit.stop();
			}
			else
			{
				var num:int = timerInit.currentCount;
				playLayoutTimeLine();
			}
			timerInit=null;
		}
		
		/**
		 * 5*5范围消除，remove时的抖动效果 timer 侦听器
		 * @param e
		 */
		private function shakeMatrixDiamondUpdateTimerHandler(e:TimerEvent):void
		{
			var tempRotation:Number = 0;
			var currCard:Diamonds;
			for each (currCard in insideDiamArr)
			{
				tempRotation = Math.random() * 2 < 1 ? -5 : 5;
				currCard.rotation = tempRotation;
			}
			for each (currCard in outerDiamArr)
			{
				tempRotation = Math.random() * 2 < 1 ? -5 : 5;
				currCard.rotation = tempRotation;
			}
		}
		
		/**
		 * 5*5范围消除，remove时的抖动效果 timer 侦听器
		 * @param e
		 */
		private function shakeMatrixDiamondCompletedTimerHandler(e:TimerEvent):void
		{
			var timerL:Timer=e.target as Timer;
			timerL.removeEventListener(TimerEvent.TIMER, shakeMatrixDiamondUpdateTimerHandler);
			timerL.removeEventListener(TimerEvent.TIMER_COMPLETE, shakeMatrixDiamondCompletedTimerHandler);
			timerL.stop();
			timerL=null;
			
			var currCard:Diamonds;
			for each (currCard in insideDiamArr)
			{
				createRemoveEffect(currCard.x, currCard.y, false);
				removeOrRedrawDiamon(currCard);
			}
			for each (currCard in outerDiamArr)
			{
				createRemoveEffect(currCard.x, currCard.y, false);
				removeOrRedrawDiamon(currCard);
			}
			currCard = null;
			
		}
		
		private function createRemoveEffect($xx:Number, $yy:Number, $isExciting:Boolean=false):void
		{
			var removeEffect:DiamondsRemoveEffect;
			var namePool:String = $isExciting ? DiamondType.excitingEffectName : DiamondType.generalEffectName;
			if (DiamondsPool.hasObject(namePool))
			{
				removeEffect = DiamondsPool.getObject(namePool) as DiamondsRemoveEffect;
				removeEffect.gotoPlay(namePool, $xx, $yy);
			}
			else
			{
				removeEffect = new DiamondsRemoveEffect(namePool, $xx, $yy, $isExciting);
			}
			removeEffectContainer.addChild(removeEffect);
		}
		
		private function timerExcitementTimeCompleteHandler():void
		{
			isExcitementStart = false;
			continueRemoveNum = 0;
			dispelPane.bg.gotoAndStop(1);
			clearFireBurnMusic();
		}
		
		/**
		 * 缓动结束后，消除缓，并把该卡片从数组中除去
		 * @param card 要消除的缓动
		 */
		private function addCardsObjectSingleHandler(e:TweenEvent):void
		{
			var target:DisplayObject = e.target.target as DisplayObject;
			TweenMax.killTweensOf(target);
			
			// 宝石掉落的声音
			SounderManager.instance.playSound(SoundType.Sounds613);
		}
		
		private function addObjectsCompletedHandler(e:TweenEvent):void
		{
			e.target.removeEventListener(TweenEvent.COMPLETE, addObjectsCompletedHandler);
		}
		
		private function addSixSecondsResEnterEventHandler(e:Event):void
		{
			if (addSixSecondsRes == null) return;
			if (addSixSecondsRes.currentFrame == addSixSecondsRes.totalFrames)
			{
				addSixSecondsRes.removeEventListener(Event.ENTER_FRAME, addSixSecondsResEnterEventHandler);
				addSixSecondsRes.gotoAndStop(1);
				addSixSecondsRes.visible=false;
			}
		}
		
		private function cutTimeAnimationResEnterHandler(e:Event):void
		{
			if (cutTimeAnimationRes == null)
				return;
			if (cutTimeAnimationRes.currentFrame == cutTimeAnimationRes.totalFrames)
			{
				cutTimeAnimationRes.removeEventListener(Event.ENTER_FRAME, cutTimeAnimationResEnterHandler);
				cutTimeAnimationRes.gotoAndStop(1);
				cutTimeAnimationRes.visible=false;
			}
		}
		
		private function moveObjctSingleHandler(e:TweenEvent):void
		{
			var target:DisplayObject = e.target.target as DisplayObject;
			TweenMax.killTweensOf(target);
		}
		
		private function setMouseEnbled($enbled:Boolean):void
		{
			this.stage.mouseChildren = this.mouseEnabled = $enbled;
		}
		
		private function timeUpResEnterEventHandler(e:Event):void
		{
			if (timeUpRes.currentFrame == timeUpRes.totalFrames)
			{
				timeUpRes.stop();
				timeUpRes.removeEventListener(Event.ENTER_FRAME, timeUpResEnterEventHandler);
				timeUpRes.parent.removeChild(timeUpRes);
				timeUpRes=null;
				
				playOver();
			}
		}
		private var startTimeNumber:Number;
		/**
		 * 监听点击事件
		 * @param e
		 */
		private function onClickHandler(e:MouseEvent):void
		{
			if (!canClick) return;
			setMouseEnbled(false);
			startTimeNumber = getTimer();
			if (diamondsContainer.mouseChildren)
			{
				if (e.target is Diamonds)
				{
					clickTargetSeekJudge(e.target as Diamonds);
				}
			}
			else
			{
				checkClickTargetDiamond(e.currentTarget.mouseX, e.currentTarget.mouseY);
			}
		}
		
		private function onTouchHandler(e:TouchEvent):void
		{
			if (!canClick) return;
			setMouseEnbled(false);
			startTimeNumber = getTimer();
			if (diamondsContainer.mouseChildren)
			{
				if (e.target is Diamonds)
				{
					clickTargetSeekJudge(e.target as Diamonds);
				}
			}
			else
			{
				checkClickTargetDiamond(e.localX, e.localY);
			}
		}
		
		private function checkClickTargetDiamond($mouseX:Number, $mouseY:Number):void
		{
			var index_x:uint = int(($mouseY + Diamonds.DIAMONDS_WIDTH_HALF) / Diamonds.DIAMONDS_WIDTH);
			var index_y:uint = int(($mouseX + Diamonds.DIAMONDS_HEIGHT_HALF) / Diamonds.DIAMONDS_HEIGHT);
			index_x = index_x < DiamondType.Cols ? index_x < 0 ? 0 : index_x : DiamondType.Cols - 1;
			index_y = index_y < DiamondType.Rows ? index_y < 0 ? 0 : index_y : DiamondType.Rows - 1;
			var tempArray:Array = mapTotalDiamondArr[index_x];
			if (tempArray == null || (tempArray && tempArray[index_y] == null)) return ;
			var diamond:Diamonds = tempArray[index_y] as Diamonds;
			
			clickTargetSeekJudge(diamond);
		}
		
		private function clickTargetSeekJudge($diamond:Diamonds):void
		{
			$diamond.isVisied = true;
			removeSuccessed = false;
			isNeedPromp = true;
			canClick = false;
			killTween();
			
			var diamondID:int = $diamond.id;
			var isExcitement:Boolean = false;
			$diamond.isClickProp = true;
			var diamonsDisposeArr:Vector.<Diamonds> = searchDiamons(diamondID, $diamond);
			if (checkCurrentClickIsRight(diamonsDisposeArr, $diamond) == false) // 无效点击 则return
			{
				$diamond.isVisied = false;
				diamonsDisposeArr = null;
				return ;
			}
			if (DiamondType.diamondPropSameColor.indexOf(diamondID) >= 0 || DiamondType.diamondPropArray.indexOf(diamondID) >= 0)
			{
				accountNumClick();
			}
			else
			{
				$diamond.isClickProp = false;
				diamondID = DiamondType.statusDefault;
				if (diamonsDisposeArr.length > 2)
				{
					accountNumClick();
					if (continueRemoveNum == excitementNumber)
					{
						if (isExcitementStart == false)
						{
//							dispelPane.bg.gotoAndPlay("beginlab");
//							playFrameResourceEffect();
							initExcitementSomeVars();
						}
					}
					else if (continueRemoveNum > excitementNumber)
					{
//						animationContainer.gotoAndPlay(1);
//						playFrameResourceEffect();
						diamondID = DiamondType.statusExciting;
						isExcitement = true;
						diamonsDisposeArr = SearchDiamons.findExcitingCardHasFindArray(mapTotalDiamondArr, diamonsDisposeArr);
					}
					else
					{
						animationContainer.gotoAndStop(1);
						dispelPane.bg.gotoAndStop(1);
					}
				}
			}
			removeCard(diamonsDisposeArr, $diamond, isExcitement);
		}
		
		private function playFrameResourceEffect():void
		{
			var currentLabel:String = dispelPane.bg.currentLabel;
			if (currentLabel != "beginlab" && currentLabel != "lab7")
			{
				dispelPane.bg.gotoAndPlay("lab7");
			}
		}
		
		/**
		 *  定时器处理函数
		 * @param evt
		 * @return 
		 */
		private function diamondsGameTimerCallFunction():void
		{
			// 进入极速状态
			if (isExcitementStart)
			{
				theExcitingTimeSecond--;
				if (theExcitingTimeSecond <= 0)
				{
					timerExcitementTimeCompleteHandler();
				}
			}
			
			timeNum--;
			setGameTimeChange();
			
			//同化
//			if (timeNum > 0 && timeNum % 4 == 0)  assimilation();
			
			if (timeNum == 10)
			{
				gameTimeEqualTen10();
			}
			else if (timeNum > 10 && lastTenTimeMusic)
			{
				lastTenTimeMusic.stop();
			}
			else if (timeNum < 10)
			{
				gameTimeLessThanTen10();
			}
			
			if (timeNum <= 0)
			{
				gameTimeIsOver();
				timeNum = 60;
			}
			// 
			autoPrompCanClickTarget();
		}
		
		private function setGameTimeChange():void
		{
			var frame:int = 60 - timeNum;
			frame = frame > 0 ? frame : 60;
			menuElements.clockMc.gotoAndStop(frame);
			menuElements.timeTxt.text = timeNum > 60 ? "60" : timeNum.toString();
		}
		
		private function gameTimeEqualTen10():void
		{
			if (lastTenTimeMusic == null)
			{
				if (Global.isOpenMusic) lastTenTimeMusic = new SingleMusic(SoundType.Sounds454); 
			}
			else
			{
				lastTenTimeMusic.stop();
				lastTenTimeMusic.currentPosition=0;
				lastTenTimeMusic.rePlay();
			}
		}
		
		private function gameTimeLessThanTen10():void
		{
			if (lastTenTimeMusic == null && Global.isOpenMusic)
			{
				lastTenTimeMusic=new SingleMusic(SoundType.Sounds454);
				lastTenTimeMusic.pause();
				lastTenTimeMusic.currentPosition=(10 - timeNum) * 0.1 * lastTenTimeMusic.length;
				lastTenTimeMusic.rePlay();
			}
		}
		
		private function gameTimeIsOver():void
		{
			var tempNum:int = ((getTimer() - lastClickTime) / 1000);
			tempNum = tempNum < 2 ? 0 : tempNum;
			timePropNum += int(tempNum / 6) + 1;
			
			clearAutoClickTImer();
			canClick=false;
			clearVars();
			diamondsContainer.mouseEnabled = diamondsContainer.mouseChildren = false;
			isTimeOverStop = true;
			initAndCreateTimeUpRes();
			GamePauseTotalTime.startTime();
		}
		
		private function initAndCreateTimeUpRes():void
		{
			if (timeUpRes == null)
			{
				timeUpRes = this.createUIItem(DiamondType.TYPE_RESOURCE_DISPEL_WORDS_TIMESUP) as MovieClip;
				setReadyGoTimesUpWordsPoint(timeUpRes);
			}
			timeUpRes.gotoAndStop(1);
			if (timeUpRes.parent == null)
			{
				this.addChild(timeUpRes);
			}
			timeUpRes.addEventListener(Event.ENTER_FRAME, timeUpResEnterEventHandler);
			timeUpRes.gotoAndPlay(1);
		}
		
		private function autoPrompCanClickTarget():void
		{
			if (lastCheckTime == -1) lastCheckTime = getTimer();
			// 是否需要提示可点击的有效的钻石组
			if (getTimer() - lastClickTime > prompCardDelayTime && isNeedPromp)
			{
				var card:Diamonds;
				var array:Array;
				for each (array in mapTotalDiamondArr)
				{
					for each (card in array)
					{
						if (card)
						{
							if (autoPromptTargetChangeToEffect(card)) return ;
						}
					}
				}
				assimilation();
			}
		}
		
		private function autoPromptTargetChangeToEffect($diamond:Diamonds):Boolean
		{
			var arrPrompt:Vector.<Diamonds>;
			arrPrompt = searchDiamons(DiamondType.statusDefault, $diamond);
			if (arrPrompt && arrPrompt.length >= 3)
			{
				isNeedPromp=false;
				for each ($diamond in arrPrompt)
				{
					$diamond.prompEffect();
				}
				return true;
			}
			arrPrompt=null;
			
			return false;
		}
		
		private function autoClickTestProgram():void
		{
			if (canClick)
			{
				startTimeNumber = getTimer();
				var rows:int = DiamondType.Rows - 1;
				var cols:int = DiamondType.Cols - 1;
				for (var i:int = rows; i >= 0; i--)
				{
					for (var j:int = cols; j >= 0; j--)
					{
						var tempcard:Diamonds=mapTotalDiamondArr[i][j] as Diamonds;
						if (this.searchDiamons(tempcard.id, tempcard).length >= 3 || DiamondType.diamondPropArray.indexOf(tempcard.id) > -1)
						{
							clickTargetSeekJudge(tempcard);
//							trace("autoClickTestProgram:"+(getTimer() - startTimeNumber));
							return ;
						}
					}
				}
			}
		}
		
		
		
		////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////// 辅助测试部分 ///////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////
		
		
		private function test_AddEvents():void
		{
			setOpenProp([]);
			menuElements.t1.text = "停用道具";
			menuElements.t2.text = "标准难度";
			menuElements.t3.text = "正常状态";
			menuElements.t4.text = "停用自动点击";
			
			if (Multitouch.supportsTouchEvents)
			{
				menuElements.btn1.addEventListener(TouchEvent.TOUCH_END, btn1OnTouch);
				menuElements.btn2.addEventListener(TouchEvent.TOUCH_END, btn2OnTouch);
				menuElements.btn3.addEventListener(TouchEvent.TOUCH_END, btn3OnTouch);
				menuElements.btn4.addEventListener(TouchEvent.TOUCH_END, btn4OnClick);
				menuElements.btn5.addEventListener(TouchEvent.TOUCH_END, btn5OnTouch);
			}
			else
			{
				menuElements.btn1.addEventListener(MouseEvent.CLICK, btn1OnClick);
				menuElements.btn2.addEventListener(MouseEvent.CLICK, btn2OnClick);
				menuElements.btn3.addEventListener(MouseEvent.CLICK, btn3OnClick);
				menuElements.btn4.addEventListener(MouseEvent.CLICK, btn4OnClick);
				menuElements.btn5.addEventListener(MouseEvent.CLICK, btn5OnClick);
			}
			
		}
		
		private function test_RemoveEvents():void
		{
			if (Multitouch.supportsTouchEvents)
			{
				menuElements.btn1.removeEventListener(TouchEvent.TOUCH_END, btn1OnTouch);
				menuElements.btn2.removeEventListener(TouchEvent.TOUCH_END, btn2OnTouch);
				menuElements.btn3.removeEventListener(TouchEvent.TOUCH_END, btn3OnTouch);
				menuElements.btn4.removeEventListener(TouchEvent.TOUCH_END, btn4OnClick);
				menuElements.btn5.removeEventListener(TouchEvent.TOUCH_END, btn5OnTouch);
			}
			else
			{
				menuElements.btn1.removeEventListener(MouseEvent.CLICK, btn1OnClick);
				menuElements.btn2.removeEventListener(MouseEvent.CLICK, btn2OnClick);
				menuElements.btn3.removeEventListener(MouseEvent.CLICK, btn3OnClick);
				menuElements.btn4.removeEventListener(MouseEvent.CLICK, btn4OnClick);
				menuElements.btn5.removeEventListener(MouseEvent.CLICK, btn5OnClick);
			}
		}
		
		private function btn1OnClick(e:MouseEvent):void
		{
			// 开启道具
			fun1();
		}
		
		private function btn2OnClick(e:MouseEvent):void
		{
			// 降低极速难度
			fun2();
		}
		
		private function btn3OnClick(e:MouseEvent):void
		{
			 // 持续游戏
			fun3();
		}		
		
		private function btn4OnClick(e:MouseEvent):void
		{
			// 启停自动点击
			fun4();
		}		
		
		private function btn5OnClick(e:MouseEvent):void
		{
			// 启停自动点击
			fun5();
		}	
		
		private function btn1OnTouch(e:TouchEvent):void
		{
			// 开启道具
			fun1();
		}
		
		private function btn2OnTouch(e:TouchEvent):void
		{
			// 降低极速难度
			fun2();
		}
		
		private function btn3OnTouch(e:TouchEvent):void
		{
			// 持续游戏
			fun3();
		}		
		
		private function btn4OnTouch(e:TouchEvent):void
		{
			// 启停自动点击
			fun4();
		}		
		
		private function btn5OnTouch(e:TouchEvent):void
		{
			// 启停自动点击
			fun5();
		}	
		
		private function fun1():void
		{
			if (Global.isDebug)
			{
				if (diamondPropArray.length > 0)
				{
					menuElements.t1.text = "停用道具"
					setOpenProp([]);
				}
				else
				{
					menuElements.t1.text = "启用道具";
					setOpenProp(DiamondType.diamondPropArray);
				}
				menuElements.t5.text = "非默认";
			}
		}	
		
		private function fun2():void
		{
			if (Global.isDebug)
			{
				clickIntervalTime += 500;
				
				menuElements.t2.text = "已调整";
				menuElements.t5.text = "非默认";
			}
		}	
		
		private function fun3():void
		{
			if (Global.isDebug)
			{
				timeNum = int.MAX_VALUE;
				menuElements.t3.text = "已调整";
				menuElements.t5.text = "非默认";
			}
		}	
		
		private function fun4():void
		{
			if (Global.isDebug)
			{
				if (autoClickTimer)
				{
					clearAutoClickTImer();
				}
				else
				{
					autoClickDiamons();
				}
				menuElements.t4.text = "已调整";
				menuElements.t5.text = "非默认";
			}
		}	
		
		private function fun5():void
		{
			if (Global.isDebug)
			{
				timeNum = 60;
				clickIntervalTime = 1100;
				setOpenProp([]);
				clearAutoClickTImer();
				
				
				menuElements.t1.text = "停用道具";
				menuElements.t2.text = "标准难度";
				menuElements.t3.text = "正常状态";
				menuElements.t4.text = "停用自动点击";
				menuElements.t5.text = "默认";
			}
		}
		
		

	}
}
