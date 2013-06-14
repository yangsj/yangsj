package test.page
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import victor.utils.BitmapUtil;
	
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class TestPageView extends Sprite
	{
		public function TestPageView()
		{
			var items:Array = [];
			for (var i:int = 0; i < 100; i ++)
			{
				items.push(i);
			}
			
			var btnPrev:MovieClip = new MovieClip();
			btnPrev.graphics.beginFill(0xff0000);
			btnPrev.graphics.drawRect(25,200,50,50);
			btnPrev.graphics.endFill();
			
			var btnNext:MovieClip = new MovieClip();
			btnNext.graphics.beginFill(0xff0000);
			btnNext.graphics.drawRect(225,200,50,50);
			btnNext.graphics.endFill();
			
			addChild(btnPrev);
			addChild(btnNext);
			
			var pageContent:TestPageContent = new TestPageContent(new Rectangle(0,0,100,240), 8, true);
			pageContent.btnPrev = btnPrev;
			pageContent.btnNext = btnNext;
			pageContent.x = 100;
			pageContent.y = 100;
			addChild(pageContent);
			pageContent.items = items;
			pageContent.initialize();
			
			
		}
		
		
	}
}