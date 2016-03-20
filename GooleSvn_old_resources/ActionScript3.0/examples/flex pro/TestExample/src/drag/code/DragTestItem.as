package drag.code
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	
	/**
	 * 说明：DragTestItem
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-7-9
	 */
	
	public class DragTestItem extends Sprite
	{
		private var _txt:TextField;
		
		public function DragTestItem()
		{
			super();
			createGraphics();
			initTxt();
		}
		
		public function initialization():void
		{
			clear();
		}
		
		public function clear():void
		{
			
		}
		
		private function createGraphics():void
		{
			this.graphics.beginFill(0xff0000, 0.8);
			this.graphics.drawRect(0,0,50,50);
			this.graphics.endFill();
		}
		
		private function initTxt():void
		{
			_txt = new TextField();
			_txt.width = 50;
			_txt.height = 18;
			_txt.y = 17;
			this.addChild(_txt);
		}
		
		public function setTxtContent($txt:String):void
		{
			_txt.htmlText = $txt;
		}
		
	}
	
}