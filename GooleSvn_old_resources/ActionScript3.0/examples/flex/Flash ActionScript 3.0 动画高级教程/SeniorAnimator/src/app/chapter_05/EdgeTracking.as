package app.chapter_05
{
	import code.SpriteBase;
	import code.chapter_05.Snow;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.ConvolutionFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.media.Camera;
	import flash.media.Video;
	
	
	/**
	 * 说明：EdgeTracking
	 * @author victor
	 * 2012-8-6 下午8:19:43
	 */
	
	public class EdgeTracking extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _cam:Camera;
		private var _vid:Video;
		private var _bmpd:BitmapData;
		private var _flakes:Array;
		
		public function EdgeTracking()
		{
			super();
		}
		
		override protected function initialization():void
		{
			const vw:Number = 320 * 1;
			const vh:Number = 240 * 1;
			
			_cam = Camera.getCamera();
			_cam.setMode(vw, vh, 15);
			
			if (_vid == null)
			{
				_vid = new Video(vw, vh);
			}
			_vid.attachCamera(_cam);
			_vid.filters = [new ConvolutionFilter(1, 3, [0, 4, -4]), new BlurFilter()];
			
			_bmpd = new BitmapData(vw, vh, false);
			addChild(new Bitmap(_bmpd));
			
			_flakes = new Array();
			
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			_bmpd.draw(_vid, new Matrix(-1, 0, 0, 1, _bmpd.width, 0));
			_bmpd.threshold(_bmpd, _bmpd.rect, new Point(), "<", 0x00220000, 0xff000000, 0x00ff0000, true);
			
			var snow:Snow = new Snow();
			snow.x = Math.random() * _bmpd.width;
			addChild(snow);
			_flakes.push(snow);
			
			var leng:int = _flakes.length;
			for (var i:int = leng - 1; i > 0; i--)
			{
				snow = _flakes[i] as Snow;
				if (_bmpd.getPixel(snow.x, snow.y) == 0)
				{
					snow.update();
					if (snow.y > _bmpd.height)
					{
						removeChild(snow);
						_flakes.splice(i, 1);
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