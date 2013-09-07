package app.core
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import app.utils.appStage;
	
	import victor.framework.utils.BitmapUtil;

	public class Tips
	{
		private var _container:DisplayObjectContainer;
		private var _txt:TextField;
		private var _tf_format:TextFormat;
		private var _sizeFormat:TextFormat;
		
        private static var line : TimelineLite;
		private static var _instance:Tips;
		private static const DEFAULT_SIZE:int = 25;

		public function Tips()
		{
			if ( _instance ) throw new Error("不能重复创建Tips实例！！！");
			
			_instance = this;
			_container = appStage;
			_txt = creatTF();
		}
		
		/**
		 * 显示在当前鼠标位置
		 * @param msg
		 * @param size
		 * @param borderColor
		 */
		public static function showMouse( msg:String, size:int = 15, borderColor:uint = 0 ):void
		{
			show( msg, appStage.mouseX, appStage.mouseY, size, borderColor );
		}

		/**
		 * 显示在界面中心
		 * @param msg
		 * @param size
		 * @param offsetY
		 * @param borderColor
		 */
		public static function showCenter( msg:String, size:int = 15, offsetY:int = 0, borderColor:uint = 0, removeOld : Boolean = true):void
		{
            if (removeOld && line) line.complete()
			instance.showCenter( msg, size, offsetY, borderColor );
		}

		/**
		 * 显示到指定位置
		 * @param msg
		 * @param x
		 * @param y
		 * @param size
		 * @param borderColor
		 */
		public static function show( msg:String, x:int, y:int, size:int = 15, borderColor:uint = 0 ):void
		{
			instance.show( msg, x, y - 50, size, borderColor );
		}

		/**
		 * 根据偏移显示
		 * @param msg
		 * @param panel
		 */
		public static function showOffsetCenter( msg:String, panel:DisplayObject ):void
		{
			var pos:Point = new Point( panel.width / 2, panel.height / 2 );
			pos = panel.localToGlobal( pos );
			show( msg, pos.x, pos.y );
		}

		private function creatTF():TextField
		{
			var _tf:TextField = new TextField();
			_tf_format ||= new TextFormat();
			_tf_format.size = DEFAULT_SIZE;
			_tf_format.color = 0xfff052;
			_tf_format.font = "Microsoft YaHei";
			_sizeFormat = new TextFormat();
			_sizeFormat.size = DEFAULT_SIZE;
//			_tf.border = true;
			_tf.multiline = true;
			_tf.autoSize = TextFormatAlign.LEFT;
			_tf.defaultTextFormat = _tf_format;
			_tf.filters = [ new GlowFilter( 0x0, 1, 3, 3, 10, 1 )];
			return _tf;
		}

		public function showCenter( msg:String, size:int = 15, offsetY:int = 0, borderColor:uint = 0 ):void
		{
			if ( _container && _container.stage )
			{
				var x:Number = appStage.stageWidth / 2;
				var y:int = appStage.stageHeight / 2 + offsetY;
				show( msg, x, y, size, borderColor );
			}
		}

		public function show( msg:String, x:int, y:int, size:int = 15, borderColor:uint = 0 ):void
		{
			if ( borderColor != 0 )
				_txt.filters = [ new GlowFilter( borderColor, 1, 2, 2, 10, 1 )];
			
			_txt.htmlText = msg;
			
			if ( DEFAULT_SIZE != size )
			{
				_sizeFormat.size = size;
				_txt.setTextFormat( _sizeFormat );
			}

			var bd:BitmapData = new BitmapData( _txt.width, _txt.height, true, 0 );
			bd.draw( _txt );
			var mc:Bitmap = new Bitmap( bd );
			mc.x = x - mc.width / 2;
			mc.y = y - mc.height / 2;
			_container.addChild( mc );
			line = new TimelineLite();
			line.append( TweenLite.from( mc, 0.3, { y: mc.y + 40, alpha: 0 }));
			line.append( TweenLite.to( mc, 0.6, { y: mc.y - 80, alpha: 0, onComplete: BitmapUtil.disposeBitmapFromTarget, onCompleteParams: [ mc ]}), 1 );
		}

		public static function get instance():Tips
		{
			if ( _instance == null )
				new Tips();
			return _instance;
		}


	}
}
