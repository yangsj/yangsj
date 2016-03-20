package core.diamonds
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.jt_tech.ui.Effectsanimation.BlueCubeResAnimate;
	import net.jt_tech.ui.Effectsanimation.Earthquake;
	import net.jt_tech.ui.Effectsanimation.GreenCubeResAnimate;
	import net.jt_tech.ui.Effectsanimation.RedCubeResAnimate;
	import net.jt_tech.ui.Effectsanimation.RubiksCube;
	import net.jt_tech.ui.Effectsanimation.YellowCubeResAnimate;
	import net.jt_tech.ui.Effectsanimation.yellow;
	import core.panel.JTPanelBase;
	import net.jt_tech.ui.animation.Eliminatecross;
	
	
	/** 
	 * 说明：
	 * @author Victor
	 * 2011-12-16 下午01:41:49
	 */
	public class UsePropEffect extends JTPanelBase
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		private var mcEffectRes:MovieClip;
		private var cardId:int = 0;
		private var callBackFun:Function;
		private var mcEffectResTotalFrames:int;
		/**
		 * 40% 透明度的黑色背景
		 */
		protected var bgMaskRes:Sprite;
		
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
			if (mcEffectRes.parent == null)
			{
				this.addChild(mcEffectRes);
			}
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
			clearTimer();
			if (this.parent) this.parent.removeChild(this);
			DiamondsPool.setObject(this, DiamondType.usePropEffectName + cardId);
		}
		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function initEvent():void
		{
			mcEffectRes.addEventListener(Event.ENTER_FRAME, mcEffectResEnterEventHandler);
			mcEffectRes.gotoAndPlay(1);
		}
		
		private function initResoucres($id:int):void
		{
			var linkage:String;
			switch ($id)
			{
				case DiamondType.PropCrossBlue:
					linkage = "net.jt_tech.ui.animation.Eliminatecross";
					createBgMaskRes();
					break;
				case DiamondType.PropHourglassGreen:
					linkage = "net.jt_tech.ui.animation.Pause";
					break;
				case DiamondType.PropSameColorPurple:
					linkage = "net.jt_tech.ui.Effectsanimation.RubiksCube";
					break;
				case DiamondType.PropMatrixRed:
					linkage = "net.jt_tech.ui.Effectsanimation.Earthquake";
					break;
				case DiamondType.PropMatrixYellow:
					linkage = "net.jt_tech.ui.Effectsanimation.yellow";
					break;
				case DiamondType.PropSameColorBlue:
					linkage = "net.jt_tech.ui.Effectsanimation.BlueCubeResAnimate";
					break;
				case DiamondType.PropSameColorGreen:
					linkage = "net.jt_tech.ui.Effectsanimation.GreenCubeResAnimate";
					break;
				case DiamondType.PropSameColorRed:
					linkage = "net.jt_tech.ui.Effectsanimation.RedCubeResAnimate";
					break;
				case DiamondType.PropSameColorYellow:
					linkage = "net.jt_tech.ui.Effectsanimation.YellowCubeResAnimate";
					break;
			}
			
			if (linkage)
			{
				mcEffectRes = this.createUIItem(linkage) as MovieClip;
				this.addChild(mcEffectRes);
				mcEffectResTotalFrames = mcEffectRes.totalFrames;
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
			bgMaskRes = new Sprite();
			bgMaskRes.graphics.beginFill(0x000000, 0.4);
			bgMaskRes.graphics.drawRect(0, 0, 420, 420);
			bgMaskRes.graphics.endFill();
			bgMaskRes.mouseEnabled = bgMaskRes.mouseChildren = false;
			bgMaskRes.cacheAsBitmap = true;
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
				if (this.parent) this.parent.removeChild(this);
				this.visible = false;
			}
		}
		
		private function mcEffectResEnterEventHandler(e:Event):void
		{
			if (mcEffectRes == null)
			{
				if (this.parent) this.parent.removeChild(this);
				this.visible = false;
				return ;
			}
			if (mcEffectRes.currentFrame == mcEffectResTotalFrames)
			{
				clear();
				
				if (callBackFun != null)
				{
					callBackFun.apply(this, [cardId]);
				}
				callBackFun = null;
			}
		}
		
		private function timerCompleteHandler(e:TimerEvent):void
		{
			clearTimer();
			initEvent();
		}
		
	}
	
}