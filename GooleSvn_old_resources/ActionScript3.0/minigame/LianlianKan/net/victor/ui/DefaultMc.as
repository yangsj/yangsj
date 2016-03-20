package net.victor.ui
{

	public class DefaultMc extends BaseMc
	{

		public function DefaultMc()
		{
			wireFrame = wireFrameMc;
			super();
			id = McType.DefaultMc;
			this.mouseChildren = this.mouseEnabled = false;
		}
	}

}