package app.utils
{
	import app.Global;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public function debug( ...args ):void
	{
		if ( Global.isDebug )
		{
			trace( "debug:", args );
		}
	}
}