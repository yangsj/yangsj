package victor
{
	import victor.app.Main;
	import victor.framework.Entry;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-12
	 */
	public class AppEntry extends Entry
	{
		
		
		public function AppEntry()
		{
		}
		
		override protected function initialized():void
		{
//			var test:Test = new Test();
//			test.transitionIn();
			
			Main.firstTransition();
		}
		
	}
}