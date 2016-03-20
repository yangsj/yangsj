package
{
	import core.Main;
	import core.loader.LoaderManager;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60")]//, width="480", height="800")]
	public class StarlingExample extends Sprite
	{
		private var myStarling:Starling;
		
		public function StarlingExample()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			Starling.multitouchEnabled = true;  // useful on mobile devices
			Starling.handleLostContext = true; // not necessary on iOS. Saves a lot of memory!
			
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			var loader:LoaderManager = new LoaderManager();
			loader.callBack = loadCompleteHandler;
			loader.load();
			loader = null;
		}
		
		private function loadCompleteHandler():void
		{
			initMyStarling();
		}	
		
		private function initMyStarling():void
		{
			this.addChild(new Stats());
			
//			var viewPort:Rectangle =  new Rectangle(0, 0, 640, 960);
			var viewPort:Rectangle = new Rectangle();
			
			if (stage.fullScreenHeight / stage.fullScreenWidth < 1.5)
			{
				viewPort.height = stage.fullScreenHeight;
				viewPort.width  = int(viewPort.height / 1.5);
				viewPort.x = int((stage.fullScreenWidth - viewPort.width) / 2);
			}
			else
			{            
				viewPort.width = stage.fullScreenWidth; 
				viewPort.height = int(viewPort.width * 1.5);
				viewPort.y = int((stage.fullScreenHeight - viewPort.height) / 2);
			}
			
			myStarling = new Starling(Main, stage, viewPort);
			myStarling.simulateMultitouch  = false;
			myStarling.enableErrorChecking = false;
//			myStarling.showStats = true;
			myStarling.start();
			
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, function (e:Event):void { myStarling.start(); });
			
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, function (e:Event):void { myStarling.stop(); });
			
			myStarling.stage3D.addEventListener(Event.CONTEXT3D_CREATE, function(e:Event):void { myStarling.start(); });
		}	
		
		
	}
}