package app.chapter_07
{
	import code.SpriteBase;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	
	
	/**
	 * 说明：DepthSort
	 * @author victor
	 * 2012-8-19 下午3:45:29
	 */
	
	public class DepthSort extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var array:Array;
		
		public function DepthSort()
		{
			super();
		}
		
		override protected function initialization():void
		{
			array = [];
			while (this.numChildren > 0) this.removeChildAt(0);
			for (var i:int = 0; i < 500; i ++)
			{
				var tree:Shape = new Shape();
				tree.graphics.beginFill(Math.random() * 255 << 8);
				tree.graphics.lineTo(-10, 0);
				tree.graphics.lineTo(-10,-30);
				tree.graphics.lineTo(-40,-30);
				tree.graphics.lineTo(0, -100);
				tree.graphics.lineTo(40, -30);
				tree.graphics.lineTo(10, -30);
				tree.graphics.lineTo(10, 0);
				tree.graphics.lineTo(0, 0);
				
				tree.graphics.endFill();
				
				tree.x = Math.random() * stage.stageWidth;
				tree.y = stage.stageHeight - 100;
				tree.z = Math.random() * 10000;
				
				addChild(tree);
				
				array.push(tree);
			}
			array.sortOn("z",  Array.NUMERIC | Array.DESCENDING);
			for each(var mc:Shape in array)
			{
				addChild(mc);
			}
			
			super.initialization();
		}
		
		
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}