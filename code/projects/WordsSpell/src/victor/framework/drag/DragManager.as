package victor.framework.drag
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import victor.framework.core.ViewStruct;

	/**
	 * ……
	 * @author yangsj
	 */
	public class DragManager
	{
		private var _stage:Stage;
		private var _container:DisplayObjectContainer;
		private var _target:IDragItem;
		private var _cloneTarget:Bitmap;

		public function DragManager()
		{
			_container = ViewStruct.getContainer( ViewStruct.DRAG );
			_container.mouseChildren = false;
			_container.mouseEnabled = false;
			_instance = this;
		}

		public function drag( target:IDragItem ):void
		{
			if ( _container && _container.parent )
			{
				_target = target;
				_stage = _container.stage;
				_container.removeChildren();
				disposeCloneTarget();
				createCloneTarget();
				addEvent();

				_target.onDragStart();
			}
		}

		private function removeEvent():void
		{
			if ( _stage )
			{
				_stage.removeEventListener( MouseEvent.MOUSE_MOVE, mouseHandler );
				_stage.removeEventListener( MouseEvent.MOUSE_UP, mouseHandler );
				_stage.removeEventListener( Event.MOUSE_LEAVE, mouseHandler );
			}
		}

		private function addEvent():void
		{
			if ( _stage )
			{
				_stage.addEventListener( MouseEvent.MOUSE_MOVE, mouseHandler );
				_stage.addEventListener( MouseEvent.MOUSE_UP, mouseHandler );
				_stage.addEventListener( Event.MOUSE_LEAVE, mouseHandler );
			}
		}

		protected function mouseHandler( event:MouseEvent ):void
		{
			if ( _target && _cloneTarget )
			{
				var type:String = event.type;
				if ( type == MouseEvent.MOUSE_MOVE )
				{
					setCloneTargetPosXY();
				}
				else if ( type == MouseEvent.MOUSE_UP )
				{
					var target:DisplayObject = event.target as DisplayObject;
					if (( target is _target.upTargetClassType ) && target != _target )
					{
						_target.upTarget = target;
						_target.onDragSuccess();
					}
					else
					{
						_target.onDragFailed();
					}
					clear();
				}
				else if ( type == Event.MOUSE_LEAVE )
				{
					_target.onDragFailed();
					clear();
				}
			}
		}

		private function clear():void
		{
			removeEvent();
			disposeCloneTarget();
			_stage = null;

		}

		private function createCloneTarget():void
		{
			var bitdata:BitmapData = new BitmapData( _target.cloneTarget.width, _target.cloneTarget.height, true, 0 );
			bitdata.draw( _target.cloneTarget, null, null, null, null, true );
			_cloneTarget = new Bitmap( bitdata, "auto", true );
			_cloneTarget.alpha = 0.8;
			setCloneTargetPosXY();
			_container.addChild( _cloneTarget );
		}

		private function disposeCloneTarget():void
		{
			if ( _cloneTarget )
			{
				if ( _cloneTarget.parent )
					_cloneTarget.parent.removeChild( _cloneTarget );
				if ( _cloneTarget.bitmapData )
					_cloneTarget.bitmapData.dispose();
				_cloneTarget.bitmapData = null;
			}
			_cloneTarget = null;
		}

		private function setCloneTargetPosXY():void
		{
			if ( _cloneTarget && _stage )
			{
				_cloneTarget.x = _stage.mouseX - _cloneTarget.width * 0.5;
				_cloneTarget.y = _stage.mouseY - _cloneTarget.height * 0.5;
			}
		}

		////////////////////////////////////////////////////

		private static var _instance:DragManager;
		public static function get instance():DragManager
		{
			if ( _instance == null )
				new DragManager();
			return _instance;
		}
	}
}
