package net.victor.code.framework
{
	import com.newbye.framework.interfaces.IView;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	
	
	/**
	 * 说明：LCView
	 * @author victor
	 * 2012-7-7 上午9:56:44
	 */
	
	public class AppView implements IView
	{
		
		////////////////// vars /////////////////////////////////
		
		
		
		public function AppView()
		{
		}
		
		public function get alpha():Number
		{
			return 0;
		}
		
		public function set alpha(value:Number):void
		{
		}
		
		public function get blendMode():String
		{
			return null;
		}
		
		public function set blendMode(value:String):void
		{
		}
		
		public function get cacheAsBitmap():Boolean
		{
			return false;
		}
		
		public function set cacheAsBitmap(value:Boolean):void
		{
		}
		
		public function get filters():Array
		{
			return null;
		}
		
		public function set filters(value:Array):void
		{
		}
		
		public function get height():Number
		{
			return 0;
		}
		
		public function set height(value:Number):void
		{
		}
		
		public function get loaderInfo():LoaderInfo
		{
			return null;
		}
		
		public function get mask():DisplayObject
		{
			return null;
		}
		
		public function set mask(value:DisplayObject):void
		{
		}
		
		public function get mouseX():Number
		{
			return 0;
		}
		
		public function get mouseY():Number
		{
			return 0;
		}
		
		public function get name():String
		{
			return null;
		}
		
		public function set name(value:String):void
		{
		}
		
		public function get opaqueBackground():Object
		{
			return null;
		}
		
		public function set opaqueBackground(value:Object):void
		{
		}
		
		public function get parent():DisplayObjectContainer
		{
			return null;
		}
		
		public function get root():DisplayObject
		{
			return null;
		}
		
		public function get rotation():Number
		{
			return 0;
		}
		
		public function set rotation(value:Number):void
		{
		}
		
		public function get scale9Grid():Rectangle
		{
			return null;
		}
		
		public function set scale9Grid(value:Rectangle):void
		{
		}
		
		public function get scaleX():Number
		{
			return 0;
		}
		
		public function set scaleX(value:Number):void
		{
		}
		
		public function get scaleY():Number
		{
			return 0;
		}
		
		public function set scaleY(value:Number):void
		{
		}
		
		public function get scrollRect():Rectangle
		{
			return null;
		}
		
		public function set scrollRect(value:Rectangle):void
		{
		}
		
		public function get stage():Stage
		{
			return null;
		}
		
		public function get transform():Transform
		{
			return null;
		}
		
		public function set transform(value:Transform):void
		{
		}
		
		public function get visible():Boolean
		{
			return false;
		}
		
		public function set visible(value:Boolean):void
		{
		}
		
		public function get width():Number
		{
			return 0;
		}
		
		public function set width(value:Number):void
		{
		}
		
		public function get x():Number
		{
			return 0;
		}
		
		public function set x(value:Number):void
		{
		}
		
		public function get y():Number
		{
			return 0;
		}
		
		public function set y(value:Number):void
		{
		}
		
		public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle
		{
			return null;
		}
		
		public function getRect(targetCoordinateSpace:DisplayObject):Rectangle
		{
			return null;
		}
		
		public function globalToLocal(point:Point):Point
		{
			return null;
		}
		
		public function hitTestObject(obj:DisplayObject):Boolean
		{
			return false;
		}
		
		public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean=false):Boolean
		{
			return false;
		}
		
		public function localToGlobal(point:Point):Point
		{
			return null;
		}
		
		public function dispose():void
		{
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return false;
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return false;
		}
		
		public function willTrigger(type:String):Boolean
		{
			return false;
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}