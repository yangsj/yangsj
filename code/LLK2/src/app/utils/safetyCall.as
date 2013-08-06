package app.utils
{

	/**
	 * ……
	 * @author yangsj
	 */
	public function safetyCall( fun:Function, ... args ):void
	{
		if ( fun != null )
		{
			if ( fun.length > 0 )
			{
				fun.apply( this, args );
			}
			else
			{
				fun.apply( this );
			}
		}
	}

}
