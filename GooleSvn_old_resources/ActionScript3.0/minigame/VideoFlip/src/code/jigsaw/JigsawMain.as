package code.jigsaw
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.utils.describeType;
	
	
	/**
	 * 说明：JigsawMain
	 * @author杨胜金
	 * 2012-3-7 下午10:34:47
	 */
	
	public class JigsawMain extends Sprite
	{
		/**
		 * 存储切割后每张图片数据的数组
		 */
		private var array:Array=new Array();
		
		/**
		 * 每张被切割图片坐标数组
		 */
		private var arrXY:Array=new Array();
		
		/**
		 * 是否是第一次进行切割
		 */
		private var isFirstIncise:Boolean=true;
		
		public function JigsawMain()
		{
			super();
		}
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		/**
		 * 切割后原显示对象不变，会将新生成的切割对象在指定的容器中显示，若指定的容器$container不存在则会将切割的图片放置在$photoName的父容器parent中显示，若两者都不存在则不会将切割的图片显示和拖拽监听
		 * @param $photoName 指定需要切割的显示对象（目标对象）
		 * @param $numX 在水平方向上（x）切割的次数[横切刀数]，最终切割的图片数目是 $numX+1
		 * @param $numY 在垂直方向上（y）切割的次数[纵切刀数] ，最终切割的图片数目是 $numY+1
		 * @param $apart 切割后两两图片的间距[切割后图片间距]，默认 0 像数
		 * @param $type	切割后产生图像的类型，只支持产生 bitmap 、shape 、sprite 图像
		 * @param $isDrag 是否允许对切割后的单个图片进行拖拽
		 * @param $container 指定切割后的图片存放的显示容器
		 * @return
		 *
		 */
		private function cutImage($photoName:DisplayObject, $numX:uint=0, $numY:uint=0, $apart:Number=0, $type:String="sprite", $isDrag:Boolean=false, $container:DisplayObjectContainer=null):void
		{
			//位图数据，横切刀数，纵切刀数，切割后图片间距，切割后产生图像的类型，容器
			if ($type != "shape" && $type != "sprite" && $type != "bitmap")
			{
				trace("错误，只支持产生 bitmap 、shape 、sprite 图像。");
				return;
			}
			if ($type != "sprite" && $isDrag)
			{
				trace("错误，如果需要拖拽，请将 type（5）参数写为“sprite”。");
				return;
			}
			if ($container != null && $container.parent == null && $photoName.parent)
			{
				$photoName.parent.addChild($container);
			}
			//平均切割图片，计算图片高宽
			var _width:Number=$photoName.width / ($numX + 1);
			var _height:Number=$photoName.height / ($numY + 1);
			if (_width < 5 || _height < 5)
			{
				trace(_width, _height, "切图过碎，请勿小于 5 * 5 像素面积，会导致“无法获取资源”");
				return;
			}
			
			var counter:uint=0; //计数器
			if (arrXY && arrXY.length < (($numX + 1) * ($numY + 1)))
			{
				for (var j:uint=0; j < ($numX + 1); j++)
				{
					for (var k:uint=0; k < ($numY + 1); k++)
					{
						arrXY[counter]=[j * _width, k * _height];
						if (array[counter] == null)
						{
							var spr:Sprite=new JigsawItem(arrXY[counter][0], arrXY[counter][1]);
							array[counter]=spr;
							spr=null;
						}
						counter++;
					}
				}
			}
			
			for (var i:uint=0; i < ($numX + 1) * ($numY + 1); i++)
			{
				//按参数5设定类型切割图片
				var bitmapData:BitmapData=new BitmapData(_width, _height);
				var matrix:Matrix=new Matrix(1, 0, 0, 1, -arrXY[i][0], -arrXY[i][1]);
				var photoType:*;
				
				bitmapData.draw($photoName, matrix);
				if ($type == "bitmap")
				{
					photoType=new Bitmap(bitmapData);
				}
				if ($type == "sprite")
				{
					photoType=new Sprite();
					photoType.graphics.beginBitmapFill(bitmapData);
					photoType.graphics.drawRect(0, 0, _width, _height);
				}
				if ($type == "shape")
				{
					photoType=new Shape();
					photoType.graphics.beginBitmapFill(bitmapData);
					photoType.graphics.drawRect(0, 0, _width, _height);
				}
				while (Sprite(array[i]).numChildren > 1)
					Sprite(array[i]).removeChildAt(1);
				Sprite(array[i]).addChild(photoType);
			}
			
			counter=0;
			for (var m:uint=0; m < $numX + 1; m++)
			{
				for (var n:uint=0; n < $numY + 1; n++)
				{
					//显示图片
					if ($container != null)
					{
						$container.addChild(array[counter]);
					}
					else if ($photoName.parent)
					{
						$photoName.parent.addChild(array[counter]);
					}
					if (isFirstIncise)
					{
						array[counter].x=m * (_width + $apart);
						array[counter].y=n * (_height + $apart);
					}
					counter++;
				}
			}
			isFirstIncise=false;
			if ($isDrag)
			{
				$container=$container ? $container : $photoName.parent ? $photoName.parent : null;
				if ($container == null)
				{
					trace("指定的容器$container和$photoName.parent都不存在");
					return;
				}
				//拖拽
				($container != null) ? listenerDrag($container) : listenerDrag();
			}
		}
		
		private function listenerDrag(container:DisplayObjectContainer=null):void
		{
			if (container == null)
				return;
			//拖拽监听
			container.addEventListener(MouseEvent.MOUSE_DOWN, startDragItem);
			container.addEventListener(MouseEvent.MOUSE_UP, stopDragItem);
			
			function startDragItem(e:MouseEvent):void
			{
				if (String(describeType(e.target).@name) == "flash.display::Sprite")
				{
					var mc:Sprite=e.target as Sprite;
					//设置深度最高为目前被拖拽对象
					container.setChildIndex(mc, container.numChildren - 1);
					mc.startDrag();
				}
			}
			function stopDragItem(e:MouseEvent):void
			{
				//停止拖拽
				if (String(describeType(e.target).@name) == "flash.display::Sprite")
				{
					e.target.stopDrag();
				}
			}
		}
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}