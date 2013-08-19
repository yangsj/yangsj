package
{	
	import code.Global;
	
	import ui.UIMain01;
	
	[SWF(width="1280", height="720", frameRate="24")]
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class project_01 extends Project 
	{
		public function project_01()
		{
			Global.projectType = Global.PROJECT_01;
			
			clz = UIMain01;
			
			super();
		}
	}
}