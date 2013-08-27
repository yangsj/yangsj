package victor.framework.core
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import victor.framework.interfaces.IView;
	
	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class ViewSprite extends Sprite implements IView
	{
		protected var _data:Object;
		
		private var isInit:Boolean = false;
		
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
			if ( isInit == false )
				onceInit();
			
			initialize();
			
			isInit = true;
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

		public function set data(value:Object):void
		{
			_data = value;
		}


	}
}
