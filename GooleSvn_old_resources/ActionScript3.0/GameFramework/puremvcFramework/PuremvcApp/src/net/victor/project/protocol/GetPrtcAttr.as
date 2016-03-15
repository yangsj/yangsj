package net.victor.project.protocol
{
	import net.victor.project.models.ModelProxyNames;

	public class GetPrtcAttr
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		
		private var _id:String;
		public function GetPrtcAttr(id:String)
		{
			_id=id;
		}
		
		
		/////////////////////////////////////////public /////////////////////////////////
		public function getRemoteMethod():String
		{
			return "";//prtcModelProxy().node(_id).@src;
		}
		public function getKey():String
		{
			return "";//prtcModelProxy().node(_id).@key;
		}
		public function getType():String
		{
			return "";//prtcModelProxy().node(_id).@type;
		}
		public function prtcModelProxy():void//PrtcModelProxy
		{
		 //return 	"";//AppFacade.instance.retrieveProxy(ModelProxyNames.PrtcModelProxy) as PrtcModelProxy
		}
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}