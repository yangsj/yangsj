package
{
	import diamonds.DiamondType;
	import diamonds.DiamondsPool;
	import diamonds.MainPanel;
	import diamonds.UsePropEffect;
	import diamonds.resource.Diamonds;
	
	import display.SpriteClip;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import managers.BackGroundManager;
	import managers.PanelManager;
	import managers.SceneManager;
	
	import panel.select.StartSelectPanel;
	
	import res.loader.LoaderManager;
	
	[SWF(width="480", height="800", frameRate="60")]
	
	public class DiamondsDemo extends Sprite
	{
		
		private var selectPanel:StartSelectPanel;
		private var diamondsMain:MainPanel;
		
		private var container:Sprite;
		private var loading:Sprite;
		
		private var panelContainer:Sprite;
		private var backGroundContainer:Sprite;
		private var sceneContainer:Sprite;
		
		public function DiamondsDemo()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			Global.isOpenMusic = true;
			Global.isDebug = true;
//			Global.isOpenAutoClickProgram = true;
			
			if (this.stage) initialization();
			else this.addEventListener(Event.ADDED_TO_STAGE, initialization);
		}
		
		private function initialization(event:Event=null):void
		{
			Global.stage = this.stage;
			
			initContainer();
			
			this.addChild(new Stats());
			
			start();
		}
		
		private function initContainer():void
		{
			backGroundContainer = new Sprite();
			sceneContainer = new Sprite();
			panelContainer = new Sprite();
			this.addChild(backGroundContainer);
			this.addChild(sceneContainer);
			this.addChild(panelContainer);
			
			PanelManager.instance.panelContainer = panelContainer;
			BackGroundManager.instance.backGroundContainer = backGroundContainer;
			SceneManager.instance.sceneContainer = sceneContainer;
		}
		
		private function start():void
		{
			var loader:LoaderManager = new LoaderManager();
			loader.callBack = callBackFunction;
			loader.load();
			loader = null;
			
//			callBackFunction();
		}
		
		private function callBackFunction():void
		{
			addSelectPanel();
			createDiamondsPoolObject();
		}
		
		/** 初始化钻石对象到对象池 */
		private function createDiamondsPoolObject():void
		{
			var diamondTypeArray:Array = DiamondType.diamondTypeArray;
			const diamondsLength:int = diamondTypeArray.length;
			for (var i:int = 0; i < 100; i ++)
			{
				var rnd:int	= int(Math.random() * diamondsLength);
				var id:int	= diamondTypeArray[rnd];
				var poolNamestr:String = MainPanel.poolString + id;
				var card:Diamonds = new Diamonds(id);
				DiamondsPool.setObject(card, poolNamestr);
			}
			var lengL:int = DiamondType.propEffectIdArray.length;
			for (i = 0; i < lengL; i++)
			{
				var idEffect:int = DiamondType.propEffectIdArray[i];
				var poolNameEffect:String = DiamondType.usePropEffectName + String(idEffect);
				for (var j:int = 0; j < 2; j++)
				{
					var usePropEffect:UsePropEffect = new UsePropEffect(idEffect, 0, 0, function ():void{});
					DiamondsPool.setObject(usePropEffect, poolNameEffect);
				}
			}
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
		
		private function addSelectPanel():void
		{
			selectPanel = new StartSelectPanel();
			selectPanel.callBackFunction = startGameDiamonds;
			PanelManager.instance.addPanel(selectPanel);
			
			if (loading)
			{
				if (loading.parent) loading.parent.removeChild(loading);
				loading = null;
			}
		}
		
		private function startGameDiamonds():void
		{
			removeSelectPanel();
			initDiamondsMain();
		}
		
		private function removeSelectPanel():void
		{
			if (selectPanel)
			{
				PanelManager.instance.removePanel(selectPanel);
				selectPanel = null;
			}
		}
		
		private function initDiamondsMain():void
		{
			diamondsMain = new MainPanel();
			SceneManager.instance.addChild(diamondsMain);
			diamondsMain.playOverCallFunction = callBackFunction;
			diamondsMain.initialization();
			
			// 
			var scale:Number = stage.stageWidth / diamondsMain.width;
			var rects:Rectangle = diamondsMain.getBounds(diamondsMain);
			diamondsMain.scaleX = diamondsMain.scaleY = scale;
			diamondsMain.x = (stage.stageWidth - diamondsMain.width) * 0.5 - rects.x * scale * 0.5;
		}
		
	}
}