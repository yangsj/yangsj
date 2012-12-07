package newview.pvp
{

	import datas.RolesID;
	import datas.TeamInfoData;

	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import global.Global;

	import newview.SpriteBase;
	import newview.navi.MainNaviView;

	import ui.pvp.ResourcePvpEffectAnimation;
	import ui.pvp.ResourcePvpListView;

	import utils.FunctionUtils;

	import view.AlertPanel;


	/**
	 * 说明：PvpView
	 * @author Victor
	 * 2012-11-22
	 */

	public class PvpView extends SpriteBase
	{
		private var pvpView : MovieClip;
		private var pvpListView : ResourcePvpListView;
		private var pvpResultView : PvpResultView;

		public function PvpView()
		{
			super();
			MainNaviView.instance.hide();
		}


		override protected function createResource() : void
		{
			this.graphics.beginFill( 0 );
			this.graphics.drawRect( 0, 0, Global.stageWidth, Global.stageHeight );
			this.graphics.endFill();

			pvpView = new ResourcePvpEffectAnimation();
			addChild( pvpView );
			pvpView.stop();
			pvpView.visible = false;

			pvpListView = new ResourcePvpListView();
			addChild( pvpListView );

			pvpResultView = new PvpResultView();
			addChild( pvpResultView );
			pvpResultView.x = ( Global.stageWidth - pvpResultView.width ) * 0.5;
			pvpResultView.y = ( Global.stageHeight - pvpResultView.height ) * 0.5;
			pvpResultView.visible = false;
		}

		override protected function addEvents() : void
		{
			super.addEvents();
			pvpView.addEventListener( Event.ENTER_FRAME, enterFrameHandler );
			addEventListener( MouseEvent.CLICK, onClickHandler );
		}

		override protected function removeEvents() : void
		{
			super.removeEvents();
			pvpView.removeEventListener( Event.ENTER_FRAME, enterFrameHandler );
			removeEventListener( MouseEvent.CLICK, onClickHandler );
		}

		protected function onClickHandler( event : MouseEvent ) : void
		{
			var target : InteractiveObject = event.target as InteractiveObject;
			if ( target == pvpListView.btnBattle )
			{
				FunctionUtils.removeChild( pvpListView );
				pvpView.gotoAndPlay( 1 );
				pvpView.visible = true;
			}
			else if ( target == pvpListView.btnCancel || target == pvpResultView.getBtnClose )
			{
				MainNaviView.instance.show();
			}
		}

		override protected function addedToStageHandler( event : Event ) : void
		{
			super.addedToStageHandler( event );
		}

		protected function enterFrameHandler( event : Event ) : void
		{
			if ( pvpView.currentFrame == pvpView.totalFrames )
			{
				pvpView.removeEventListener( Event.ENTER_FRAME, enterFrameHandler );
				pvpView.stop();
				effectPlayComplete();
			}
		}

		private function effectPlayComplete() : void
		{
			pvpResultView.visible = true;
		}


	}

}
