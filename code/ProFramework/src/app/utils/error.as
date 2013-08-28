package app.utils
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public function error( ...args ):void
	{
		if ( Global.isDebug )
		{
			trace("error:", args );
		}
	}
}