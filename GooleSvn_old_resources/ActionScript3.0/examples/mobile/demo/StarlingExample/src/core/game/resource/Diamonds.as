package core.game.resource
{
	import core.Pool;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Diamonds extends Sprite
	{
		public static const WIDTH:Number = 42;
		public static const HEIGHT:Number = 42;
		public static const WIDTH_HALF:Number = 21;
		public static const HEIGHT_HALF:Number = 21;
		
		public static const DIAMOND_POOL_NAME:String = "diamond_pool_name";
		
		/** 移动或最后Y位置 */
		public var end_y:Number = 0;
		
		/** 在二维数组中的【行标】 */
		public var rows:int = 0;
		
		/** 在二维数组中的【列标】 */
		public var cols:int = 0;
		
		/** 是否已被查寻过 */
		public var isSeeked:Boolean = false;
		
		private var _id:int = 1;
		
		private var diamond:DisplayObject;
		private var errorMc:DisplayObject;
		private var setIntervalID:uint;
		
		public function Diamonds($id:int)
		{
			redraw($id);
		}
		
		private function draw():void
		{
			if (diamond) diamond.removeFromParent(true);
			diamond = Image.fromBitmap(createBitmap(color)) as DisplayObject;
			this.addChildAt(diamond, 0);
			if (errorMc == null)
			{
				errorMc = Image.fromBitmap(createBitmap(0x333333));
				this.addChild(errorMc);
			}
//			diamond.touchable = false;
//			errorMc.touchable = false;
			this.useHandCursor = true;
			setChildVisible(true);
		}
		
		private function createBitmap($color:uint):Bitmap
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill($color, 0.8);
			shape.graphics.drawRoundRect(0, 0, WIDTH, HEIGHT, 20, 20);
			shape.graphics.endFill();
			
			var bmd:BitmapData = new BitmapData(WIDTH, HEIGHT, true, 0);
			bmd.draw(shape);
			var bitmap:Bitmap = new Bitmap(bmd);
			return bitmap;
		}
		
		private function get color():uint
		{
			switch (_id)
			{
				case 1:
					return 0x0000ff;
					break;
				case 2:
					return 0x00ff00;
					break;
				case 3:
					return 0xff0000;
					break;
				case 4:
					return 0x660000;
					break;
				case 5:
					return 0xffff00;
					break;
				default :
					return 0x0000ff;
			}
		}
		
		private function setChildVisible($visible:Boolean):void
		{
			diamond.visible = $visible;
			errorMc.visible = !$visible;
		}
		
		//////////////// public //////////////
		
		public function redraw($id:int):void
		{
			_id = $id;
			draw();
		}
		
		/** 移除显示对象，添加到对象池 */
		public function removedFromStage():void
		{
			this.rotation = 0;
			Pool.setObject(this, DIAMOND_POOL_NAME + String(id));
			this.removeFromParent(false);
			this.visible = false;
		}
		
		public function rightDisplay():void
		{
			setChildVisible(true);
			clearInterval(setIntervalID);
		}
		
		public function clickError():void
		{
			setChildVisible(false);
			setIntervalID = setInterval(rightDisplay, 1000);
		}
		
		public function setRowsCols($rows:int, $cols:int):void
		{
			rows = $rows;
			cols = $cols;
			this.visible = true;
		}

		public function get id():int
		{
			return _id;
		}
		
		
		
		
		
		
	}
}