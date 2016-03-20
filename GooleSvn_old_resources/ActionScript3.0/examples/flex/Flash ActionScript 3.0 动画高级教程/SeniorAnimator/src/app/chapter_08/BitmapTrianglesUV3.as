package app.chapter_08
{
	import code.SpriteBase;
	
	import flash.display.Bitmap;
	
	
	/**
	 * 说明：BitmapTrianglesUV3
	 * @author victor
	 * 2012-9-3 上午12:46:19
	 */
	
	public class BitmapTrianglesUV3 extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		[Embed(source="assets/chapter_8/ting.jpg")]
		private var ImageClass:Class;
		
		private var vertices:Vector.<Number> = new Vector.<Number>();
		private var uvtData:Vector.<Number> = new Vector.<Number>();
		private var indices:Vector.<int> = new Vector.<int>();
		private var bitmap:Bitmap;
		private var res:Number = 100;
		private var cols:int = 3;
		private var rows:int = 3;
		
		
		public function BitmapTrianglesUV3()
		{
			super();
		}
		
		override protected function initialization():void
		{
			bitmap = new ImageClass() as Bitmap;
			makeTriangle();
			
			graphics.beginBitmapFill(bitmap.bitmapData);
			graphics.drawTriangles(vertices, indices, uvtData);
			graphics.endFill();
			
			graphics.lineStyle(0);
			graphics.drawTriangles(vertices, indices);
		}
		
		private function makeTriangle():void
		{
			for (var i:int = 0; i < rows; i++)
			{
				for (var j:int = 0; j < cols; j++)
				{
					vertices.push(j * res, i * res);
					uvtData.push(j / (cols - 1), i / (rows - 1));
					if (i < rows - 1 && j < cols - 1)
					{
						indices.push(i * cols + j,     i *       cols + j + 1, (i + 1) * cols + j);
						indices.push(i * cols + j + 1, (i + 1) * cols + j + 1, (i + i) * cols + j);
					}
				}
			}
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}