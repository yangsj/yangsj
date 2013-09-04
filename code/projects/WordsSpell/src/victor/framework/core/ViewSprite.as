package victor.framework.core
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;

	import app.managers.LoaderManager;

	import victor.framework.components.Reflection;
	import victor.framework.interfaces.IView;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class ViewSprite extends Sprite implements IView
	{
		protected var _data:Object;

		protected var _skin:Sprite;

		protected var rectangle:Rectangle;

		private var _isInit:Boolean = false;



		public function ViewSprite()
		{
			super();

			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
		}

		protected function removedFromStageHandler( event:Event ):void
		{
		}

		protected function addedToStageHandler( event:Event ):void
		{
			if ( _isInit == false )
			{
				setSkinWithName( skinName );
				Reflection.reflection( this, _skin );
				var rect:Rectangle = this.getBounds( this );
				rectangle = new Rectangle( rect.x, rect.y, rect.width, rect.height );
				onceInit();
			}

			initialize();

			_isInit = true;
		}

		protected function setSkinWithName( skinName:String ):void
		{
			if ( skinName )
			{
				_skin = LoaderManager.instance.getObj( skinName, domainName ) as Sprite;
				addChild( _skin );
			}
		}

		protected function onceInit():void
		{
		}

		public function initialize():void
		{
		}

		public function dispose():void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
		}

		public function refresh():void
		{
		}

		public function hide():void
		{
			ViewStruct.removeChild( this );
		}

		public function show():void
		{
			throw new Error( "重写show" );
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data( value:Object ):void
		{
			_data = value;
		}

		protected function get skinName():String
		{
			return "";
		}

		/**
		 * 指定资源加载的域名称（默认当前域）
		 */
		protected function get domainName():String
		{
			return "";
		}


	}
}
