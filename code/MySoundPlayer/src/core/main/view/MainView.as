package core.main.view
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	
	import core.Global;
	import core.Setting;
	import core.main.event.AppEvent;
	import core.main.manager.MusicPlayManager;
	
	import fl.events.SliderEvent;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-7-10
	 */
	public class MainView extends Sprite
	{
		
		private var scanFiles:ScanFiles;
		private var uiView:UIMainUISkin;

		public function MainView()
		{
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}

		protected function addedToStageHandler( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			createView();
			addListener();
			initViewStatus();
			checkStatus();
		}

		private function checkStatus():void
		{
			if ( Setting.autoPlay )
			{
				MusicPlayManager.instance.playDefaultList();
			}
		}

		private function createView():void
		{
			uiView = new UIMainUISkin();
			addChild( uiView );
		}

		private function initViewStatus():void
		{
			var voice:Number = Setting.currentVoice;
			voice = isNaN( voice ) ? 40 : voice;
			MusicPlayManager.instance.setSoundTransform( voice );
			uiView.slider.value = voice;
			uiView.slider.visible = false;
			uiView.btnDefault.buttonMode = true;
			uiView.btnPlayPause.buttonMode = true;
			uiView.btnScan.buttonMode = true;
			uiView.btnStop.buttonMode = true;
			uiView.btnVoice.buttonMode = true;

			uiView.txtTime.mouseEnabled = false;
			uiView.bar.mouseChildren = false;
			uiView.bar.mouseEnabled = false;
		}

		private function addListener():void
		{
			uiView.btnPlayPause.addEventListener( MouseEvent.CLICK, btnMouseClickHandler );
			uiView.btnDefault.addEventListener( MouseEvent.CLICK, btnMouseClickHandler );
			uiView.btnScan.addEventListener( MouseEvent.CLICK, btnMouseClickHandler );
			uiView.btnStop.addEventListener( MouseEvent.CLICK, btnMouseClickHandler );
			uiView.btnVoice.addEventListener( MouseEvent.CLICK, btnMouseClickHandler );
			uiView.slider.addEventListener( MouseEvent.MOUSE_DOWN, sliderMouseHandler );
			uiView.slider.addEventListener( Event.CHANGE, onChangeHandler );
			uiView.mcBg.addEventListener( MouseEvent.MOUSE_DOWN, startMoveAppHandler );

			MusicPlayManager.instance.addEventListener( AppEvent.BUFFERING, bufferingHandler );
			MusicPlayManager.instance.addEventListener( AppEvent.BUFFER_COMPLETE, bufferCompleteHandler );
			MusicPlayManager.instance.addEventListener( ProgressEvent.PROGRESS, playProgressHandler );
		}

		protected function bufferingHandler( event:AppEvent ):void
		{
			uiView.btnDefault.enabled = false;
			uiView.btnPlayPause.enabled = false;
			uiView.btnScan.enabled = false;
			uiView.btnStop.enabled = false;
		}

		protected function bufferCompleteHandler( event:AppEvent ):void
		{
			uiView.btnDefault.enabled = true;
			uiView.btnPlayPause.enabled = true;
			uiView.btnScan.enabled = true;
			uiView.btnStop.enabled = true;
		}

		protected function onChangeHandler( event:SliderEvent ):void
		{
			MusicPlayManager.instance.setSoundTransform( uiView.slider.value );
		}

		protected function sliderMouseHandler( event:MouseEvent ):void
		{
			if ( event.type == MouseEvent.MOUSE_DOWN )
			{
				stage.addEventListener( MouseEvent.MOUSE_MOVE, sliderMouseHandler );
				stage.addEventListener( MouseEvent.MOUSE_UP, sliderMouseHandler );
			}
			else if ( event.type == MouseEvent.MOUSE_MOVE )
			{
				MusicPlayManager.instance.setSoundTransform( uiView.slider.value );
			}
			else if ( event.type == MouseEvent.MOUSE_UP )
			{
				stage.removeEventListener( MouseEvent.MOUSE_MOVE, sliderMouseHandler );
				stage.removeEventListener( MouseEvent.MOUSE_UP, sliderMouseHandler );
			}
		}

		protected function startMoveAppHandler( event:MouseEvent ):void
		{
			Global.nativeWindow.startMove();
		}

		protected function btnMouseClickHandler( event:MouseEvent ):void
		{
			var target:InteractiveObject = event.target as InteractiveObject;
			if ( target == uiView.btnDefault )
			{
				MusicPlayManager.instance.playDefaultList();
				uiView.btnPlayPause.label = "暂停";
			}
			else if ( target == uiView.btnPlayPause )
			{
				if ( MusicPlayManager.instance.isPlaying )
				{
					MusicPlayManager.instance.pauseSound();
					uiView.btnPlayPause.label = "播放";
				}
				else
				{
					MusicPlayManager.instance.playSound();
					uiView.btnPlayPause.label = "暂停";
				}
			}
			else if ( target == uiView.btnScan )
			{
				scanFiles ||= new ScanFiles();
				scanFiles.brower();
			}
			else if ( target == uiView.btnStop )
			{
				MusicPlayManager.instance.stopSound();
				uiView.btnPlayPause.label = "播放";
			}
			else if ( target == uiView.btnVoice )
			{
				uiView.slider.visible = !uiView.slider.visible;
			}
		}

		protected function playProgressHandler( event:ProgressEvent ):void
		{
			var leftSec:int = event.bytesTotal - event.bytesLoaded;
			var fen:int = int( leftSec / 60000 );
			var sec:int = int( leftSec % 60000 / 1000 );
			var msec:int = leftSec % 60000 % 1000;
			uiView.txtTime.text = ( fen < 10 ? "0" + fen : fen ) + ":" + ( sec < 10 ? "0" + sec : sec ) + ":" + msec;
			uiView.bar.scaleX = event.bytesLoaded / event.bytesTotal;
		}

	}
}
