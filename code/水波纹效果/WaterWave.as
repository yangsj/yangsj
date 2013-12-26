package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filters.ConvolutionFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	[SWF(frameRate='24',backgroundColor="0xffffff",width="226",height="168")]
	public class WaterWave extends Sprite
	{
		private var url:String = "waterwave.jpg";
		private var mouseDown:Boolean = false;
		//
		private var damper:BitmapData;
		private var result:BitmapData;
		private var result2:BitmapData;
		private var source:BitmapData;
		private var buffer:BitmapData;
		private var output:BitmapData;
		private var surface:BitmapData;
		private var bounds:Rectangle;
		private var origin:Point;
		private var matrix:Matrix;
		private var matrix2:Matrix;
		private var wave:ConvolutionFilter;
		private var damp:ColorTransform;
		private var water:DisplacementMapFilter;
		//
		private var imgW:Number = 226;
		private var imgH:Number = 168;
		public function WaterWave(){
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			super();
			damper = new BitmapData(imgW, imgH, false, 128);
			result = new BitmapData(imgW, imgH, false, 128);
			result2 = new BitmapData(imgW*2, imgH*2, false, 128);
			source = new BitmapData(imgW, imgH, false, 128);
			buffer = new BitmapData(imgW, imgH, false, 128);
			output = new BitmapData(imgW*2, imgH*2, true, 128);
			bounds = new Rectangle(0, 0, imgW, imgH);
			origin = new Point();
			matrix = new Matrix();
			matrix2 = new Matrix();
			matrix2.a = matrix2.d=2;
			wave = new ConvolutionFilter(3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1], 9, 0);
			damp = new ColorTransform(0, 0, 9.960937E-001, 1, 0, 0, 2, 0);
			water = new DisplacementMapFilter(result2, origin, 4, 4, 48, 48, "ignore");
			var _bg:Sprite = new Sprite();
			this.addChild(_bg);
			_bg.graphics.beginFill(0xFFFFFF,0);
			_bg.graphics.drawRect(0,0,imgW,imgH);
			_bg.graphics.endFill();
			this.addChild(new Bitmap(output));
			this.buildImg();
		}
		private function mouseDownHandle(_e:MouseEvent):void{
			mouseDown = true;
		}
		private function mouseUpHandle(_e:MouseEvent):void{
			mouseDown = false;
		}
		private function frameHandle(_e:Event):void{
			if (mouseDown) {
				var _x:Number = this.mouseX/2;
				var _y:Number = this.mouseY/2;
				source.setPixel(_x+1, _y, 16777215);
				source.setPixel(_x-1, _y, 16777215);
				source.setPixel(_x, _y+1, 16777215);
				source.setPixel(_x, _y-1, 16777215);
				source.setPixel(_x, _y, 16777215);
			}
			// end if           
			result.applyFilter(source, bounds, origin, wave);
			result.draw(result, matrix, null, BlendMode.ADD);
			result.draw(buffer, matrix, null, BlendMode.DIFFERENCE);
			result.draw(result, matrix, damp);
			result2.draw(result, matrix2, null, null, null, true);
			output.applyFilter(surface, new Rectangle(0, 0, imgW*2, imgH*2), origin, water);
			buffer = source;
			source = result.clone();
		}
		private function buildImg():void {
            var loader:Loader = new Loader();
            loader.contentLoaderInfo	.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadHandler);
            var request:URLRequest = new URLRequest(url);
            loader.load(request);
        }
        private function loadHandler(event:Event):void {
            var child:DisplayObject = DisplayObject(event.target.loader);
            surface = new BitmapData(imgW,imgH,true);
            surface.draw(child,null,null,null,null,true);
            this.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandle);
			this.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandle);
			this.addEventListener(Event.ENTER_FRAME,frameHandle);
        }
		private function ioErrorHandler(event:IOErrorEvent):void {
            trace("Unable to load image: " + url);
        }
	}
}