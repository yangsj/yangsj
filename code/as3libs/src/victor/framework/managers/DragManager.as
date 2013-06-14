package victor.framework.managers
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import victor.components.drag.IDragItem;
	import victor.utils.BitmapUtil;

	/**
	 * ……
	 * @author yangsj
	 */
	public class DragManager
	{
		private var _container:DisplayObjectContainer;
		private var _target:IDragItem;
		private var _cloneTarget:Bitmap;
		private var _parent:DisplayObjectContainer;

		public function DragManager()
		{
		}

		public function init( contaienr:DisplayObjectContainer ):void
		{
			_container = contaienr;
		}

		public function drag( target:IDragItem ):void
		{
			if ( _container && _container.parent )
			{
				_target = target;
				_parent = _container.parent;
				_container.removeChildren();
				disposeCloneTarget();
				createCloneTarget();
				addEvent();

				_target.onDragStart();
			}
		}

		private function removeEvent():void
		{
			if ( _parent )
			{
				_parent.removeEventListener( MouseEvent.MOUSE_MOVE, mouseHandler );
				_parent.removeEventListener( MouseEvent.MOUSE_UP, mouseHandler );
				_parent.removeEventListener( Event.MOUSE_LEAVE, mouseHandler );
			}
		}

		private function addEvent():void
		{
			if ( _parent )
			{
				_parent.addEventListener( MouseEvent.MOUSE_MOVE, mouseHandler );
				_parent.addEventListener( MouseEvent.MOUSE_UP, mouseHandler );
				_parent.addEventListener( Event.MOUSE_LEAVE, mouseHandler );
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
					_container.addChild( _cloneTarget );
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

		}

		private function createCloneTarget():void
		{
			_cloneTarget = BitmapUtil.cloneBitmapFromTarget( _target.cloneTarget );
			_cloneTarget.alpha = 0.8;
			_cloneTarget.scaleX = _target.cloneTarget.scaleX;
			_cloneTarget.scaleY = _target.cloneTarget.scaleY;
			setCloneTargetPosXY();
		}

		private function disposeCloneTarget():void
		{
			BitmapUtil.disposeBitmapFromTarget( _cloneTarget );
			_cloneTarget = null;
		}

		private function setCloneTargetPosXY():void
		{
			if ( _cloneTarget && _parent )
			{
				_cloneTarget.x = _parent.mouseX - _cloneTarget.width * 0.5;
				_cloneTarget.y = _parent.mouseY - _cloneTarget.height * 0.5;
			}
		}

		////////////////////////////////////////////////////

		private static var _instance:DragManager;

		public static function get instance():DragManager
		{
			if ( _instance == null )
			{
				_instance = new DragManager();
			}
			return _instance;
		}
	}
}
