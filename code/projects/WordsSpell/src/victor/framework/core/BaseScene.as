package victor.framework.core
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-5
	 */
	public class BaseScene extends ViewSprite
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