package utils
{


	public class CallbackInfo
	{
		public static const NO_DELAY : int = -1;
		public static const LOOP : int = -1;
		public var callback : Function;
		public var delay : int;
		public var repeat : Boolean;

		public function CallbackInfo(callback : Function, delay : int = -1, repeat : Boolean = false)
		{
			this.callback = callback;
			this.delay = delay;
			this.repeat = repeat;
		}
	}
}
