package net.victor.project.protocol.amf
{
	import flash.net.getClassByAlias;
	import flash.net.registerClassAlias;
	
	import net.victor.project.protocol.amf.msg.KeepAlive;
	import net.victor.project.protocol.amf.msg.KeepAlive22;
	import net.victor.project.protocol.amf.msg.TestProtocol;

	public class ProtocolRegisterAlias
	{
		/////////////////////////////////////////static /////////////////////////////////
		static private var remoteProtocolPackageURL:String = "net.jt_tech.diamond.protocol.amf.msg";
		static public function registerAlias():void
		{
			registerProtocolAlias();
			registerVoAlias();
		}
		
		static private function registerProtocolAlias():void
		{
			registerClassAlias(remoteProtocolPackageURL + ".TestProtocol", TestProtocol);
			registerClassAlias(remoteProtocolPackageURL + ".KeepAlive", KeepAlive);
			registerClassAlias(remoteProtocolPackageURL + ".KeepAlive22", KeepAlive22);
			//getClassByAlias(remoteProtocolPackageURL + ".TestProtocol");
		}
		
		static private function registerVoAlias():void
		{
			
		}
		
	}
}