package test
{

	import network.ProtocolIDs;
	import network.WebResponder;


	/**
	 * 说明：TestWebResponder
	 * @author Victor
	 * 2012-10-31
	 */
	public class TestWebResponder extends WebResponder
	{


		public function TestWebResponder(onResult : Function = null, args : Array = null)
		{
			super(onResult, args);
		}

		override public function get protocolID() : String
		{
			return ProtocolIDs.LOGIN;
		}

	}

}
