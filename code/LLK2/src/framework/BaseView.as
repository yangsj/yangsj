package framework
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import framework.interfaces.IView;



	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class BaseView extends Sprite implements IView
	{
		protected var _data:Object;
		
		public function BaseView()
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
