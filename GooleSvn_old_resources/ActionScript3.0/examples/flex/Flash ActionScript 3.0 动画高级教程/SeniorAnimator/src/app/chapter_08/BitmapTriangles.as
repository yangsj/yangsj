package app.chapter_08
{
	import code.SpriteBase;
	
	import flash.display.Bitmap;
	
	
	/**
	 * 说明：BitmapTriangles
	 * @author victor
	 * 2012-9-1 上午11:11:51
	 */
	
	public class BitmapTriangles extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
//		[Embed(source="assets/chapter_8/ting.jpg")]
//		private var ImageClass:Class;
		
		public function BitmapTriangles()
		{
			super();
		}
		
		override protected function initialization():void
		{
			[Embed(source="assets/chapter_8/ting.jpg")]
			var ImageClass:Class;
			
			var vertices:Vector.<Number> = new Vector.<Number>();
			vertices.push(200,100);
			vertices.push(400,100);
			vertices.push(400,500);
			vertices.push(100,300);
			var indices:Vector.<int> = new Vector.<int>();
			indices.push(0,1,2);
			indices.push(2,3,0);
			
			var uvtData:Vector.<Number> = new Vector.<Number>();
			uvtData.push(0,0);
			uvtData.push(1,0);
			uvtData.push(1,1);
			uvtData.push(0,1);
			
			var bitmap:Bitmap = new ImageClass() as Bitmap;
			graphics.beginBitmapFill(bitmap.bitmapData);
			graphics.drawTriangles(vertices, indices, uvtData);
			graphics.endFill();
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}