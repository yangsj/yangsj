package net.victor.code.app.managers.interfaces
{
	import net.victor.code.managers.interfaces.IManagerCernterable;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public interface ITimerManager extends IManagerCernterable
	{
		function setTimeout(timerName:String, secounds:Number, notification:INotification):String;
		
		function clearTimeout(timerName:String):String;
		
		function setInterval(timerName:String, intervalSeconds:Number, notification:INotification):String;
		
		function clearInterval(timerName:String):String;
	}
}