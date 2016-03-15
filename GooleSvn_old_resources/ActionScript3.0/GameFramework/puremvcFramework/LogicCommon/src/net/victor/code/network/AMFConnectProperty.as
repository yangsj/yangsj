package net.victor.code.network
{
	public class AMFConnectProperty implements INetWorkConnectionProperty
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		private var _gateway:String;
		public function AMFConnectProperty(gateway:String)
		{
			_gateway = gateway;
		}
		
		public function get connectType():String
		{
			return NetWorkConnectTypes.AMF;
		}
		
		public function get host():String
		{
			return "localhost";
		}
		
		public function get port():int
		{
			return 80;
		}
		
		public function get gateway():String
		{
			return _gateway;
		}
		
		public function get securityPolicy():*
		{
			return [];
		}
		
		public function get otherProperties():Array
		{
			return null;
		}
		
		public function dispose():void
		{
		}
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}