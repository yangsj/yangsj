package app.modules.panel.test
{
	import flash.display.Sprite;
	
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
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			var con:Sprite = new Sprite();
			for (var i:int = 0; i < 12; i++)
			{
				var item:TestItem = new TestItem();
				item.setIndex( i );
				con.addChild( item );
			}
			con.x = ( width - con.width ) >> 1;
			con.y = ( height - con.height ) >> 1;
			addChild( con );
		}
		
		override protected function get skinName():String
		{
			return "test.UITestViewPanel";
		}
		
		override protected function get resNames():Array
		{
			return [ "testPanel"];
		}
		
		override protected function get domainName():String
		{
			return "testPanel";
		}
		
	}
}