package diamonds.resource
{
	import diamonds.DiamondType;
	import diamonds.DiamondsPool;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import net.jt_tech.ui.JTPanelBase;
	
	public class Diamonds extends JTPanelBase
	{
		/////////////////////////////////////////static /////////////////////////////////
		public static var DIAMONDS_WIDTH:Number = 53;
		public static var DIAMONDS_HEIGHT:Number = 53;
		public static var DIAMONDS_WIDTH_HALF:Number = 26.5;
		public static var DIAMONDS_HEIGHT_HALF:Number = 26.5;
		
		private const RES_POOL_NAME:String = "res_pool_name";
		
		private var _id:int;
		private var diamond:Sprite;
		private var intervalId:uint;
		private var _promptEffectFilters:Array;
		
		/** 提示特效资源 */
		private var promptEffectRes:MovieClip;
		/** 同色消除道具定时变色计时器 */
		private var randomPurplePropTimer:Timer;
		/** 记录需要随机变色的道具id */
		private var randomPurplePropArr:Array;
		
		/**
		 * 在数组中的第一（1）维位置
		 */
		public var index_i:int;
		/**
		 * 在数组中的第二（2）维位置
		 */
		public var index_j:int;
		/**
		 * 移动的最终y位置
		 */
		public var moveAfterEnd_y:Number = 0;
		/**
		 * 在查找阶段是否已经被查找过
		 */
		public var isVisied:Boolean = false;
		/**
		 * 当前被点击的钻石是否是道具
		 */
		public var isClickProp:Boolean = false;
		
		/////////////////////////////////////////vars /////////////////////////////////
		public function Diamonds($diamondsId:int)
		{
			randomPurplePropArr = [	DiamondType.PropSameColorBlue, DiamondType.PropSameColorGreen, DiamondType.PropSameColorRed, DiamondType.PropSameColorYellow ];
			addTransparentBg();
			draw($diamondsId);
			this.mouseChildren = false;
		}
		
		/**
		 * 添加一个透明色块填充四个角空缺部分
		 */
		private function addTransparentBg():void
		{
			this.graphics.clear();
			this.graphics.beginFill(0xff0000, 0);
			this.graphics.drawRect(-DIAMONDS_WIDTH_HALF, -DIAMONDS_HEIGHT_HALF, DIAMONDS_WIDTH, DIAMONDS_HEIGHT);
			this.graphics.endFill();
		}
		
		/**
		 * 绘制卡片 
		 * @param id 卡片id
		 * @return 
		 * 
		 */		
		private function draw($diamondsId:int):void
		{
			var poolNameString:String = RES_POOL_NAME + String($diamondsId);
			if (DiamondsPool.hasObject(poolNameString))
			{
				diamond = DiamondsPool.getObject(poolNameString) as Sprite;
			}
			else
			{
				initAndChangeRes($diamondsId);
			}
			_id=$diamondsId;
			addDiamondsToStage();
		}
		
		/**
		 *  更改卡片 
		 * @param id
		 * @return 
		 * 
		 */		
		public function redraw($diamondsId:int):void
		{
			if (_id == $diamondsId) return ;
			this.removeChild(diamond);
			DiamondsPool.setObject(diamond, RES_POOL_NAME + String(_id));
			draw($diamondsId);
			if (randomPurplePropArr.indexOf($diamondsId) >= 0)
			{
				needRandomPropTimer();
			}
		}
		
		private function initAndChangeRes($diamondsId:int):void
		{
			switch ($diamondsId)
			{
				case DiamondType.diamondBlue:
					diamond = this.createUIItem(DiamondType.TYPE_RESOUCRE_DIAMONDS_BLUE1) as Sprite;
					break;
				case DiamondType.diamondGreen:
					diamond = this.createUIItem(DiamondType.TYPE_RESOUCRE_DIAMONDS_GREEN2) as Sprite;
					break;
				case DiamondType.diamondPurple:
					diamond = this.createUIItem(DiamondType.TYPE_RESOUCRE_DIAMONDS_PURPLE3) as Sprite;
					break;
				case DiamondType.diamondRed:
					diamond = this.createUIItem(DiamondType.TYPE_RESOUCRE_DIAMONDS_RED4) as Sprite;
					break;
				case DiamondType.diamondYellow:
					diamond = this.createUIItem(DiamondType.TYPE_RESOUCRE_DIAMONDS_YELLOW5) as Sprite;
					break;
				case DiamondType.PropCrossBlue:
					diamond = this.createUIItem(DiamondType.TYPE_RESOUCRE_PROP_BLUE1) as Sprite;
					break;
				case DiamondType.PropHourglassGreen:
					diamond = this.createUIItem(DiamondType.TYPE_RESOUCRE_PROP_GREEN2) as Sprite;
					break;
				case DiamondType.PropSameColorPurple:
					diamond = this.createUIItem(DiamondType.TYPE_RESOUCRE_PROP_PURPLE3) as Sprite;
					break;
				case DiamondType.PropMatrixRed:
					diamond = this.createUIItem(DiamondType.TYPE_RESOUCRE_PROP_RED4) as Sprite;
					break;
				case DiamondType.PropMatrixYellow:
					diamond = this.createUIItem(DiamondType.TYPE_RESOUCRE_PROP_YELLOW5) as Sprite;
					break;
				case DiamondType.PropSameColorBlue:
					diamond = this.createUIItem(DiamondType.TYPE_RESOUCRE_PROP_SAME_BLUE) as Sprite;
					break;
				case DiamondType.PropSameColorGreen:
					diamond = this.createUIItem(DiamondType.TYPE_RESOUCRE_PROP_SAME_GREEN) as Sprite;
					break;
				case DiamondType.PropSameColorRed:
					diamond = this.createUIItem(DiamondType.TYPE_RESOUCRE_PROP_SAME_RED) as Sprite;
					break;
				case DiamondType.PropSameColorYellow:
					diamond = this.createUIItem(DiamondType.TYPE_RESOUCRE_PROP_SAME_YELLOW) as Sprite;
					break;
				case DiamondType.statusBlank:
					diamond = new Sprite();
					this.visible = false;
					break;
				default :
					diamond = new Sprite();
					
			}
		}
		
		private function addDiamondsToStage():void
		{
			this.addChild(diamond);
			diamond.width = DIAMONDS_WIDTH;
			diamond.height = DIAMONDS_HEIGHT;
			this.visible = true;
		}
		
		/**
		 * 需要启动道具颜色变换计时器
		 */
		private function needRandomPropTimer():void
		{
			clearRandomPropTimer();
			randomPurplePropTimer = new Timer(1000);
			randomPurplePropTimer.addEventListener(TimerEvent.TIMER, timerRandomPropHandler);
			randomPurplePropTimer.start();
		}
		
		private function clearRandomPropTimer():void
		{
			if (randomPurplePropTimer)
			{
				randomPurplePropTimer.stop();
				randomPurplePropTimer.removeEventListener(TimerEvent.TIMER, timerRandomPropHandler);
				randomPurplePropTimer = null;
			}
		}
		
		private function timerRandomPropHandler(e:TimerEvent):void
		{
			var temp_id:int = randomSamePropColorId(id);
			createNewSameColorProp(temp_id);
		}
		
		private function createNewSameColorProp($diamondsId:int):void
		{
			if (_id == $diamondsId) return ;
			this.removeChild(diamond);
			if (diamond.hasOwnProperty("stop"))
			{
				diamond["stop"]();
			}
			draw($diamondsId);
		}
		
		private function randomSamePropColorId($diamondsId:int):int
		{
			var tyIdArr:Array = [DiamondType.PropSameColorBlue];
			switch ($diamondsId)
			{
				case DiamondType.PropSameColorBlue:
					tyIdArr = [DiamondType.PropSameColorGreen, DiamondType.PropSameColorRed, DiamondType.PropSameColorYellow];
					break;
				case DiamondType.PropSameColorGreen:
					tyIdArr = [DiamondType.PropSameColorBlue, DiamondType.PropSameColorRed, DiamondType.PropSameColorYellow];
					break;
				case DiamondType.PropSameColorRed:
					tyIdArr = [DiamondType.PropSameColorBlue, DiamondType.PropSameColorGreen, DiamondType.PropSameColorYellow];
					break;
				case DiamondType.PropSameColorYellow:
					tyIdArr = [DiamondType.PropSameColorBlue, DiamondType.PropSameColorGreen, DiamondType.PropSameColorRed];
					break;
			}
			var random:int = int(Math.random() * tyIdArr.length);
			return tyIdArr[random];
		}
		
		/**
		 * 移除此显示对象
		 * 
		 */		
		public function removeDiamonds():void
		{
			moveAfterEnd_y = 0;
			isVisied = false;
			this.visible = false;
			clearRandomPropTimer();
			if(this.parent) this.parent.removeChild(this); 
			removePromptEffectRes();
		}
		
		private function removePromptEffectRes():void
		{
			if (promptEffectRes)
			{
				promptEffectRes.gotoAndStop(1);
				promptEffectRes.visible = false;
				if (promptEffectRes.parent)
					promptEffectRes.parent.removeChild(promptEffectRes);
			}
		}
		
		/**
		 *卡片提示 
		 */
		public function prompEffect():void
		{
			clearInterval(intervalId);
			if (promptEffectRes == null)
			{
				promptEffectRes = this.createUIItem(getPromptEffectLinkage) as MovieClip;
				promptEffectRes.mouseChildren = promptEffectRes.mouseEnabled = false;
				promptEffectRes.filters = promptEffectFilters;
			}
			promptEffectRes.gotoAndPlay(1);
			promptEffectRes.visible = true;
			this.addChild(promptEffectRes);
		}
		
		/**
		 *卡片发暗 
		 */
		public function goToStopDarkle():void
		{
			clearInterval(intervalId);
			if (diamond.hasOwnProperty("error"))
			{
				diamond["error"]();
			}
			intervalId = setInterval(goToStopBack, 1000);
		}
		
		/**
		 * 返回正常状态
		 */
		public function goToStopBack():void
		{
			clearInterval(intervalId);
			if (diamond.hasOwnProperty("right"))
			{
				diamond["right"]();
			}
			removePromptEffectRes();
		}
		
		public function setIndex($index_i:int,$index_j:int):void
		{
			index_i = $index_i;
			index_j = $index_j;
			this.visible = true;
		}
		
		/**
		 * 获取当前钻石提示资源的名称（linkage）
		 */
		private function get getPromptEffectLinkage():String
		{
			var linkages:String = DiamondType.TYPE_RESOUCRE_DIAMONDS_PROMPT_BLUE1;
			switch (id)
			{
				case DiamondType.diamondBlue:
					linkages = DiamondType.TYPE_RESOUCRE_DIAMONDS_PROMPT_BLUE1;
					break;
				case DiamondType.diamondGreen:
					linkages = DiamondType.TYPE_RESOUCRE_DIAMONDS_PROMPT_GREEN2;
					break;
				case DiamondType.diamondPurple:
					linkages = DiamondType.TYPE_RESOUCRE_DIAMONDS_PROMPT_PURPLE3;
					break;
				case DiamondType.diamondRed:
					linkages = DiamondType.TYPE_RESOUCRE_DIAMONDS_PROMPT_RED4;
					break;
				case DiamondType.diamondYellow:
					linkages = DiamondType.TYPE_RESOUCRE_DIAMONDS_PROMPT_YELLOW5;
					break;
			}
			return linkages;
		}
		
		/**
		 * 当前Diamonds是否是道具
		 */
		private function get currentIsProp():Boolean
		{
			if (DiamondType.diamondPropArray.indexOf(id) || DiamondType.diamondPropSameColor.indexOf(id))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/**
		 * 提示特效的滤镜
		 */
		private function get promptEffectFilters():Array
		{
			if (_promptEffectFilters == null)
			{
				
				var glow:GlowFilter = new GlowFilter();
				glow.color = 0xffffff;
				glow.alpha = 1;
				glow.blurX = 4;
				glow.blurY = 4;
				glow.strength = 1;
				glow.quality = BitmapFilterQuality.LOW;
				
				var blur:BlurFilter = new BlurFilter();
				blur.blurX = 5;
				blur.blurY = 5;
				blur.quality = BitmapFilterQuality.LOW;
				
				_promptEffectFilters = [glow, blur]
			}
			
			return _promptEffectFilters;
		}
		
		public function get id():int
		{
			return _id;
		}
		
	}
}