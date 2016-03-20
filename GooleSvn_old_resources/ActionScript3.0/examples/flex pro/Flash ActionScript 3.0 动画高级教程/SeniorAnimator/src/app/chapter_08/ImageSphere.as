package app.chapter_08
{
	import code.SpriteBase;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.TriangleCulling;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	
	/**
	 * 说明：ImageSphere
	 * @author victor
	 * 2012-9-9 上午12:21:08
	 */
	
	public class ImageSphere extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		[Embed(source="assets/chapter_8/world.jpg")]
		private var ImageClass:Class;
		
		private var vertices:Vector.<Number> = new Vector.<Number>();
		private var uvtData:Vector.<Number> = new Vector.<Number>();
		private var indices:Vector.<int> = new Vector.<int>();
		private var bitmap:Bitmap;
		private var res:Number = 500;
		private var cols:int = 50;
		private var rows:int = 50;
		
		private var sprite:Sprite;
		private var centerz:Number = 500;
		private var focalLength:Number = 1000;
		private var radius:Number = 400;
		
		private var offset:Number = 0;
		
		
		
		public function ImageSphere()
		{
			super();
		}
		
		override protected function initialization():void
		{
			sprite = new Sprite();
			addChild(sprite);
			
			bitmap = new ImageClass() as Bitmap;
			makeTriangles();
			draw();
			var rect:Rectangle = sprite.getBounds(sprite);
			sprite.x = (this.stage.stageWidth - sprite.width) * 0.5 - rect.x;
			sprite.y = (this.stage.stageHeight- sprite.height) * 0.5 - rect.y;
			
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			draw();
		}
		
		private function draw():void
		{
			offset -= 0.01;
			vertices.length = 0;
			uvtData.length = 0;
			for (var i:int = 0; i < rows; i++)
			{
				for (var j:int = 0; j < cols; j++)
				{
					var angle:Number = Math.PI * 2 / (cols - 1) * j;
					var angle2:Number = Math.PI * i / (rows - 1) - Math.PI * 0.5;
					
					var xpos:Number = Math.cos(angle + offset) * radius * Math.cos(angle2);
					var ypos:Number = Math.sin(angle2) * radius;
					var zpos:Number = Math.sin(angle + offset) * radius * Math.cos(angle2);
					
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