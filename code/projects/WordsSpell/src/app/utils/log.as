package app.utils
{
	import app.Global;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-27
	 */
		public function log( ...args ):void
		{
			if ( Global.isDebug )
			{
				trace( args );
			}
		}
}