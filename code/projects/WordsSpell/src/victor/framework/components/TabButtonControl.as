package victor.framework.components
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
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

		private var selectdCallBack:Function;
		private var defaultTarget:MovieClip;
		private var listManager:Vector.<MovieClip>;
		private var lastClickTarget:MovieClip;
		private var dictTarget:Dictionary;

		/**
		 * 构造函数
		 * @param callBack 点击回调函数, 传递参数:[点击的target(MovieClip), keyName]
		 */
		public function TabButtonControl( callBack:Function )
		{
			dictTarget = new Dictionary();
			listManager = new Vector.<MovieClip>();
			selectdCallBack = callBack;
		}

		/**
		 * 同时添加多个选择项
		 * @param targets
		 */
		public function addMultiTargets( ... targets ):void
		{
			if ( targets )
			{
				for each ( var mc:MovieClip in targets )
					addTarget( mc );
			}
		}

		/**
		 * 单个选择项添加
		 * @param target 选择项
		 */
		public function addTarget( target:MovieClip, tabName:* = null ):void
		{
			if ( target )
			{
				tabName = tabName ? tabName : listManager.length;
				
				target.mouseChildren = false;
				target.mouseEnabled = true;
				target.buttonMode = true;
				target.gotoAndStop( FRAME_OUT );
				listManager.push( target );
				addEventForTarget( target );
				
				dictTarget[ target ] = tabName;
			}
			else
			{
				throw new Error("TabButtonControl.addTarget:参数不能为空！！");
			}
		}

		/**
		 * 销毁处理
		 */
		public function dispose():void
		{
			for each ( var mc:MovieClip in listManager )
				removeEventForTarget( mc );
			
			selectdCallBack = null;
			defaultTarget = null;
			listManager = null;
			lastClickTarget = null;
		}
		
		/**
		 * 通过添加时的顺序编号选中指定的 tab
		 * @param index 添加时的顺序编号，编号从0开始。若是值大于最大值将会被转为最大值处理
		 */
		public function setTargetByIndex( index:int ):void
		{
			this.defaultTarget = listManager[ Math.min( index, listManager.length - 1 ) ];
			setDefaultTarget( defaultTarget );
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
					addTarget( defaultTarget );
				defaultTarget.dispatchEvent( new MouseEvent( MouseEvent.CLICK ));
			}
		}
		
////////////////////// private functions 

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
			if ( type == MouseEvent.ROLL_OUT || type == MouseEvent.ROLL_OVER )
			{
				if ( mcTarget.mouseEnabled )
					mcTarget.gotoAndStop( type == MouseEvent.ROLL_OUT ? FRAME_OUT : FRAME_OVER );
			}
			else if ( type == MouseEvent.CLICK )
			{
				if ( lastClickTarget )
				{
					lastClickTarget.gotoAndStop( FRAME_OUT );
					lastClickTarget.mouseEnabled = true;
				}
				lastClickTarget = mcTarget;
				lastClickTarget.mouseEnabled = false;
				lastClickTarget.gotoAndStop( FRAME_DOWN );
				safetyCall( selectdCallBack, lastClickTarget, dictTarget[ lastClickTarget ] );
			}
		}


	}
}
