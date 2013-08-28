package app.modules.panel.test
{
	import victor.framework.core.BasePanel;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class TestView extends BasePanel
	{
		public function TestView()
		{
			
		}
		
		override protected function get skinName():String
		{
			return "test.UITestViewPanel";
		}
		
		override protected function get resNames():Array
		{
			return [ "test1", "test2", "test3", "testPanel"];
		}
		
	}
}