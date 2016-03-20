package diamonds.house
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import net.jt_tech.ui.JTPanelBase;
	
	
	/** 
	 * 说明：
	 * @author Victor
	 * 2011-12-7 下午02:25:31
	 */
	public class HouseResource extends JTPanelBase
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		private const RES_START_X:int = 0;
		private const RES_START_Y:int = 219;
		
		private var houseRes:MovieClip;
		private var theTreeGrowRes:MovieClip;
		private var _goalScroce:int = 50000;
		private var _callBackFunction:Function;
		private var houseLevel:int = 0;
		private var endFrames:int = 1;
		private var endLabels:String = "lab_1";
		private var linkageHouse:String = "";
		
		public function HouseResource()
		{
			super();
			this.mouseChildren = this.mouseEnabled = false;
		}
		
		/////////////////////////////////////////public /////////////////////////////////

		public function initialization($houseLevel:int):void
		{
//			houseLevel = $houseLevel;
//			createHouseRes();
		}
		
		private function createHouseRes():void
		{
//			var linkage:String = getLinkageHouseAndSetGoalScroce;
//			if (linkageHouse != linkage)
//			{
//				linkageHouse = linkage;
//				if (houseRes && houseRes.parent)
//				{
//					houseRes.parent.removeChild(houseRes);
//				}
//				houseRes 	= this.createUIItem(linkage) as MovieClip;
//				houseRes.x 	= RES_START_X;
//				houseRes.y 	= RES_START_Y;
//			}
//			this.addChild(houseRes);
//			houseRes.gotoAndStop(1);
//			houseRes.cacheAsBitmap = true;
//			if (theTreeGrowRes)
//			{
//				theTreeGrowRes.visible = false;
//			}
		}
		
		private function get getLinkageHouseAndSetGoalScroce():String
		{
			var linkage:String = "net.jt_tech.ui.house.NewHouseResources";
////			houseLevel = 5;
//			switch (houseLevel)
//			{
//				case 0:
//					_goalScroce = 50000;
//					linkage = "net.jt_tech.ui.house.NewHouseResources";
//					break;
//				case 1:
//					_goalScroce = 100000;
//					linkage = "net.jt_tech.ui.house.NewHouseClockResources";
//					break;
//				case 2:
//					_goalScroce = 150000;
//					linkage = "net.jt_tech.ui.house.NewHouseTowerResources";
//					break;
//				case 3:
//					_goalScroce = 200000;
//					linkage = "net.jt_tech.ui.house.NewHouseNuclearResources";
//					break;
//				case 4:
//					_goalScroce = 250000;
//					linkage = "net.jt_tech.ui.house.NewHouseNuclearPlantResources";
//					break;
//				case 5:
//					_goalScroce = 450000;
//					linkage = "net.jt_tech.ui.house.NewHouseDrillingResources";
//					break;
//			}
//			return linkage;
		}
		
		/**
		 * 
		 * @param result 总分数（得分
		 * @param target 当分数达到定值时播放的提示动画
		 */
		public function playHouseAnimation(result:int, target:MovieClip):void
		{
//			houseRes.cacheAsBitmap = false;
//			var rate:Number = result / _goalScroce;
//			
//			if (rate < 0.25)
//			{
//				endLabels = HouseType.LAB_1;
//			}
//			else if (rate < 0.5)
//			{
//				endLabels = HouseType.LAB_2;
//			}
//			else if (rate < 0.75)
//			{
//				endLabels = HouseType.LAB_3;
//			}
//			else if (rate < 1)
//			{
//				endLabels = HouseType.LAB_4;
//			}
//			else if (rate >= 1)
//			{
//				endLabels = HouseType.LAB_END;
//			}
//			
//			rate = rate < 0 ? 0 : rate > 1 ? 1 : rate > 0.9 ? 0.9 : rate;
//			endFrames = int(rate * houseRes.totalFrames);
//			endFrames = endFrames == 0 ? 2 : endFrames;
//			
//			
//			result == 0 ? doCallBackFunction() : addEvents(); 
		}
		
		private function doCallBackFunction():void
		{
//			if (callBackFunction != null)
//			{
//				callBackFunction.apply(this);
//				callBackFunction = null;
//			}
		}
		
		private function addEvents():void
		{
//			houseRes.addEventListener(Event.ENTER_FRAME, houseResEnterEventHandler);
//			houseRes.gotoAndPlay(1);
		}
		
		private function houseResEnterEventHandler(e:Event):void
		{
////			if (endFrames == houseRes.currentFrame)
//			if (endLabels == houseRes.currentLabel)
//			{
////				if (endFrames == houseRes.totalFrames)
//				if (endLabels == HouseType.LAB_END && houseLevel > 2)
//				{
//					createTheTreeGrowEffect();
//				}
//				removeEvents();
//				doCallBackFunction();
//			}
		}
		
		private function createTheTreeGrowEffect():void
		{
//			if (theTreeGrowRes == null)
//			{
//				theTreeGrowRes = this.createUIItem("net.jt_tech.ui.scene.TreeGrowEffectResource") as MovieClip;
//				theTreeGrowRes.x = RES_START_X;
//				theTreeGrowRes.y = RES_START_Y;
//				this.addChild(theTreeGrowRes);
//			}
//			theTreeGrowRes.addEventListener(Event.ENTER_FRAME, theTreeGrowResEnterFrameHandler);
//			theTreeGrowRes.gotoAndPlay(1);
//			theTreeGrowRes.visible = true;
		}
		
		private function theTreeGrowResEnterFrameHandler(e:Event):void
		{
//			if (theTreeGrowRes)
//			{
//				if (theTreeGrowRes.currentFrame == theTreeGrowRes.totalFrames)
//				{
//					stopAndClearTheTreeGrowResFrame();
//				}
//			}
		}
		
		private function stopAndClearTheTreeGrowResFrame():void
		{
//			if (theTreeGrowRes)
//			{
//				theTreeGrowRes.removeEventListener(Event.ENTER_FRAME, theTreeGrowResEnterFrameHandler);
//				theTreeGrowRes.stop();
//			}
		}
		
		public function clear():void
		{
//			stopAndClearTheTreeGrowResFrame();
//			removeEvents();
//			endFrames = 1;
//			if (this.houseRes && this.houseRes.parent)
//			{
//				this.houseRes.parent.removeChild(houseRes);
//			}
		}
		
		private function removeEvents():void
		{
//			if (houseRes)
//			{
//				houseRes.removeEventListener(Event.ENTER_FRAME, houseResEnterEventHandler);
//				houseRes.stop();
//			}
		}
		
		public function get goalScroce():int
		{
			return _goalScroce;
		}
		
		public function get callBackFunction():Function
		{
			return _callBackFunction;
		}
		
		public function set callBackFunction(value:Function):void
		{
			_callBackFunction = value;
		}
		
	}
	
}