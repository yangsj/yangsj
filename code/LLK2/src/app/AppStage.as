package app
{
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.system.Capabilities;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-28
	 */
	public class AppStage
	{
		private static var _scaleX:Number = 1;
		private static var _scaleY:Number = 1;
		private static var _stageWidth:Number = 640;
		private static var _stageHeight:Number = 960;
		private static var _maxScale:Number = 1;
		private static var _minScale:Number = 1;
		private static var _stage:Stage;

		public static const standardWidth:Number = 640;
		public static const standardHeight:Number = 960;

		public function AppStage()
		{
		}

		public static function initStage( stage:Stage ):void
		{
			if ( _stage == null )
			{
				_stage = stage;
				
				_stageWidth = _stage.fullScreenWidth;
				_stageHeight = _stage.fullScreenHeight;
				_stage.stageWidth = _stageWidth;
				_stage.stageHeight = _stageHeight;

				_scaleX = _stageWidth / standardWidth;
				_scaleY = _stageHeight / standardHeight;
				_maxScale = Math.max( _scaleX, _scaleY );
				_minScale = Math.min( _scaleX, _scaleY );
			}
		}

		/**
		 * 校正x、y、scaleX和scaleY的值。x、y分别按缩放系数调整；scaleX、scaleY将按minScale的值调整
		 * @param target 需要校正的对象
		 */
		public static function adjustXYScaleXY( target:DisplayObject ):void
		{
			if ( target )
			{
				adjustXY( target );
				adjustScaleXY( target );
			}
		}

		/**
		 * 只校正scaleX和scaleY的值。scaleX、scaleY将按minScale的值调整
		 * @param target 需要校正的对象
		 */
		public static function adjustScaleXY( target:DisplayObject ):void
		{
			if ( target )
			{
				target.scaleX *= minScale;
				target.scaleY *= minScale;
			}
		}

		/**
		 * 只校正x、y的值。x、y分别按缩放系数调整
		 * @param target 需要校正的对象
		 */
		public static function adjustXY( target:DisplayObject ):void
		{
			if ( target )
			{
				target.x *= _scaleX;
				target.y *= _scaleY;
			}
		}

		/**
		 * 背景校正。按 maxScale 缩放系数等比拉伸，并且将对象居中（相对屏幕）
		 * @param target 需要校正的对象
		 */
		public static function bgToEqualRatio( target:DisplayObject ):void
		{
			if ( target )
			{
				target.scaleX = _maxScale;
				target.scaleY = _maxScale;
				target.x = ( _stageWidth - target.width ) >> 1;
				target.y = ( _stageHeight - target.height ) >> 1;
			}
		}

		/**
		 * 背景校正。整屏显示，尺寸拉伸和屏幕同等大小
		 * @param target
		 *
		 */
		public static function bgToStretch( target:DisplayObject ):void
		{
			if ( target )
			{
				target.width = _stageWidth;
				target.height = _stageHeight;
				target.x = 0;
				target.y = 0;
			}
		}

		public static function adjustXYScaleXYForTarget( target:DisplayObjectContainer ):void
		{
			var length:int = target.numChildren;
			for ( var i:int = 0; i < length; i++ )
			{
				var dis:DisplayObject = target.getChildAt( i );
				adjustXYScaleXY( dis );
			}
		}
		
		public static function adjustXYForTarget( target:DisplayObjectContainer ):void
		{
			var length:int = target.numChildren;
			for ( var i:int = 0; i < length; i++ )
			{
				var dis:DisplayObject = target.getChildAt( i );
				adjustXY( dis );
			}
		}
		
		public static function adjustScaleXYForTarget( target:DisplayObjectContainer ):void
		{
			var length:int = target.numChildren;
			for ( var i:int = 0; i < length; i++ )
			{
				var dis:DisplayObject = target.getChildAt( i );
				adjustScaleXY( dis );
			}
		}

		// ********************** getter/setter ***********************

		public static function get isDevice():Boolean
		{
			if ( Capabilities.playerType == "Desktop" ) // 是air运行环境
			{
				return NativeApplication.nativeApplication.icon == null; // 是否在桌面
			}
			return false;
		}

		/**
		 * x轴方向缩放值
		 */
		public static function get scaleX():Number
		{
			return _scaleX;
		}

		/**
		 * @private
		 */
		public static function set scaleX( value:Number ):void
		{
			_scaleX = value;
		}

		/**
		 * y轴方向缩放值
		 */
		public static function get scaleY():Number
		{
			return _scaleY;
		}

		/**
		 * @private
		 */
		public static function set scaleY( value:Number ):void
		{
			_scaleY = value;
		}

		/**
		 * 读取屏幕运行的最大宽度
		 */
		public static function get stageWidth():Number
		{
			return _stageWidth;
		}

		/**
		 * @private
		 */
		public static function set stageWidth( value:Number ):void
		{
			_stageWidth = value;
		}

		/**
		 * 读取屏幕运行的最大高度
		 */
		public static function get stageHeight():Number
		{
			return _stageHeight;
		}

		/**
		 * @private
		 */
		public static function set stageHeight( value:Number ):void
		{
			_stageHeight = value;
		}

		/**
		 * xy两个轴缩放较【大】的值
		 */
		public static function get maxScale():Number
		{
			return _maxScale;
		}

		/**
		 * @private
		 */
		public static function set maxScale( value:Number ):void
		{
			_maxScale = value;
		}

		/**
		 * xy两个轴缩放较【小】的值
		 */
		public static function get minScale():Number
		{
			return _minScale;
		}

		/**
		 * @private
		 */
		public static function set minScale( value:Number ):void
		{
			_minScale = value;
		}

		public static function get stage():Stage
		{
			return _stage;
		}


	}
}
