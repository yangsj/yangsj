package net.victor.app.managers.model
{
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	import net.jt_tech.app.managers.interfaces.IEffectItem;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.observer.Notifier;
	
	public class EffectItem extends Notifier implements IEffectItem
	{
		/////////////////////////////////////////static /////////////////////////////////
		static private var _id:int = 0;
		
		/////////////////////////////////////////vars /////////////////////////////////
		private var _effectType:String;
		private var _displayObject:DisplayObject;
		private var _effectTarget:Object;
		
		private var _point:Point;
		private var _callBackNotificationName:String;
		private var _callBackNotification:INotification;
		public function EffectItem()
		{
			_id ++;
		}
		
		public function get effectType():String
		{
			return _effectType;
		}
		
		public function set effectType(value:String):void
		{
			_effectType = value;
		}
		
		public function play():void
		{
			if(this.displayObject)
			{
				displayObject.addEventListener(Event.ENTER_FRAME, onEnterFrame);
				var mc:MovieClip = displayObject as MovieClip;
				if(mc)
				{
					mc.gotoAndPlay(1);
				}
			}
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function get displayObject():DisplayObject
		{
			return _displayObject;
		}
		
		public function set displayObject(value:DisplayObject):void
		{
			_displayObject = value;
		}
		
		public function get effectTarget():Object
		{
			return _effectTarget;
		}
		
		public function set effectTarget(value:Object):void
		{
			_effectTarget = value;
		}
		
		public function get point():Point
		{
			return _point;
		}
		
		public function set point(value:Point):void
		{
			_point = value;
		}
		
		public function get callBackNotificationName():String
		{
			return _callBackNotificationName;
		}
		
		public function set callBackNotificationName(value:String):void
		{
			_callBackNotificationName = value;
		}
		
		public function get callBackNotification():INotification
		{
			return _callBackNotification;
		}
		
		public function set callBackNotification(value:INotification):void
		{
			_callBackNotification = value;
		}
		
		override public function dispose():void
		{
			
			if(displayObject)
			{
				displayObject.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
			_effectType = null;
			_displayObject = null;
			_effectTarget = null;
			
			_point = null;
			_callBackNotificationName = null;
			_callBackNotification = null;
			
			super.dispose();
		}
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
		private function onEnterFrame(e:Event):void
		{
			var mc:MovieClip = displayObject as MovieClip;
			if(mc)
			{
				if(mc.currentFrame >= mc.totalFrames)
				{
					displayObject.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					
					if(_callBackNotificationName && this._callBackNotificationName.length > 0)
					{
						this.sendNotification(_callBackNotificationName, this._callBackNotification);
					}
					this.sendNotification(EffectsNotification.CloseCommonEffectCommand, this);
				}
			}
			else
			{
				displayObject.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				if(_callBackNotificationName && this._callBackNotificationName.length > 0)
				{
					this.sendNotification(_callBackNotificationName, this._callBackNotification);
				}
				
				this.sendNotification(EffectsNotification.CloseCommonEffectCommand, this);
			}
		}
	}
}