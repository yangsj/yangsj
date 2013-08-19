package
{
	
	import code.Global;
	
	import ui.UIMain02;
	
	[SWF(width="1280", height="720", frameRate="24")]
	/**
	 * ……
	 * @author yangsj
	 */
	public class project_02 extends Project
	{
		public function project_02()
		{
			Global.projectType = Global.PROJECT_02;
			
			clz = UIMain02;
			
			super();
		}
	}
}