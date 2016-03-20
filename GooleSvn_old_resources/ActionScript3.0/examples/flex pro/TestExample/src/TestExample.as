package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import test.ram.app.TestRamSize;
	
	[SWF(width="1092", height="614", backgroundColor="0xffffff", alpha="0.5")]
	
	/**
	 * 说明：TestExample
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-7-9
	 */
	
	public class TestExample extends Sprite
	{
		
		
		public function TestExample()
		{
			
//			var testRamSize:TestRamSize = new TestRamSize();
//			this.addChild(testRamSize);
			
			var textf:TextField = new TextField();
			textf.background = true;
			textf.width = stage.stageWidth - 200;
			textf.height = 500;
//			textf.text = "debug: " + new Error().getStackTrace();
			textf.text = new Error().getStackTrace().search(/:[0-9]+\]$/m) + "";
			textf.x = textf.y = 100;
			addChild(textf);
			
		}
		
		
		
	}
	
}