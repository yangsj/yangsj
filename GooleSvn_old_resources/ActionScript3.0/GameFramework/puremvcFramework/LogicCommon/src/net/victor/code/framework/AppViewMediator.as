package net.victor.code.framework
{
	import com.newbye.framework.ViewMediator;
	import com.newbye.framework.interfaces.IView;
	
	import flash.display.DisplayObject;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * 要重写 dispose方法
	 * 
	 */	
	public class AppViewMediator extends ViewMediator
	{
		protected static const ABSTRACT_ERROR:String = "请override 此方法,并在适的地方调用super.disose()";
		public function AppViewMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
		
		
		override public function dispose():void
		{
			throw new Error(ABSTRACT_ERROR);
		}
		
		protected function getProxy(proxyName:String):IProxy
		{
			return facade.retrieveProxy(proxyName);
		}
	}
}