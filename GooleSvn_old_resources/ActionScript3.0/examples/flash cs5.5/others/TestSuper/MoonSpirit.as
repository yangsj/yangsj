package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.net.LocalConnection;

	public class MoonSpirit extends Sprite
	{
		private const SQR_AMOUNT:int = 10000;//方块数量        
		private var _container_sp:Sprite;//容器sprite
		private var _sqrList:Array;//所有方块的引用

		public function MoonSpirit()
		{
			init();
		}

		private function init():void
		{
			_container_sp = new Sprite  ;
			addChild(_container_sp);
			//initNoBitmapDataView( );
			initBitmapDataView();
		}

		//初始化 通过通常手段 显示
		private function initNoBitmapDataView():void
		{
			layoutTenThousandSqr();
		}

		//初始化 通过BitmapData快照 显示
		private function initBitmapDataView():void
		{
			layoutTenThousandSqr();
			var myBitmapDataObject:BitmapData = new BitmapData(150,150,false,0xFF0000);
			var myImage:Bitmap = new Bitmap(myBitmapDataObject);
			addChild(myImage);
			unLayoutTenThousandSqr();
			_sqrList = null;
			doClearance();
		}

		private function layoutTenThousandSqr():void
		{
			_sqrList = new Array  ;
			for (var i:int=0; i<SQR_AMOUNT; i++)
			{
				_sqrList.push(new Sprite  );
				_sqrList[i].graphics.beginFill(0xff0000);
				_sqrList[i].graphics.drawRect(0,0,100,100);
				_sqrList[i].graphics.endFill();
				_container_sp.addChild(_sqrList[i]);
			}
		}

		//不显示
		private function unLayoutTenThousandSqr():void
		{
			for (var i:int=0; i<SQR_AMOUNT; i++)
			{
				_container_sp.removeChild(_sqrList[i]);
				delete _sqrList[i];
			}
		}

		//精髓，垃圾回收机强制调用
		private function doClearance():void
		{
			trace("clear");
			try
			{
				throw new Error("this is throw Error");
				//new LocalConnection.connect("foo");
				//new LocalConnection.connect("foo");
			}
			catch (error:Error)
			{
				trace(error);
			}
		}
	}
}