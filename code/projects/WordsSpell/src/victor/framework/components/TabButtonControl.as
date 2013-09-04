package victor.framework.components
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import app.utils.safetyCall;
	
	import victor.framework.interfaces.IDisposable;

	/**
	 * ……
	 * @author yangsj
	 */
	public class TabButtonControl implements IDisposable
	{
		public static const FRAME_OUT:String = "up";
		public static const FRAME_OVER:String = "over";
		public static const FRAME_DOWN:String = "down";

		private const RELEASE:String = "release";


		public var canRelease:Boolean = false;

		private var callBack:Function;
		private var list:Array;
		private var defaultTarget:MovieClip;
		private var listManager:Vector.<MovieClip>;
		private var lastClickTarget:MovieClip;

		/**
		 * 构造函数
		 * @param callBack 点击回调函数, 传递两个参数[点击的target， 是否可以锁定]
		 */
		public function TabButtonControl( callBack:Function )
		{
			this.callBack = callBack;
		}

		/**
		 * 同时添加多个选择项
		 * @param targets
		 */
		public function addMultiTargets( ... targets ):void
		{
			if ( targets && targets.length > 0 )
			{
				this.list = targets;
				createInit();
			}
		}

		/**
		 * 单个选择项添加
		 * @param target 选择项
		 */
		public function addTarget( target:MovieClip ):void
		{
			listManager ||= new Vector.<MovieClip>();
			list ||= new Array();
			if ( target )
			{
				list.push( target );
				initTarget( target );
			}
		}

		/**
		 * 销毁处理
		 */
		public function dispose():void
		{
			for each ( var mc:MovieClip in listManager )
			{
				if ( mc )
				{
					removeEventForTarget( mc );
				}
			}
			callBack = null;
			list = null;
			defaultTarget = null;
			listManager = null;
			lastClickTarget = null;
		}

		/**
		 * 设置默认选择项
		 * @param target 指定具体选择项
		 * @param isFirst 若是不指定target，该值为true则默认选中第一个，否则不选择任何
		 */
		public function setDefaultTarget( target:MovieClip, isFirst:Boolean = false ):void
		{
			this.defaultTarget = target ? target : isFirst ? listManager[ 0 ] : null;
			if ( defaultTarget && listManager )
			{
				if ( listManager.indexOf( defaultTarget ) == -1 )
					initTarget( defaultTarget );
				defaultTarget.dispatchEvent( new MouseEvent( MouseEvent.CLICK ));
			}
		}

		/**
		 * 释放当前选中的选择项
		 */
		public function releaseCurrentSelectedTarget():void
		{
			if ( lastClickTarget )
			{
				lastClickTarget.gotoAndStop( FRAME_OUT );
				lastClickTarget.mouseEnabled = true;
				lastClickTarget[ RELEASE ] = false;
				lastClickTarget = null;
			}
		}

		private function createInit():void
		{
			if ( listManager == null )
				listManager = new Vector.<MovieClip>();
			for each ( var mc:MovieClip in list )
			{
				if ( mc )
					initTarget( mc );
			}
		}

		private function initTarget( target:MovieClip ):void
		{
			target.mouseChildren = false;
			target.mouseEnabled = true;
			target.buttonMode = true;
			target.gotoAndStop( FRAME_OUT );
			listManager.push( target );
			addEventForTarget( target );
		}

		private function addEventForTarget( target:MovieClip ):void
		{
			if ( target )
			{
				target.addEventListener( MouseEvent.ROLL_OUT, mouseHandler );
				target.addEventListener( MouseEvent.ROLL_OVER, mouseHandler );
				target.addEventListener( MouseEvent.CLICK, mouseHandler );
			}
		}

		private function removeEventForTarget( target:MovieClip ):void
		{
			if ( target )
			{
				target.removeEventListener( MouseEvent.ROLL_OUT, mouseHandler );
				target.removeEventListener( MouseEvent.ROLL_OVER, mouseHandler );
				target.removeEventListener( MouseEvent.CLICK, mouseHandler );
			}
		}

		private function mouseHandler( e:MouseEvent ):void
		{
			var type:String = e.type;
			var mcTarget:MovieClip = e.target as MovieClip;
			var release:Boolean = mcTarget[ RELEASE ];
			if ( type == MouseEvent.ROLL_OUT || type == MouseEvent.ROLL_OVER )
			{
				if ( release == true || mcTarget.mouseEnabled == false )
					return;
				mcTarget.gotoAndStop( type == MouseEvent.ROLL_OUT ? FRAME_OUT : FRAME_OVER );
			}
			else if ( type == MouseEvent.CLICK )
			{
				if ( release && canRelease )
				{
					releaseCurrentSelectedTarget();
				}
				else
				{
					releaseCurrentSelectedTarget();
					lastClickTarget = mcTarget;
					lastClickTarget.mouseEnabled = canRelease;
					mcTarget.gotoAndStop( FRAME_DOWN );
					mcTarget[ RELEASE ] = true;
				}
				safetyCall( callBack, mcTarget, release );
			}
		}


	}
}
