package newview
{

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;


	/**
	 * 说明：SpriteBase
	 * @author Victor
	 * 2012-11-14
	 */

	public class SpriteBase extends Sprite
	{

		/** 点击的对象名称 */
		protected var clickTargetName : String;
		/** 是否添加 MOUSE_DOWN 事件  */
		protected var isAddMouseDown : Boolean = true;

		public function SpriteBase()
		{
			createResource();
			addEvents();
		}

		protected function createResource() : void
		{
		}

		protected function clear() : void
		{
		}

		protected function addEvents() : void
		{
			if ( isAddMouseDown )
				addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler );
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
		}

		protected function removeEvents() : void
		{
			removeEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler );
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
		}

		protected function removedFromStageHandler( event : Event ) : void
		{
			removeEvents();
			clear();
		}

		protected function addedToStageHandler( event : Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}

		protected function mouseDownHandler( event : MouseEvent ) : void
		{
			clickTargetName = event.target.name;
		}





	}

}
