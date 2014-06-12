package victor.framework.utils
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-12
	 */
	public function call( func:Function, ...args ):void
	{
		if ( func != null )
		{
			if ( func.length == 0 )
			{
				func();
			}
			else
			{
				func.apply( null, args );
			}
		}
	}
}