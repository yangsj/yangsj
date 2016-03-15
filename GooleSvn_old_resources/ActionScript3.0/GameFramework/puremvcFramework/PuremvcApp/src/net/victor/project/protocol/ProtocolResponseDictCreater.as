package net.victor.project.protocol
{
	import flash.utils.Dictionary;
	
	import net.victor.project.notificationNames.ProtocolResponseNotificationNames;
	import net.victor.project.protocol.amf.ProtocolIds;

	public class ProtocolResponseDictCreater
	{
		/////////////////////////////////////////static /////////////////////////////////
		static public function create():Dictionary
		{
			var dict:Dictionary = new Dictionary(true);
			
			dict[ProtocolIds.KeepAliveProtocolId] = ProtocolResponseNotificationNames.KeepAliveResponseCommand;
			//dict["10003"] = ProtocolResponseNotificationNames.KeepAliveResponseCommand;
			
			
			return dict;
		}
	}
}