package net.victor.code.app
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import net.victor.code.framework.AppViewMediator;
	
//	import nl.demonsters.debugger.MonsterDebugger;
	
	/**
	 * EP主界面 
	 * 
	 */	
	public class AppMainMediator extends AppViewMediator
	{
		/**
		 * 主界面Name 
		 */		
		public static const AppMainMediatorName:String = "AppMainMediatorName";
		
		private var _stage:Stage;
		
		//顶层
		private var _topContainer:Sprite;
		
		//消息特效层
		private var _EffctContainer:Sprite;
		
		//弹出面板层
		private var _panelContainer:Sprite;
		
		//场景层
		private var _seceneContainer:Sprite;
		
		public function AppMainMediator(viewComponent:Stage)
		{
			super(AppMainMediatorName, viewComponent);
			
			this._stage = viewComponent;
			init();
		}
		
		public function get stage():Stage
		{
			return _stage;
		}
		
		private function init():void
		{
			//场景层
			_seceneContainer = new Sprite();
			_seceneContainer.mouseEnabled = false;
			_seceneContainer.mouseChildren = true;
			this.stage.addChild(_seceneContainer);
			
			//弹出面板层
			_panelContainer = new Sprite();
			_panelContainer.mouseEnabled = false;
			_panelContainer.mouseChildren = true;
			this.stage.addChild(_panelContainer);
			
			_topContainer = new Sprite();
			_topContainer.mouseEnabled = false;
			_topContainer.mouseChildren = true;
			stage.addChild(_topContainer);
			
			_EffctContainer = new Sprite();
			_EffctContainer.mouseEnabled = true;
			_EffctContainer.mouseChildren = false;
			stage.addChild(_EffctContainer);
		}
		
		public function addPanelToSceneLayer(displayObject:DisplayObject, index:int=-1, $alpha:Number = 0.4):void
		{
			if(index >= 0)
			{
				_seceneContainer.addChildAt(displayObject, index);
			}
			else
			{
				_seceneContainer.addChild(displayObject);
			}
			
			var setEnableds:Boolean = ($alpha != 0);
			updateMouseEnable(_seceneContainer, $alpha, setEnableds);
		}
		
		public function addPanelToTop(displayObject:DisplayObject, index:int=-1, $alpha:Number = 0.4):void
		{
			if(index >= 0)
			{
				_topContainer.addChildAt(displayObject, index);
			}
			else
			{
				_topContainer.addChild(displayObject);
			}
			
			var setEnableds:Boolean = ($alpha != 0);
			updateMouseEnable(_topContainer, $alpha, setEnableds);
		}
		
		/**
		 * 显示弹出面板 
		 * @param displayObject
		 * @param index 默认不设置层次
		 * 
		 */		
		public function addPanel(displayObject:DisplayObject, index:int=-1, $alpha:Number = 0.4):void
		{
			if(index >= 0)
			{
				_panelContainer.addChildAt(displayObject, index);
			}
			else
			{
				_panelContainer.addChild(displayObject);
			}
			
			var setEnableds:Boolean = ($alpha != 0);
			updateMouseEnable(_panelContainer, $alpha, setEnableds);
		}
		
		/**
		 * 把面板移出显示列表 
		 * @param displayObject
		 * 
		 */		
		public function removePanel(displayObject:DisplayObject):void
		{
			if(displayObject && displayObject.parent)
			{
				var container:Sprite = displayObject.parent as Sprite;
				displayObject.parent.removeChild(displayObject);
				updateMouseEnable(container);
			}
		}
		
		/**
		 *　显示特效 
		 * @param displayObject
		 * @param index
		 * 
		 */		
		public function addEffect(displayObject:DisplayObject, index:int=-1):void
		{
			if(index >= 0)
			{
				_EffctContainer.addChildAt(displayObject, index);
			}
			else
			{
				_EffctContainer.addChild(displayObject);
			}
			updateMouseEnable(_EffctContainer, 0, false);
		}
		
		/**
		 * 移除 
		 * @param displayObject 
		 */		
		public function removeEffect(displayObject:DisplayObject):void
		{
			if(displayObject && displayObject.parent)
			{
				displayObject.parent.removeChild(displayObject);
			}
			updateMouseEnable(_EffctContainer, 0, false);
		}
		
		private function setCover(dis:Sprite, $alpha:Number=0.4):void
		{
			dis.graphics.clear();
			dis.graphics.beginFill(0x000000, $alpha);
			dis.graphics.drawRect(0, 0, 2000, 2000);
			dis.graphics.endFill();
		}
		
		private function updateMouseEnable(dis:Sprite, $alpha:Number=0.4, setEnable:Boolean=true):void
		{
			if(dis.numChildren > 0)
			{
				if(setEnable)
				{
					dis.mouseEnabled = true;
				}
				setCover(dis, $alpha)
			}
			else
			{
				if(setEnable)
				{
					dis.mouseEnabled = false;
				}
				dis.graphics.clear();
			}
			dis.mouseChildren = true;
		}
	}
}