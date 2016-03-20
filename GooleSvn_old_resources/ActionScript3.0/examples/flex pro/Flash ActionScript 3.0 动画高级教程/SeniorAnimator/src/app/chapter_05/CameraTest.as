package app.chapter_05
{
	import code.SpriteBase;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	
	
	/**
	 * 说明：CameraTest
	 * @author victor
	 * 2012-8-5 下午3:50:48
	 */
	
	public class CameraTest extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _cam:Camera;
		private var _vid:Video;
		private var _bmpd:BitmapData;
		private var _matrix:Matrix;
		private var _cbRect:Sprite;
		private var _color:uint = 0xffffff;
		private var _red:Array;
		private var _green:Array;
		private var _blue:Array;
		private var _ball:Sprite;
		
		public function CameraTest()
		{
			super();
		}
		
		override protected function initialization():void
		{
			const vw:Number = 320 * 1;
			const vh:Number = 240 * 1;
			
			_cam = Camera.getCamera();
			_cam.setMode(vw, vh, 15);
			trace("Camera.name:", _cam.name);
			
			_vid = new Video(vw, vh);
			_vid.attachCamera(_cam);
			_vid.filters = [new BlurFilter(10,10,1)];
			
			_bmpd = new BitmapData(vw, vh, false);
			
			_matrix = new Matrix(-1, 0, 0, 1, _bmpd.width, 0);
			
			addChild(new Bitmap(_bmpd));
			
			_cbRect = new Sprite();
			addChild(_cbRect);
			
			_ball = new Sprite();
			_ball.graphics.beginFill(0x0000ff);
			_ball.graphics.drawCircle(0, 0, 40);
			_ball.graphics.endFill();
			addChild(_ball);
			
			makePaletteArrays();
			
			stage.addEventListener(MouseEvent.CLICK, onClickHandler);
			
			super.initialization();
		}
		
		private function onClickHandler(e:MouseEvent):void
		{
			_color = _bmpd.getPixel(mouseX, mouseY);
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			_bmpd.draw(_vid, _matrix);
			_bmpd.paletteMap(_bmpd, _bmpd.rect, new Point(), _red, _green, _blue);
			
			var rect:Rectangle = _bmpd.getColorBoundsRect(0xffffff, _color, true);
			
			_cbRect.graphics.clear();
			_cbRect.graphics.lineStyle(1, 0xff0000);
			_cbRect.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			
			if (!rect.isEmpty())
			{
				var xCenter:Number = rect.x + rect.width * 0.5;
				var yCenter:Number = rect.y + rect.height* 0.5;
				_ball.x = xCenter / _bmpd.width * stage.stageWidth;
				_ball.y = yCenter / _bmpd.height * stage.stageHeight;
			}
		}
		
		private function makePaletteArrays():void
		{
			_red = new Array();
			_green = new Array();
			_blue = new Array();
			
			var levels:int = 8;
			var div:int = 256 / levels;
			
			for (var i:int = 0; i < 256; i++)
			{
				var value:Number = Math.floor(i / div) * div;
				_red[i] = value << 16;
				_green[i] = value << 8;
				_blue[i] = value;
			}
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}