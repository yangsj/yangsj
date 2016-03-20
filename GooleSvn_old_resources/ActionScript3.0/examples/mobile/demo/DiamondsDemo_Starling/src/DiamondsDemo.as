package
{
	import core.Main;
	import core.diamonds.MainPanel;
	import core.display.SpriteClip;
	import core.panel.select.StartSelectPanel;
	import core.res.loader.LoaderManager;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageAspectRatio;
	import flash.display.StageDisplayState;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.StageOrientationEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import starling.core.Starling;
	
	[SWF(width="480", height="800", frameRate="24", backgroundColor="#000000")]
	
	public class DiamondsDemo extends Sprite
	{
		
		private var selectPanel:StartSelectPanel;
		
		private var container:Sprite;
		
		public function DiamondsDemo()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			Global.isOpenMusic = false;
			Global.isDebug = true;
			Global.isOpenAutoClickProgram = true;
			
			if (this.stage) initialization();
			else this.addEventListener(Event.ADDED_TO_STAGE, initialization);
		}
		
		private function initialization(event:Event=null):void
		{
//			container = new Sprite();
//			this.addChild(container);
			
			start();
		}
		
		private function start():void
		{
			var loader:LoaderManager = new LoaderManager();
			loader.callBack = callBackFunction;
			loader.load();
			loader = null;
		}
		
		private function callBackFunction():void
		{
			var star:Starling = new Starling(Main, this.stage);
			star.start();
			star.showStats = true;
			
//			var stats:Stats = new Stats();
//			this.addChild(stats);
			
			
			/*addSelectPanel();*/
			
//			testApp();
		}
		
		private function testApp():void
		{
			var spriteClip:SpriteClip = new SpriteClip();
			spriteClip.xml = Global.appXml.remove_effects_exciting[0];
			spriteClip.x = 50;
			spriteClip.y = 50;
			this.addChild(spriteClip);
			spriteClip.play();
			
			var clip:SpriteClip = new SpriteClip();
			clip.xml = Global.appXml.removed_effect_general[0];
			clip.x = 150;
			clip.y = 50;
			clip.registrarType = SpriteClip.CENTER;
			this.addChild(clip);
			clip.play();
		}
		
//		private function addSelectPanel():void
//		{
//			selectPanel = new StartSelectPanel();
//			selectPanel.callBackFunction = startGameDiamonds;
//			container.addChild(selectPanel);
//			
//			testApp();
//		}
//		
//		private function startGameDiamonds():void
//		{
//			removeSelectPanel();
//			initDiamondsMain();
//		}
//		
//		private function removeSelectPanel():void
//		{
//			if (selectPanel)
//			{
//				if (selectPanel.parent)
//				{
//					selectPanel.parent.removeChild(selectPanel);
//				}
//				selectPanel = null;
//			}
//		}
//		
//		private function initDiamondsMain():void
//		{
//			var diamondsMain:MainPanel = new MainPanel();
//			container.addChild(diamondsMain);
//			diamondsMain.initialization();
//			
//			// 
//			var scale:Number = stage.stageWidth / diamondsMain.width;
//			var rects:Rectangle = diamondsMain.getBounds(diamondsMain);
//			diamondsMain.scaleX = diamondsMain.scaleY = scale;
//			diamondsMain.x = (stage.stageWidth - diamondsMain.width) * 0.5 - rects.x * scale * 0.5;
//		}
		
	}
}