package net.vyky.managers
{
	import com.greensock.events.TweenEvent;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import com.greensock.TweenMax;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author KingYang
	 * @qq 729264471
	 * @email acsh_ysj@163.com
	 */
	public class VPopUpManager
	{
		private static var _stage:Stage;
		private static var _thisContainer:Sprite;
		private static var _width:Number;
		private static var _height:Number;
		private static var _displayObject:DisplayObject;
		private static var _isIn:Boolean;
		
		public function VPopUpManager(){}
		
		static public function init($stage:DisplayObject):void
		{
			stage = $stage.stage;
			createThisContainer();
		}
		
		static public function addPop(value:DisplayObject):void
		{
			displayObject = value;
			_isIn = true;
			displayObject.addEventListener(MouseEvent.CLICK, onMouseClickHandler);
			if (stage && _thisContainer && !_thisContainer.parent)
			{
				stage.addChild(_thisContainer as DisplayObject);			
				_thisContainer.addChild(value as DisplayObject);
				
				_width  = (value.getBounds(value).width  + 2 * (value.getBounds(value).x));
				_height = (value.getBounds(value).height + 2 * (value.getBounds(value).y));
				
				value.x = (0 - _width) / 2;
				value.y = (0 - _height) / 2;
				
				TweenMax.to(_thisContainer,  .5, { scaleX:1, scaleY:1, onCompleteListener:tweenMaxCompleteListenerHandler_1 } );
			}
		}
		
		static private function onMouseClickHandler(e:MouseEvent):void 
		{
			if (e.target.name == 'closeBtn') VPopUpManager.removePop();
		}
		
		static public function removePop():void
		{
			_isIn = false;
			TweenMax.to(_thisContainer,  .5, { scaleX:0, scaleY:0, onCompleteListener:tweenMaxCompleteListenerHandler_1 } );
		}
		
		static private function tweenMaxCompleteListenerHandler_1(e:TweenEvent):void
		{
			TweenMax.killTweensOf(e.target.target);
			if (!_isIn && displayObject && displayObject.parent) displayObject.parent.removeChild(displayObject);
			if (!_isIn && _thisContainer && _thisContainer.parent) _thisContainer.parent.removeChild(_thisContainer);
		}
		
		static private function createThisContainer():void
		{
			if (!_thisContainer) _thisContainer = new Sprite();
			_thisContainer.graphics.beginFill(0x000000, .5);
			_thisContainer.graphics.drawRect( -(stage.stageWidth / 2), -(stage.stageHeight / 2), stage.stageWidth, stage.stageHeight);
			_thisContainer.graphics.endFill();
			
			_thisContainer.x = stage.stageWidth / 2;
			_thisContainer.y = stage.stageHeight / 2;
			_thisContainer.scaleX = .00;
			_thisContainer.scaleY = .00;
		}
		
		static private function get stage():Stage { return _stage; }
		
		static private function set stage(value:Stage):void 
		{
			_stage = value;
		}
		
		static private function get displayObject():DisplayObject { return _displayObject; }
		
		static private function set displayObject(value:DisplayObject):void 
		{
			_displayObject = value;
		}
		
	}

}