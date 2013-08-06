package framework
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-5
	 */
	public class BaseScene extends BaseView
	{
		public function BaseScene()
		{
			super();
		}
		
		override public function show():void
		{
			ViewStruct.addScene( this );
		}
	}
}