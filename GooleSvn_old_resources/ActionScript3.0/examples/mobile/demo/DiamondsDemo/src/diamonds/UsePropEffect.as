package diamonds
{
	import display.InitialPointType;
	import display.VMovieClip;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.jt_tech.ui.JTPanelBase;
	
	
	/** 
	 * 说明：
	 * @author Victor
	 * 2011-12-16 下午01:41:49
	 */
	public class UsePropEffect extends JTPanelBase
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		private var effectVmc:VMovieClip;
		private var mcEffectRes:MovieClip;
		private var cardId:int = 0;
		private var callBackFun:Function;
		private var mcEffectResTotalFrames:int;
		/**
		 * 40% 透明度的黑色背景
		 */
		protected var bgMaskRes:Shape;
		
		private var timer:Timer;
		private var delayTime:int = 0;
		
		public function UsePropEffect($cardId:int, $x:Number, $y:Number, $callBackFun:Function, $delayTime:int = 0)
		{
			super();
			
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
			initResoucres($cardId);
			initialization($cardId, $x, $y, $callBackFun, $delayTime);
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		public function initialization($cardId:int, $x:Number, $y:Number, $callBackFun:Function, $delayTime:int = 0):void
		{
			this.visible = true;
			this.x = $x;
			this.y = $y;
			cardId = $cardId;
			callBackFun = $callBackFun;
			delayTime = $delayTime;
			if (cardId == DiamondType.PropCrossBlue)
			{
				if (bgMaskRes == null) createBgMaskRes();
				bgMaskRes.visible = true;
				bgMaskRes.x = -this.x - 19 - 3;
				bgMaskRes.y = -this.y - 19 - 3;
			}
			if (mcEffectRes && mcEffectRes.parent == null)
			{
				this.addChild(mcEffectRes);
			}
			if (effectVmc && effectVmc.parent == null)
			{
				this.addChild(effectVmc);
			}
			initEffectVmc();
			initEvent();
		}
		
		public function clear():void
		{
			this.visible = false;
			if (mcEffectRes)
			{
				mcEffectRes.gotoAndStop(1);
				mcEffectRes.removeEventListener(Event.ENTER_FRAME, mcEffectResEnterEventHandler);
				if (mcEffectRes.parent) mcEffectRes.parent.removeChild(mcEffectRes);
			}
			if (effectVmc)
			{
				effectVmc.stop();
			}
			clearTimer();
			removeThisFromStage();
			DiamondsPool.setObject(this, DiamondType.usePropEffectName + cardId);
		}
		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function initEvent():void
		{
			if (mcEffectRes)
			{
				mcEffectRes.addEventListener(Event.ENTER_FRAME, mcEffectResEnterEventHandler);
				mcEffectRes.gotoAndPlay(1);
			}
		}
		
		private function initEffectVmc():void
		{
			if (effectVmc)
			{
				effectVmc.onComplete = onComplete;
				effectVmc.loop = false;
				effectVmc.play();				
			}
		}
		
		private function removeThisFromStage():void
		{
			if (this.parent) this.parent.removeChild(this);
			this.visible = false;
		}
		
		private function initResoucres($id:int):void
		{
			var linkage:String;
			switch ($id)
			{
				case DiamondType.PropCrossBlue:
					linkage = DiamondType.TYPE_RESOUCRE_PROP_EFFECTS_BLUE1;
					createBgMaskRes();
					break;
				case DiamondType.PropHourglassGreen:
					linkage = DiamondType.TYPE_RESOUCRE_PROP_EFFECTS_GREEN2;
					break;
				case DiamondType.PropSameColorPurple:
					linkage = DiamondType.TYPE_RESOUCRE_PROP_EFFECTS_PURPLE3;
					break;
				case DiamondType.PropMatrixRed:
					linkage = DiamondType.TYPE_RESOUCRE_PROP_EFFECTS_RED4;
					break;
				case DiamondType.PropMatrixYellow:
					linkage = DiamondType.TYPE_RESOUCRE_PROP_EFFECTS_YELLOW5;
					break;
				case DiamondType.PropSameColorBlue:
					linkage = DiamondType.TYPE_RESOUCRE_PROP_EFFECTS_SAME_BLUE;
					break;
				case DiamondType.PropSameColorGreen:
					linkage = DiamondType.TYPE_RESOUCRE_PROP_EFFECTS_SAME_GREEN;
					break;
				case DiamondType.PropSameColorRed:
					linkage = DiamondType.TYPE_RESOUCRE_PROP_EFFECTS_SAME_RED;
					break;
				case DiamondType.PropSameColorYellow:
					linkage = DiamondType.TYPE_RESOUCRE_PROP_EFFECTS_SAME_YELLOW;
					break;
			}
//			linkage = DiamondType.PROP_EFFECT_LINKAGE + String($id);
			if (linkage)
			{
				mcEffectRes = this.createUIItem(linkage) as MovieClip;
				this.addChild(mcEffectRes);
				mcEffectResTotalFrames = mcEffectRes.totalFrames;
				
//				effectVmc = new VMovieClip(this.createUIItem(linkage) as BitmapData, Global.appXml[linkage][0]);
//				effectVmc.registrarType = InitialPointType.CENTER;
//				this.addChild(effectVmc);
			}
			else
			{
				this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			}
		}
		
		private function initTimer():void
		{
			timer = new Timer(delayTime, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
			timer.start();
		}
		
		private function clearTimer():void
		{
			if (timer)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
				timer = null;
			}
		}
		
		private function createBgMaskRes():void
		{
			if (bgMaskRes == null)
			{
				bgMaskRes = new Shape();
				bgMaskRes.graphics.beginFill(0x000000, 0.6);
				bgMaskRes.graphics.drawRect(-1000, -1000, 2000, 2000);
				bgMaskRes.graphics.endFill();
				bgMaskRes.cacheAsBitmap = true;
			}
			this.addChildAt(bgMaskRes, 0);
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
		private function addedToStageHandler(e:Event):void
		{
			if (this.callBackFun != null)
			{
				this.callBackFun.apply(this, [cardId]);
			}
			callBackFun = null;
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			if (mcEffectRes == null)
			{
				removeThisFromStage();
			}
		}
		
		private function mcEffectResEnterEventHandler(e:Event):void
		{
			if (mcEffectRes == null)
			{
				removeThisFromStage();
				return ;
			}
			if (mcEffectRes.currentFrame == mcEffectResTotalFrames)
			{
				onComplete();
			}
		}
		
		private function onComplete():void
		{
			clear();
			if (callBackFun != null)
			{
				callBackFun.apply(this, [cardId]);
			}
			callBackFun = null;
		}
		
		private function timerCompleteHandler(e:TimerEvent):void
		{
			clearTimer();
			initEvent();
		}
		
	}
	
}