package
{

	import com.greensock.TweenMax;

	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.profiler.showRedrawRegions;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;
	import flash.utils.setInterval;

	import global.DeviceType;
	import global.Global;

	import test.data.TestData;


//	[SWF(width = "1024", height = "768", frameRate = "30", backgroundColor = "0x000000")] // ipad
//	[SWF(width = "960", height = "640", frameRate = "30", backgroundColor="0x000000")] // iphone
//	[SWF(width = "800", height = "480", frameRate = "30", backgroundColor = "0x000000")] // android

	/**
	 * 说明：AirXiYou
	 * @author Victor
	 * 2012-9-29
	 */

	public class AirXiYou extends MovieClip
	{


		public function AirXiYou()
		{
			if ( stage )
				initialization();
			else
				this.addEventListener( Event.ADDED_TO_STAGE, initialization );
		}

		protected function initialization( event : Event = null ) : void
		{
			// removed added event
			this.removeEventListener( Event.ADDED_TO_STAGE, initialization );

			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			Global.isDifferenceSwf = true;
			Global.isOnDevice = false;
			Global.deviceType = DeviceType.IPAD;
//			Global.deviceType = DeviceType.IPHONE;
//			Global.deviceType = DeviceType.ANDROID;

			addChild( new Main());

			// 性能信息
			stage.addChild( new Stats());
//			
			// 显示重绘
//			flash.profiler.showRedrawRegions ( true, 0xff0000 );

			///////////////////////////////////////////////////////////////
			/////////////////////// test //////////////////////////////////
			///////////////////////////////////////////////////////////////

			NativeApplication.nativeApplication.addEventListener( Event.EXITING, onExit );

			var testWinNative : TestWinNative = new TestWinNative();
			addChild( testWinNative );

			stage.nativeWindow.alwaysInFront = true;

			TweenMax.delayedCall( 1, function() : void
			{
				stage.nativeWindow.bounds = new Rectangle(( stage.fullScreenWidth - stage.width ) * 0.5, ( stage.fullScreenHeight - stage.height ) * 0.5, stage.width, stage.height );
			});

			stage.addEventListener( MouseEvent.RIGHT_CLICK, rightClickHandler );
		}

		protected function rightClickHandler( event : MouseEvent ) : void
		{
			trace( event.type );
		}

		protected function onExit( event : Event ) : void
		{

		}


	}

}
