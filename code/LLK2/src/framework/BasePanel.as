package framework
{

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class BasePanel extends BaseView
	{
		public function BasePanel()
		{
			super();
		}

		override public function show():void
		{
			ViewStruct.addPanel( this );
		}

	}
}
