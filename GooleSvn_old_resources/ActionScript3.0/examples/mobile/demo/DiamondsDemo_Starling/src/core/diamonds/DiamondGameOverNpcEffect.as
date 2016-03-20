package core.diamonds
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import net.jt_tech.diamond.views.main.house.HouseResource;
	import core.panel.JTPanelBase;
	
	
	/**
	 * 说明：DiamondGameOver
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-6-29
	 */
	
	public class DiamondGameOverNpcEffect extends JTPanelBase
	{
		private const FIRING_LABEL:String = "start";  
		private const FIRING_EFFECT_LINKAGE:String = "net.jt_tech.ui.gameovereffect.EndNpcFiringEffect";
		private const SUCCESS_LINKAGE:String = "net.jt_tech.ui.gameovereffect.EndSuccessEffect";
		private const FAILED_LINKAGE:String = "net.jt_tech.ui.gameovereffect.EndFailedEffect";
		
		private var _isSuccessDestroyHouse:Boolean = false;
		private var _playHouseCallFunction:Function;
		private var _sendGameResultCallFunction:Function;
		
		private var firingNpcSwitchRes:MovieClip;
		private var resultStatusRes:MovieClip;
		
		public function DiamondGameOverNpcEffect()
		{
			super();
		}
		
		public function initialization():void
		{
			init_firingNpcSwitchRes();
		}
		
		public function result():void
		{
			init_resultStatusRes();
		}

		private function init_firingNpcSwitchRes():void
		{
			firingNpcSwitchRes = this.createUIItem(FIRING_EFFECT_LINKAGE) as MovieClip;
			this.addChild(firingNpcSwitchRes);
			firingNpcSwitchRes.addEventListener(Event.ENTER_FRAME, firingNpcSwitchResEnterHandler);
			firingNpcSwitchRes.gotoAndPlay(1);
		}
		
		private function firingNpcSwitchResEnterHandler(e:Event):void
		{
			if (firingNpcSwitchRes)
			{
				if (firingNpcSwitchRes.currentLabel == FIRING_LABEL)
				{
					firingNpcSwitchRes.removeEventListener(Event.ENTER_FRAME, firingNpcSwitchResEnterHandler);
					firingNpcSwitchRes.gotoAndStop(FIRING_LABEL);
					playTheHouseAnimation();
				}
			}
		}
		
		private function playTheHouseAnimation():void
		{
			if (playHouseCallFunction != null)
			{
				playHouseCallFunction.apply(this);
				playHouseCallFunction = null;
			}
		}
		
		private function init_resultStatusRes():void
		{
			if (firingNpcSwitchRes) firingNpcSwitchRes.visible = false;
			removeResultStatusRes();
			resultStatusRes = this.createUIItem(isSuccessDestroyHouse ? SUCCESS_LINKAGE : FAILED_LINKAGE) as MovieClip;
			this.addChild(resultStatusRes);
			resultStatusRes.addEventListener(Event.ENTER_FRAME, resultStatusResEnterHandler);
			resultStatusRes.gotoAndPlay(1);
		}
		
		private function removeResultStatusRes():void
		{
			if (resultStatusRes)
			{
				resultStatusRes.removeEventListener(Event.ENTER_FRAME, resultStatusResEnterHandler);
				resultStatusRes.stop();
				if (resultStatusRes.parent)resultStatusRes.parent.removeChild(resultStatusRes);
				resultStatusRes = null;
			}
		}
		
		private function resultStatusResEnterHandler(e:Event):void
		{
			if (resultStatusRes)
			{
				if (resultStatusRes.currentFrame == resultStatusRes.totalFrames)
				{
					removeResultStatusRes();
					sendResult();
					dispose();
				}
			}
		}
		
		private function sendResult():void
		{
			if (sendGameResultCallFunction != null)
			{
				sendGameResultCallFunction.apply(this);
				sendGameResultCallFunction = null;
			}
		}
		
		private function dispose():void
		{
			if (this.parent)
			{
				this.parent.removeChild(this);
			}
		}
		
		public function get isSuccessDestroyHouse():Boolean
		{
			return _isSuccessDestroyHouse;
		}

		public function set isSuccessDestroyHouse(value:Boolean):void
		{
			_isSuccessDestroyHouse = value;
		}
		
		public function get playHouseCallFunction():Function
		{
			return _playHouseCallFunction;
		}
		
		public function set playHouseCallFunction(value:Function):void
		{
			_playHouseCallFunction = value;
		}
		
		public function get sendGameResultCallFunction():Function
		{
			return _sendGameResultCallFunction;
		}
		
		public function set sendGameResultCallFunction(value:Function):void
		{
			_sendGameResultCallFunction = value;
		}

	}
	
}