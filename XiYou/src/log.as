package
{

	import com.demonsters.debugger.MonsterDebugger;
	
	import global.Global;
	
	import utils.DebugConsole;


	/**
	 * @author Chenzhe
	 */
	public function log(... messages) : void
	{
		if (Global.isDebug)
		{	
//			DebugConsole.show(messages.join(' '));
			trace.apply(null, messages);
//			MonsterDebugger.log(messages.join(' '));
		}
	}
}
