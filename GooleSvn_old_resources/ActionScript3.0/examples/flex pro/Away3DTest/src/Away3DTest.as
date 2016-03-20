package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	
	/**
	 * 说明：Away3DTest
	 * @author victor
	 * 2012-7-19 下午8:30:06
	 */
	
	public class Away3DTest extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		
		
		public function Away3DTest()
		{
			this.graphics.beginFill(0xff0000, 0.5);
			this.graphics.drawRect(0,0,stage.stageWidth, stage.stageHeight);
			this.graphics.endFill();
			
			var txt:TextField = new TextField();
			txt.text = "this is the Away3DTest application";
			this.addChild(txt);
			txt.width = txt.textWidth + 10;
			txt.x = (stage.stageWidth - txt.width) * 0.5;
			
			trace(this.width, this.height);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}