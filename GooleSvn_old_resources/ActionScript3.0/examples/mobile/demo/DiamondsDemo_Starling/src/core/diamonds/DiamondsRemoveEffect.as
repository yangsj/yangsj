package core.diamonds
{
	import core.display.SpriteClip;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import core.panel.JTPanelBase;
	
	
	/** 
	 * 说明：
	 * @author Victor
	 * 2011-12-7 上午11:41:58
	 */
	public class DiamondsRemoveEffect extends JTPanelBase
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		private var effectRes:MovieClip;  // 发光效果
		private var effectClip:SpriteClip;
		private var namePool:String;
		private var effectResLinkage:Class;
		private var effectResTotalFrames:int;
		private var isExcitement:Boolean;
		
		public function DiamondsRemoveEffect($namePool:String, $xx:Number, $yy:Number, $isExcitement:Boolean = false)
		{
			super();
			isExcitement = $isExcitement;
			initResourece();
			gotoPlay($namePool, $xx, $yy);
		}
		
		private function initResourece():void
		{	
			var xml:XML = isExcitement ? Global.appXml.remove_effects_exciting[0] : Global.appXml.removed_effect_general[0];
			effectClip = new SpriteClip();
			effectClip.registrarType = SpriteClip.CENTER;
			effectClip.xml = xml;
			this.addChild(effectClip);
			
//			effectRes = this.createUIItem(isExcitement ? "RemoveEffectExciting_MovieClip" : "RemovedEffectGeneral_MovieClip") as MovieClip;
//			this.addChild(effectRes);
//			effectResTotalFrames = effectRes.totalFrames;
//			effectResLinkage = null;
		}
		
		public function gotoPlay($namePool:String, $xx:Number, $yy:Number):void
		{
			namePool = $namePool;
			this.x = $xx;
			this.y = $yy;
			this.visible = true;
			
			addEvents();
			
			startEffectClip();
		}
		
		private function completeCallFunction():void
		{
			clearVars();
		}
		
		public function clearVars():void
		{
			if (effectRes == null && effectClip == null)
			{
				removeFromStage();
				return ;
			}
			if (effectClip)
			{
				effectClip.gotoAndStop(1);
			}
			removeEvents();
			removeFromStage();
			DiamondsPool.setObject(this, namePool);
		}
		
		private function startEffectClip():void
		{
			if (effectClip)
			{
				effectClip.playNumber = 1;
				effectClip.completeCallFunction = completeCallFunction;
				effectClip.play();
			}
		}
		
		private function addEvents():void
		{
			if (effectRes)
			{
				effectRes.visible 	= true;
				effectRes.addEventListener(Event.ENTER_FRAME, effectRes1EnterEventHandler);
				effectRes.gotoAndPlay(1);
			}
		}
		
		private function removeEvents():void
		{
			if (effectRes)
			{
				effectRes.gotoAndStop(1);
				effectRes.visible = false;
				effectRes.removeEventListener(Event.ENTER_FRAME, effectRes1EnterEventHandler);
			}
		}
		
		private function removeFromStage():void
		{
			this.visible = false;
			if (this.parent) this.parent.removeChild(this);
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
		private function effectRes1EnterEventHandler(e:Event):void
		{
			if (effectRes == null) return ;
			if (effectRes.currentFrame == effectResTotalFrames)
			{
				clearVars();
			}
		}
	}
	
}