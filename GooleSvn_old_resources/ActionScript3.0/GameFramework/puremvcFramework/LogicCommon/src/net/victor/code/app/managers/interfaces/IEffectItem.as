package net.victor.code.app.managers.interfaces
{
	import com.newbye.interfaces.IDisposable;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.observer.Notification;
	
	public interface IEffectItem extends IDisposable
	{
		function get effectType():String;
		function set effectType(value:String):void;
		
		function get id():int;
		
		function play():void;
		
		function get displayObject():DisplayObject;
		function set displayObject(value:DisplayObject):void;
		
		function get effectTarget():Object;
		function set effectTarget(value:Object):void;
		
		function get point():Point;
		function set point(value:Point):void;
		
		function get callBackNotificationName():String;
		function set callBackNotificationName(value:String):void;
		
		function get callBackNotification():INotification;
		function set callBackNotification(value:INotification):void;
	}
}