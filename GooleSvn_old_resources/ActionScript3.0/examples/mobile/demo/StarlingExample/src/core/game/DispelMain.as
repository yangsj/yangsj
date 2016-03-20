package core.game
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenAlign;
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	import com.greensock.events.TweenEvent;
	
	import core.Pool;
	import core.game.resource.Diamonds;
	import core.game.resource.DispelBgFrameBlaze;
	import core.game.vo.AddDiamondsVO;
	import core.game.vo.MoveDiamondsVO;
	import core.game.vo.RecordDiamondsNumVO;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class DispelMain extends Sprite
	{
		private var container:Sprite;
		private var dispelBgFrameBlaze:DispelBgFrameBlaze;
		private var diamondsContainer:Sprite;
		private var effectsContainer:Sprite;
		
		
		/** 记录所有钻石对象 */
		private var diamondsArray:Array;
		
		/** 开始时布局记录所有的TweenMax缓动对象 */
		private var tweenTotalArray:Array;
		
		/** 添加新钻石 Array */
		private var addNewDiamondArr:Vector.<AddDiamondsVO>;
		
		/** 下移动钻石 Array */
		private var moveOldDiamondArr:Vector.<MoveDiamondsVO>;
		
		/** 是否能够点击 */
		private var canClick:Boolean = true;
		
		private var setIntervalID:uint;
		
		public function DispelMain()
		{
			super();
			
			createResource();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.x = (this.stage.stageWidth - this.width) * 0.5;
			this.y = (this.stage.stageHeight- this.height)* 0.5;
			
			// start
			createLayout();
			addEvents();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		private function createResource():void
		{
			// container
			container = new Sprite();
			diamondsContainer = new Sprite();
			effectsContainer = new Sprite();
			diamondsContainer.x = effectsContainer.x = 89;
			diamondsContainer.y = effectsContainer.y = 85;
			
			// resource
			dispelBgFrameBlaze = new DispelBgFrameBlaze();
			
			// addChild
			container.addChild(dispelBgFrameBlaze);
			container.addChild(diamondsContainer);
			container.addChild(effectsContainer);
			
			this.addChild(container);
			
			// set enabled
//			diamondsContainer.useHandCursor = true;
			effectsContainer.touchable = false;
		}
		
		private function createLayout():void
		{
			const diamondsLength:int = DispelMainType.DIAMOND_COLOR_NUM;
			const rows:int = DispelMainType.ROWS;
			const cols:int = DispelMainType.COLS;
			const D_W:Number = Diamonds.WIDTH;
			const D_H:Number = Diamonds.HEIGHT;
			const POOL_NAME:String = Diamonds.DIAMOND_POOL_NAME;
			var i:int, j:int;
			if (diamondsArray == null) diamondsArray = new Array(rows);
			if (tweenTotalArray == null) tweenTotalArray = new Array(rows);
			var index:int = 0;
			for (j = 0; j < cols; j++)
			{
				var tempArrTimeLine:Array=[];
				var tempTimeLineMax:TimelineMax = new TimelineMax();
				for (i = rows - 1; i >= 0; i--)
				{
					index ++;
					
					if (diamondsArray[i] == null) diamondsArray[i] = [];
					
					var id:int	= int(Math.random() * diamondsLength) + 1;
					var end_x:Number = j * D_W;
					var end_y:Number = i * D_H;
					var poolNamestr:String = POOL_NAME + id;
					var diamond:Diamonds;
					if (Pool.hasObject(poolNamestr)) 
						diamond = Pool.getObject(poolNamestr) as Diamonds; 
					else  
						diamond = new Diamonds(id); 
					diamondsContainer.addChild(diamond);
					diamond.x		= end_x;
					diamond.y		= -200 - (rows - i) * D_H;
					diamond.end_y	= end_y;
					diamond.setRowsCols(i, j);
					diamondsArray[i][j] = diamond;
					
					var delay:Number = 0.05 * ((rows - i) + j);
					var tween:Tween = new Tween(diamond, 0.5);
					tween.moveTo(end_x, end_y);
					tween.delay = delay;
					tween.onComplete = onComplete;
					tween.onCompleteArgs = [tween, index == rows * cols];
					Starling.juggler.add(tween); 
				}
			}
		}
		
		private function onComplete(tween:Tween, isOver:Boolean):void
		{
			Starling.juggler.remove(tween);
			if (isOver)
			{
				
			}
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function addEvents():void
		{
			diamondsContainer.addEventListener(TouchEvent.TOUCH, onTouchHandler);
		}
		
		private function removeEvents():void
		{
			diamondsContainer.removeEventListener(TouchEvent.TOUCH, onTouchHandler);
		}
		
		private function onTouchHandler(event:TouchEvent):void
		{
			var target:DisplayObject = event.currentTarget as DisplayObject;
			var touch:Touch = event.getTouch(target);
			
			if (touch)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					const rows:int = DispelMainType.ROWS;
					const cols:int = DispelMainType.COLS;
					var point:Point = target.globalToLocal(new Point(touch.previousGlobalX, touch.previousGlobalY));
					var index_x:uint = int(point.y / Diamonds.HEIGHT);
					var index_y:uint = int(point.x / Diamonds.WIDTH);
					index_x = index_x < cols ? index_x < 0 ? 0 : index_x : cols - 1;
					index_y = index_y < rows ? index_y < 0 ? 0 : index_y : rows - 1;
					var tempArray:Array = diamondsArray[index_x];
					if (tempArray == null || (tempArray && tempArray[index_y] == null)) return ;
					var diamond:Diamonds = tempArray[index_y] as Diamonds;
					
					clickTargetSeekJudge(diamond);
				}
			}
		}		
		
		private function clickTargetSeekJudge($diamond:Diamonds):void
		{
			$diamond.isSeeked = true;
			canClick = false;
			
			var diamondID:int = $diamond.id;
			var diamonsDisposeArr:Vector.<Diamonds> = SearchDiamons.findCard(diamondsArray, $diamond);
			
			if (diamonsDisposeArr.length < 3)
			{
				// 未达到移除条件
				for each ($diamond in diamonsDisposeArr)
				{
					$diamond.clickError();
				}
				return ;
			}
			else
			{
				for each (var array:Array in diamondsArray)
				{
					for each (var diamond:Diamonds in array)
					{
						if (diamond)
						{
							Starling.juggler.removeTweens(diamond);
							diamond.y = diamond.end_y;
						}
					}
				}
				
				// 达到移除条件
				removeCard(diamonsDisposeArr, $diamond);
			}
		}
		
		private function removeCard($checkResultArray:Vector.<Diamonds>, $diamond:Diamonds):void
		{
			if ($checkResultArray)
			{
				var cardID:int = $diamond.id;
				var localX:Number = $diamond.x;
				var localY:Number = $diamond.y;
				
				addNewDiamondArr = new Vector.<AddDiamondsVO>();
				moveOldDiamondArr = new Vector.<MoveDiamondsVO>();
				
				var tempDiamond:Diamonds;
				var recordDiamondsVO:RecordDiamondsNumVO;
				var changCardNumArr:Vector.<RecordDiamondsNumVO> = new Vector.<RecordDiamondsNumVO>();
				for each (tempDiamond in $checkResultArray)
				{
					var rows:int = tempDiamond.rows;
					var cols:int = tempDiamond.cols;
					var t_id:int = tempDiamond.id;
					var isInCCNA:Boolean=false;
					
					setMoveDiamondsVO($checkResultArray, rows, cols);
					setAddDiamondsVO(cols);
					
					createRemoveEffect(tempDiamond.x, tempDiamond.y);
					removeOrRedrawDiamon(tempDiamond);
					
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
				$checkResultArray = null;
				
				playClickSoundType($diamond);
			}
		}
		
		private function setMoveDiamondsVO(tempCheckResultArray:Vector.<Diamonds>, $index_i:int, $index_j:int):void
		{
			if ($index_i < 0) return ;
			var i:int;
			for (i = $index_i; i > 0; i--)
			{
				/** 移出卡片上面的所有卡片 */
				var tempCard:Diamonds = diamondsArray[i - 1][$index_j] as Diamonds;
				/**判断要移动的卡片是否在要移出的卡片数组中 */
				var isInArr:Boolean = Boolean(tempCheckResultArray.indexOf(tempCard) > -1);
				if (!isInArr)
				{
					/** 判断要移动的卡片是否已经在移动的卡片数组中,如果是则移动位置加1，否则添加到数组中 */
					var isInMoveCardArr:Boolean = false;
					var objvo:MoveDiamondsVO;
					var rows:int = tempCard.rows;
					var cols:int = tempCard.cols;
					for each (objvo in moveOldDiamondArr)
					{
						if (objvo.i == rows && objvo.j == cols)
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
						objvo.i = rows;
						objvo.j = cols;
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
		
		private function createRemoveEffect($xx:Number, $yy:Number):void
		{
//			var removeEffect:DiamondsRemoveEffect;
//			var namePool:String = DispelMainType.generalEffectName;
//			if (Pool.hasObject(namePool))
//			{
//				removeEffect = DiamondsPool.getObject(namePool) as DiamondsRemoveEffect;
//				removeEffect.gotoPlay(namePool, $xx, $yy);
//			}
//			else
//			{
//				removeEffect = new DiamondsRemoveEffect(namePool, $xx, $yy, $isExciting);
//			}
//			removeEffectContainer.addChild(removeEffect);
		}
		
		/**
		 * 根据是否使用时间停止道具进行控制当前的对象是移除还是重新绘制一个空白的对象
		 * @param $card 
		 */
		private function removeOrRedrawDiamon($card:Diamonds):void
		{
			var t_id:int = $card.id;
			$card.rotation = 0;
			$card.removedFromStage();
		}
		
		private function playClickSoundType($diamond:Diamonds):void
		{
			var cardID:int = $diamond.id;
			var localX:Number = $diamond.x;
			var localY:Number = $diamond.y;
			setIntervalID=flash.utils.setTimeout(moveAndAddCardFun, 50);
		}
		
		/**
		 *移动和增加卡片
		 *
		 */
		private function moveAndAddCardFun():void
		{
			flash.utils.clearTimeout(setIntervalID);
			moveCard(moveOldDiamondArr);
			addCard(addNewDiamondArr);
			moveOldDiamondArr=null;
			addNewDiamondArr=null;
			canClick=true;
		}
		
		/**
		 * 移动卡片
		 * @param mcs 移动卡片的数组
		 *
		 */
		private function moveCard(mcs:Vector.<MoveDiamondsVO>):void
		{
			if (mcs)
			{
				var mcsObj:MoveDiamondsVO;
				for each (mcsObj in mcs)
				{
					var tempCard:Diamonds = mcsObj.diamond;
					var moveNum:int = mcsObj.moveDistance;
					var oldI:int = tempCard.rows;
					var oldJ:int = tempCard.cols;
					var newI:int = oldI + moveNum;
					var endY:Number = tempCard.y + Diamonds.HEIGHT * moveNum;
					diamondsArray[newI][oldJ] = tempCard;
					tempCard.end_y = endY;
					tempCard.setRowsCols(newI, oldJ);
					
					var tween:Tween = new Tween(tempCard, 0.2, Transitions.EASE_OUT_ELASTIC);
					tween.onComplete = tweenKill;
					tween.onCompleteArgs = [tween];
					tween.animate("y", endY);
					tween.delay = 0.01 * (DispelMainType.ROWS - oldI);
					Starling.juggler.add(tween);
				}
			}
			mcs=null;
		}
		
		private function tweenKill(tween:Tween):void
		{
			Starling.juggler.remove(tween);
		}
		
		/**
		 * 填充卡片
		 * @param addCardArr 填充卡片的数组
		 *
		 */
		private function addCard(addCardArr:Vector.<AddDiamondsVO>):void
		{
			if (addCardArr)
			{
				var i:int;
				var addov:AddDiamondsVO;
				var arrTempProp:Array=[];/* 临时存储添加的钻石类型 */
				var arrTempId:Array=[0, 1, 2, 3, 4];/* 定义一个数组序列号 */
				var diamondTypeArray:Array = [1, 2, 3, 4, 5];
				var leng:int = 3;
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
					for (i = num; i >= 0; i--)
					{
						var t_diamond:Diamonds;
						var rnd:int	= int(Math.random() * leng);
						var id:int	= arrTempProp[rnd];
						var moveAfterEnd_y:Number = i * Diamonds.HEIGHT;
						var poolNameStr:String = Diamonds.DIAMOND_POOL_NAME + id;
						if (Pool.hasObject(poolNameStr)) t_diamond = Pool.getObject(poolNameStr) as Diamonds;
						else t_diamond = new Diamonds(id);
						diamondsContainer.addChild(t_diamond);
						t_diamond.x = xcoor * Diamonds.WIDTH;
						t_diamond.y = moveAfterEnd_y - 420;
						t_diamond.end_y = moveAfterEnd_y;
						diamondsArray[i][xcoor] = t_diamond;
						t_diamond.setRowsCols(i, xcoor);
						
						var tween:Tween = new Tween(t_diamond, 0.2);
						tween.onComplete = tweenKill;
						tween.onCompleteArgs = [tween];
						tween.animate("y", moveAfterEnd_y);
						tween.delay = 0.05 * (num - i);
						Starling.juggler.add(tween);
						
					}
				}
			}
			addCardArr=null;
		}
		
		
		
	}
}