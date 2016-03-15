package net.victor.project.commands.base
{
	import net.victor.code.response.IWebServiceResponse;
	
	public class WebServiceExchangeCommand extends AppLogicCommandBase implements IWebServiceResponse
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		public function WebServiceExchangeCommand()
		{
			super();
		}
		
		public function onCompleteListener(result:Object):void
		{
			onComplete(result);
		}
		
		public function onErrorListener(result:Object):void
		{
			onError(result);
		}
		
		public function onComplete(result:Object):void
		{
			
		}
		
		public function onFailed(result:Object):void
		{
			
		}
		
		public function onError(result:Object):void
		{
			
		}
		
		protected function isSuccess(result:Object):Boolean
		{
			var msg:* = result.body;
			if(msg && !msg.error_code)
			{
				return true;
			}
			
			return false;
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}