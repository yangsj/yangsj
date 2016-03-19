package
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;

	[SWF(width="1000", height="600", frameRate="25")]

	/**
	 *
	 * @author Li灬Star
	 */

	public class ImgZoom extends MovieClip
	{
		private var ratio:Number; //缩放比率
		private var max:Number; //最大缩放比率
		private var distance:Number; //图片间距

		private var container:MovieClip=new MovieClip();
		private var imgArr:Array;


		public function ImgZoom()
		{
			init();
		}

		private function init():void
		{
			ratio=0.0025;
			max=1.5;
			distance=10;
			imgArr=new Array();
			this.addChild(container);
			//X轴
			container.x=0;
			container.y=300;
			//Y轴
			/*container.y=0;
			container.x=200;*/

			container.buttonMode=true;
			createObj();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
		}

		private function createObj():void
		{

			for (var i:int=0; i < 10; i++)
			{
				var img:test_mc=new test_mc();
				img.mouseEnabled=false;
				img.buttonMode=true;
				//以X轴放大时的初始坐标
				img.y=0;
				img.x=img.width / 2 + i * (img.width + distance);
				//以Y轴放大时的初始坐标
				/*img.x=0;
				img.y=img.height/2 + i * (img.height + distance);*/
				imgArr.push(img);
				container.addChild(img);
			}
		}

		private function moveHandler(e:MouseEvent):void
		{

			if (container.hitTestPoint(mouseX, mouseY))
			{

				//trace("碰撞到了");
				zoomPhotoX(imgArr); //X轴
					//zoomPhotoY(imgArr); //Y轴
			}
			else
			{
				System.gc();
				restPosition(imgArr, "x");
			}
		}

		//------------------------->X轴放大
		private function zoomPhotoX(array:Array):void
		{
			var mousePosition:Number=stage.mouseX;
			var length:Number=array[0].width * array.length + distance * (array.length - 1);
			
			if (mousePosition < 0)
			{
				mousePosition=0;
			}
			if (mousePosition > length)
			{
				mousePosition=length;
			}
			//放大比率的控制
			for (var i:uint=0; i < array.length; i++)
			{
				var s:Number=max - Math.abs(stage.mouseX - array[i].x) * ratio; //公式   
				s=s < 1 ? 1 : s;
				array[i].scaleX=array[i].scaleY=s;
			}
			//放大坐标的控制,第一张图片的坐标始终保持不变
			for (var j:uint=1; j < array.length; j++)
			{
				array[j].x=array[j - 1].x + array[j - 1].width / 2 + array[j].width / 2 + distance;
			}
		}

		//----------------------------->Y轴放大
		private function zoomPhotoY(array:Array):void
		{

			var mousePosition:Number=stage.mouseY;
			var length:Number=array[0].height * array.length + distance * (array.length - 1);
			
			if (mousePosition < 0)
			{
				mousePosition=0;
			}
			if (mousePosition > length)
			{
				mousePosition=length;
			}
			//放大比率的控制
			for (var i:uint=0; i < array.length; i++)
			{
				var s:Number=max - Math.abs(stage.mouseY - array[i].y) * ratio;
				s=s < 1 ? 1 : s;
				array[i].scaleX=array[i].scaleY=s;
			}
			//放大坐标的控制,第一张图片的坐标始终保持不变
			for (var j:uint=1; j < array.length; j++)
			{
				array[j].y=array[j - 1].y + array[j - 1].height / 2 + array[j].height / 2 + distance;
			}
		}

		//------------------------------->初始化大小
		private function restPosition(array:Array, type:String):void
		{

			for (var i:uint=0; i < array.length; i++)
			{
				array[i].scaleX=array[i].scaleY=1;
				if (type == "x")
				{
					array[i].x=array[0].width / 2 + i * (array[0].width + distance);
				}
				else
				{
					array[i].y=array[0].heigth / 2 + i * (array[0].heigth + distance);
				}
			}
		}
	}
}