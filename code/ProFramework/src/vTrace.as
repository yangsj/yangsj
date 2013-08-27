package
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-27
	 */
		public function vTrace( ...args ):void
		{
			if ( Global.isDebug )
			{
				trace( args );
			}
		}
}