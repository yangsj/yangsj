package 
{
	//倒影类
	import flash.display.*;
	import flash.geom.*;

	public class Reflection
	{
		private var reflectionContainer:DisplayObjectContainer;
		private var reflectionHeight:Number;
		private var reflectionalphaStrength:Number;//透明度
		private var reflectionPercent:Number;
		private var offDistance:Number;//偏移距离
		private var reflectionClip:Sprite;

		private var reflectionBMP:Bitmap;//倒影位图
		private var reflectionMask:Sprite;//倒影遮罩
		private var RegPointType:String;//注册点位置类型

		//实现三种情况进行倒影
		public static var LEFT_TOP:String = "left_top";
		public static var CENTER:String = "center";
		public static var CENTER_BOTTOM:String = "center_bottom";


		/* @ para reflectionContainer 倒影的容器
		 * @ para reflectionHeight  倒影高度
		 * @ para RegPointType  注册点类型，根据不同注册点位置做出相应的倒影
		 * @ para alphaStrength 透明度 （0-1）
		 * @ para reflectionPercent 倒影映射的百分比
		 * @ para offDistance 偏移距离
		 */

		public function Reflection(reflectionContainer:DisplayObjectContainer, reflectionHeight:Number = 255, RegPointType:String="left_top" ,alphaStrength:Number = 1, reflectionPercent:Number = -1 ,offDistance:Number=0)
		{
			this.reflectionContainer = reflectionContainer;
			this.reflectionHeight = reflectionHeight;
			this.reflectionalphaStrength = alphaStrength;
			this.reflectionPercent = reflectionPercent;
			this.RegPointType = RegPointType;
			this.offDistance = offDistance;
			CreatReflection();
			addItem();
		}

		//创建倒影
		private function CreatReflection():void
		{
			reflectionClip = new Sprite();//倒影剪辑容器
			reflectionMask = new Sprite();//遮罩

			var bmd:BitmapData = new BitmapData(reflectionContainer.width,reflectionContainer.height,true,0xffffff);
			if (RegPointType==Reflection.LEFT_TOP)
			{
				bmd.draw(reflectionContainer);
				reflectionBMP = new Bitmap(bmd);
				reflectionBMP.scaleY = -1;
				reflectionBMP.x = 0;
				reflectionBMP.y = reflectionBMP.height * 2 + offDistance;
				reflectionMask.y = reflectionBMP.height + offDistance;
				reflectionMask.x = 0;
			}
			else if (RegPointType==Reflection.CENTER)
			{
				var matrix:Matrix=new Matrix();
				matrix.tx = reflectionContainer.width / 2;
				matrix.ty = reflectionContainer.height / 2;
				bmd.draw( reflectionContainer,matrix);
				reflectionBMP = new Bitmap(bmd);
				reflectionBMP.scaleY = -1;
				reflectionBMP.x =  -  reflectionBMP.width / 2;
				reflectionBMP.y = reflectionBMP.height + reflectionBMP.height / 2 + offDistance;
				reflectionMask.y = reflectionBMP.height / 2 + offDistance;
				reflectionMask.x =  -  reflectionBMP.width / 2;
			}
			else if (RegPointType==Reflection.CENTER_BOTTOM)
			{
				var matrixB:Matrix=new Matrix();
				matrixB.tx = reflectionContainer.width / 2;
				matrixB.ty = reflectionContainer.height;
				bmd.draw( reflectionContainer,matrixB);
				reflectionBMP = new Bitmap(bmd);
				reflectionBMP.scaleY = -1;
				reflectionBMP.x =  -  reflectionBMP.width / 2;
				reflectionBMP.y = reflectionBMP.height + offDistance;
				reflectionMask.y = 0 + offDistance;
				reflectionMask.x =  -  reflectionBMP.width / 2;
			}

			var fillType:String = GradientType.LINEAR;
			var colors:Array = [0xFFFFFF,0xFFFFFF];
			var alphas:Array = [reflectionalphaStrength,0];
			var ratios:Array = [0,reflectionHeight];
			var matr:Matrix = new Matrix();
			var matrixHeight:Number;
			if (reflectionPercent<=0)
			{
				matrixHeight = reflectionContainer.height;
			}
			else
			{
				matrixHeight = reflectionContainer.height * reflectionPercent;
			}
			var spreadMethod:String = SpreadMethod.PAD;

			matr.createGradientBox(reflectionContainer.width ,matrixHeight, 0.5*Math.PI,0, 0);
			reflectionMask.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
			reflectionMask.graphics.drawRect(0, 0, reflectionContainer.width, reflectionContainer.height);
			reflectionMask.graphics.endFill();

			reflectionBMP.cacheAsBitmap = true;
			reflectionMask.cacheAsBitmap = true;
			reflectionBMP.mask = reflectionMask;
		}

		//添加项目
		private function addItem():void
		{
			reflectionClip.addChild( reflectionBMP );
			reflectionClip.addChild( reflectionMask );
			reflectionContainer.addChild( reflectionClip );
		}

		//清除倒影
		public function clearAll():void
		{
			reflectionClip.removeChild( reflectionMask );
			reflectionClip.removeChild( reflectionBMP );
			reflectionContainer.removeChild( reflectionClip );
		}
	}
}