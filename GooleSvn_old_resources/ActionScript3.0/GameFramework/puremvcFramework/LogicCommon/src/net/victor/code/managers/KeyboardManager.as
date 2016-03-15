package net.victor.code.managers
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import net.victor.code.errors.LCErrorTypes;
	import net.victor.code.framework.AppFacade;
	import net.victor.code.managers.interfaces.IKeyboardManager;
	
	import org.puremvc.as3.patterns.observer.Notification;
	
	public class KeyboardManager extends ManagerCenterableBase implements IKeyboardManager
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		static private var _instance:IKeyboardManager;
		static AppManagerIn function get instance():IKeyboardManager
		{
			if(!_instance)
			{
				_instance = new KeyboardManager();
			}
			return _instance;
		}
		AppManagerIn static function getInstance():IKeyboardManager
		{
			return AppManagerIn::instance;
		}
		
		/////////////////////////////////////////vars /////////////////////////////////
		private var _stage:Stage;
		private var _keydownDelay:Number;
		
		
		private var _shortcuts:Dictionary = new Dictionary();
		
		private var _pressingKeycodes:Array = [];
		
		private var _currentGroupKey:String;
		private var _currentItemKey:String;
		
		private var _timeOut:int;
		private var _hasKeyup:Boolean;
		public function KeyboardManager()
		{
			if(_instance)
			{
				throw new Error(LCErrorTypes.SINGLETON_ERROR);
			}
			else
			{
				_instance = this;
			}
		}
		
		public function init(stage:Stage, keydownDelay:Number=1000):void
		{
			if(_stage)
			{
				return;
			}
			_stage = stage;
			_keydownDelay = keydownDelay;
			removeEvents();
			addEvents();
		}
		
		public function addShortcutCallBack(callBack:Function, ctrl:Boolean, shift:Boolean, alt:Boolean, firstKeyCode:uint, ...args):void
		{
			args.unshift(firstKeyCode);
			args.unshift(alt);
			args.unshift(shift);
			args.unshift(ctrl);
			args.unshift(callBack);
			
			addShortcut.apply(this, args);
		}
		
		public function addShortcutNotification(notification:Notification, ctrl:Boolean, shift:Boolean, alt:Boolean, firstKeyCode:uint, ...args):void
		{
			args.unshift(firstKeyCode);
			args.unshift(alt);
			args.unshift(shift);
			args.unshift(ctrl);
			args.unshift(notification);
			
			addShortcut.apply(this, args);
		}
		
		public function addShortcutCommand(commandName:String, ctrl:Boolean, shift:Boolean, alt:Boolean, firstKeyCode:uint, ...args):void
		{
			args.unshift(firstKeyCode);
			args.unshift(alt);
			args.unshift(shift);
			args.unshift(ctrl);
			args.unshift(commandName);
			
			addShortcut.apply(this, args);
		}
		
		public function hasShortcut(ctrl:Boolean, shift:Boolean, alt:Boolean, firstKeyCode:uint, ...args):Boolean
		{
			var gk:String = getGroupKey(ctrl, shift, alt);
			
			var gdic:Dictionary = this._shortcuts[gk];
			if(gdic)
			{
				var itemkeyargs:Array = args as Array;
				itemkeyargs.unshift(firstKeyCode);
				var ik:String = getItemKey(itemkeyargs);
				
				if(gdic[ik])
				{
					return true;
				}
			}
			return false;
		}
		
		public function removeShortcut(ctrl:Boolean, shift:Boolean, alt:Boolean, firstKeyCode:uint, ...args):void
		{
			var gk:String = getGroupKey(ctrl, shift, alt);
			
			var gdic:Dictionary = this._shortcuts[gk];
			if(gdic)
			{
				var itemkeyargs:Array = args as Array;
				itemkeyargs.unshift(firstKeyCode);
				var ik:String = getItemKey(itemkeyargs);
				delete gdic[ik];
			}
		}
		
		public function sendNotification(notificationName:String, body:Object=null, type:String=null):void
		{
			AppFacade.instance.sendNotification(notificationName, body, type);
		}
		
		public function dispose():void
		{
		}
		/////////////////////////////////////////private ////////////////////////////////
		
		private function addShortcut(obj:*, ctrl:Boolean, shift:Boolean, alt:Boolean, firstKeyCode:uint, ...args):void
		{
			var groupkey:String = getGroupKey(ctrl, shift, alt);
			var groupDic:Dictionary = this._shortcuts[groupkey];
			if(!groupDic)
			{
				groupDic = new Dictionary();
				this._shortcuts[groupkey] = groupDic;
			}
			
			var itemkeyargs:Array = args as Array;
			
			itemkeyargs.unshift(firstKeyCode);
			
			var itemkey:String = getItemKey(itemkeyargs);
			
			groupDic[itemkey] = obj;
		}
		
		private function getGroupKey(ctrl:Boolean, shift:Boolean, alt:Boolean):String
		{
			var groupkey:String = ctrl.toString() + shift.toString() + alt.toString();
			
			return groupkey;
		}
		
		private function getItemKey(keycodes:Array):String
		{
			var itemkey:String = "";
			for each(var ki:uint in keycodes)
			{
				itemkey += "_" + ki;
			}
			
			return itemkey;
		}
		
		
		private function onShortcutPress(cbobj:*):void
		{
			if(cbobj is Function)
			{
				cbobj();
			}
			else if(cbobj is Notification)
			{
				var noti:Notification = cbobj as Notification;
				sendNotification(noti.name, noti.body, noti.type);
			}
			else if(cbobj is String)
			{
				sendNotification(cbobj as String);
			}
				
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
		private function addEvents():void
		{
			this._stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeydown);
			this._stage.addEventListener(KeyboardEvent.KEY_UP, onKeyup);
		}
		
		private function removeEvents():void
		{
			this._stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeydown);
			this._stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyup);
		}
		
		
		private function onKeydown(e:KeyboardEvent):void
		{
			if(_pressingKeycodes.length > 5)
			{
				
			}
			if(e.keyCode != KeyCodes.CONTROL && e.keyCode != KeyCodes.ALT && e.keyCode != KeyCodes.SHIFT)
			{
				if(_pressingKeycodes.indexOf(e.keyCode) < 0 || _hasKeyup)
				{
					_pressingKeycodes.push(e.keyCode);
					_hasKeyup = false;
				}
			}
			
			var curGroupKey:String	= getGroupKey(e.ctrlKey, e.shiftKey, e.altKey);
			var groupDic:Dictionary = this._shortcuts[curGroupKey];
			if(groupDic)
			{
				var cikey:String = getItemKey(this._pressingKeycodes);
				if(cikey == this._currentItemKey && curGroupKey == _currentGroupKey)
				{
					return;
				}
				_currentGroupKey = curGroupKey;
				_currentItemKey = cikey;
				if(groupDic[_currentItemKey])
				{
					_pressingKeycodes.splice(0);
					onShortcutPress(groupDic[_currentItemKey]);
				}
			}
		}
		
		private function onKeyup(e:KeyboardEvent):void
		{
			clearTimeout(this._timeOut);
			_hasKeyup = true;
			this._timeOut = setTimeout(clearKeyCode, this._keydownDelay, e.keyCode);
		}
		
		private function clearKeyCode(keycode:uint):void
		{
			_currentGroupKey = "";
			_currentItemKey = "";
			_hasKeyup = false;
			var ci:int;
			while((ci = _pressingKeycodes.indexOf(keycode)) >= 0)
			{
				_pressingKeycodes.splice(ci, 1);
			}
		}
	}
}