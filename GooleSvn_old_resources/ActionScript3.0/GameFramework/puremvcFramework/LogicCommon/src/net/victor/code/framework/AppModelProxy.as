package net.victor.code.framework
{
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class AppModelProxy extends Proxy
	{
		public function AppModelProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
		
		override public function setData(data:Object):void
		{
			super.setData(data);
		}
	}
}