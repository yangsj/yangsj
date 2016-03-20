package app.chapter_08
{
	import code.SpriteBase;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.TriangleCulling;
	import flash.events.Event;
	
	
	/**
	 * 说明：ImageTube
	 * @author victor
	 * 2012-9-8 上午10:09:48
	 */
	
	public class ImageTube extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		[Embed(source="assets/chapter_8/ting.jpg")]
		private var ImageClass:Class;
		
		private var vertices:Vector.<Number> = new Vector.<Number>();
		private var uvtData:Vector.<Number> = new Vector.<Number>();
		private var indices:Vector.<int> = new Vector.<int>();
		private var bitmap:Bitmap;
		private var res:Number = 100;
		private var cols:int = 20;
		private var rows:int = 6;
		
		private var sprite:Sprite;
		private var centerz:Number = 200;
		private var focalLength:Number = 250;
		private var radius:Number = 200;
		
		private var offset:Number = 0;
		
		public function ImageTube()
		{
			super();
		}
		
		override protected function initialization():void
		{
			sprite = new Sprite();
			sprite.x = 400;
			sprite.y = 400;
			addChild(sprite);
			
			bitmap = new ImageClass() as Bitmap;
			makeTriangles();
			draw();
			
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			draw();
		}
		
		private function draw():void
		{
			offset += 0.01;
			vertices.length = 0;
			uvtData.length = 0;
			for (var i:int = 0; i < rows; i++)
			{
				for (var j:int = 0; j < cols; j++)
				{
					var angle:Number = Math.PI * 2 / (cols - 1) * j + offset;
					var xpos:Number = Math.cos(angle) * radius;
					var ypos:Number = (i - rows / 2) * res;
					var zpos:Number = Math.sin(angle) * radius;
					
					var scale:Number = focalLength / (focalLength + zpos + centerz);
					
					vertices.push(xpos * scale, ypos * scale);
					uvtData.push(j / (cols - 1), i / ( rows - 1));
					uvtData.push(scale);
				}
			}
			
			sprite.graphics.clear();
			
			sprite.graphics.beginBitmapFill(bitmap.bitmapData);
			sprite.graphics.drawTriangles(vertices, indices, uvtData, TriangleCulling.NEGATIVE);
			sprite.graphics.endFill();
			
			sprite.graphics.lineStyle(0, 0xffffff, 0.5);
			sprite.graphics.drawTriangles(vertices, indices, uvtData, TriangleCulling.NEGATIVE);
		}
		
		private function makeTriangles():void
		{
			for (var i:int = 0; i < rows; i ++)
			{
				for (var j:int = 0; j < cols; j ++)
				{	
					if (i < rows - 1 && j < cols - 1)
					{
						indices.push(i * cols + j, i * cols + j + 1, (i + 1) * cols + j);
						indices.push(i * cols + j + 1, (i + 1) * cols + j + 1, (i + 1) * cols + j);
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