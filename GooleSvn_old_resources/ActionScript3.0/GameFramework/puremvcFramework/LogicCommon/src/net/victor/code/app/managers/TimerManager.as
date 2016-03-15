package net.victor.code.app.managers
{
	
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import net.victor.code.app.managers.interfaces.ITimerManager;
	import net.victor.code.errors.LCErrorTypes;
	import net.victor.code.framework.AppFacade;
	import net.victor.code.managers.AppManagerIn;
	import net.victor.code.managers.ManagerCenterableBase;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class TimerManager extends ManagerCenterableBase implements ITimerManager
	{
		/////////////////////////////////////////static /////////////////////////////////
		private static var _instance:ITimerManager;
		
		AppManagerIn static function get instance():ITimerManager
		{
			if(null == _instance)
			{
				_instance = new TimerManager();
			}
			return _instance;
		}
		
		AppManagerIn static function getInstance():ITimerManager
		{
			return AppManagerIn::instance;
		}
		
		/////////////////////////////////////////vars /////////////////////////////////
		private var _timeoutDic:Dictionary = new Dictionary();
		private var _intervalDic:Dictionary = new Dictionary();
		public function TimerManager()
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
		
		public function setTimeout(timerName:String, secounds:Number, notification:INotification):String
		{
			if(secounds < 0.001)
			{
				return timerName;
			}
			clearTimeout(timerName);
			_timeoutDic[timerName] = flash.utils.setTimeout(
				function ():void
				{
					AppFacade.instance.sendNotification(notification.name, notification.body, notification.type);
				}, 
				secounds * 1000);
			return timerName;
		}
		
		public function setInterval(timerName:String, intervalSeconds:Number, notification:INotification):String
		{
			if(intervalSeconds < 0.001)
			{
				return timerName;
			}
			clearInterval(timerName);
			_intervalDic[timerName] = flash.utils.setInterval(
				function ():void
				{
					AppFacade.instance.sendNotification(notification.name, notification.body, notification.type);
				}, 
				intervalSeconds * 1000);
			return timerName;
		}
		
		
		public function clearTimeout(timerName:String):String
		{
			if(_timeoutDic[timerName])
			{
				flash.utils.clearTimeout(_timeoutDic[timerName]);
				
				delete _timeoutDic[timerName];
			}
			return timerName;
		}
		
		
		public function clearInterval(timerName:String):String
		{
			if(_intervalDic[timerName])
			{
				flash.utils.clearInterval(_intervalDic[timerName]);
				
				delete _intervalDic[timerName];
			}
			return timerName;
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}