package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import net.hires.debug.Stats;
	
	import victor.AppEntry;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-12
	 */
	public class App extends Sprite
	{
		public function App()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			addChild( new AppEntry() );
			
			addChild( new Stats() );
		}
		
		
	}
}