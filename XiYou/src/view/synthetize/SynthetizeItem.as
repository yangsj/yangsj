package view.synthetize
{

	import com.greensock.TweenMax;
	
	import datas.RolesID;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import global.DeviceType;
	import global.Global;
	
	import ui.resource.ResourceAllRoleHeadPicture;
	
	import utils.FunctionUtils;


	/**
	 * 说明：SynthetizeItem
	 * @author Victor
	 * 2012-10-11
	 */

	public class SynthetizeItem extends Sprite
	{
		private static var pool : Vector.<SynthetizeItem>;

		private var PREFIX_LAB_FRAME : String = "lab_";
		private var LAB_EMPTY : String = PREFIX_LAB_FRAME + "empty";

		private var _target : MovieClip;
		private var _atParentX : Number = 0;
		private var _atParentY : Number = 0;
		private var _parentTarget : DisplayObjectContainer;
		private var _data : Object;
		private var _endScaleX : Number = 1;
		private var _endScaleY : Number = 1;

		private var _moveOverCallBackFun : Function;
		private var _moveOverCallBackFunParams : Array;


		private const pointMoveAdd : Point = (Global.isDifferenceSwf && Global.deviceType == DeviceType.ANDROID) ? new Point(660, 400) : new Point(870, 650);

		public function SynthetizeItem()
		{
			_target = new ResourceAllRoleHeadPicture();
			addChild(_target);
			if (_target.hasOwnProperty("role")) 
				_target["role"].stop(); 
			else 
				_target.stop(); 
			
			this.mouseChildren = false;
			this.cacheAsBitmapMatrix = new Matrix();
			this.cacheAsBitmap = true;
		}

		public static function create() : SynthetizeItem
		{
			if (pool == null)  
				pool = new Vector.<SynthetizeItem>(); 
			if (pool.length > 0) 
				return pool.pop(); 
			return new SynthetizeItem();
		}

		public static function clearPool() : void
		{
			if (Global.isUsePool == true) return ;
			while (pool.length > 0) 
				FunctionUtils.removeChild(pool.pop().dispose()); 
			pool = null;
		}

		public function dispose() : void
		{
			clear();
			
			_target = null;
		}
		
		private function clear():void
		{
			_atParentX = 0;
			_atParentY = 0;
			_data = null;
			_parentTarget = null;
		}

		public function initialization() : void
		{
			if (_target)
			{
				var lab:String = roleId == -1 ? LAB_EMPTY : PREFIX_LAB_FRAME + roleId;
				if (_target.hasOwnProperty("role")) 
					_target["role"].gotoAndStop(lab); 
				else 
					_target.gotoAndStop(lab);
			}
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		public function moveTo($x : Number, $y : Number, $scaleX : Number, $scaleY : Number, needRemoved : Boolean = false, $moveOverCallBackFun : Function = null, $params : Array = null) : void
		{
			parentTarget.mouseChildren = parentTarget.mouseEnabled = false;
			_moveOverCallBackFun = $moveOverCallBackFun;
			_moveOverCallBackFunParams = $params;
			TweenMax.to(this, 0.3, {x: $x, y: $y, scaleX: $scaleX, scaleY: $scaleX, onComplete: moveToTweenCompleted, onCompleteParams: [needRemoved]});
		}

		public function moveAddToList($onComplete : Function = null, $onCompleteParams : Array = null) : void
		{
			var point : Point = parentTarget.globalToLocal(pointMoveAdd);
			TweenMax.to(this, 0.3, {x: point.x, y: point.y, scaleX: 0, scaleY: 0, onComplete: $onComplete, onCompleteParams: $onCompleteParams});
		}

		/**
		 * 获取当前对象在指定容器中的映射位置
		 * @param container
		 * @return
		 *
		 */
		public function getContainerPoint(container : DisplayObjectContainer) : Point
		{
			var global : Point = this.localToGlobal(new Point(0, 0));
			var local : Point = container.globalToLocal(global);
			return local;
		}

		override public function startDrag(lockCenter : Boolean = false, bounds : Rectangle = null) : void
		{
			super.startDrag(lockCenter, bounds);
			this.mouseEnabled = this.mouseChildren = false;
		}

		override public function stopDrag() : void
		{
			super.stopDrag();
			this.mouseEnabled = true;
		}

		private function moveToTweenCompleted(needRemoved : Boolean) : void
		{
			parentTarget.mouseChildren = parentTarget.mouseEnabled = true;
			TweenMax.killTweensOf(this);
			initialization();
			if (needRemoved)
			{
				this.parent.removeChild(this);
			}
			if (_moveOverCallBackFun != null)
			{
				_moveOverCallBackFun.apply(this, _moveOverCallBackFunParams);
				_moveOverCallBackFun = null;
				_moveOverCallBackFunParams == null;
			}
		}

		protected function removedFromStageHandler(event : Event) : void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			clear();
			pool.push(this);
		}

		public function get roleId() : int
		{
			if (data && data.hasOwnProperty("id"))
				return int(data.id);
			return -1;
		}

		public function get roleName() : String
		{
			if (data && data.hasOwnProperty("name"))
				return String(data.name);
			return "name";
		}

		public function get roles() : Array
		{
			if (data && data.hasOwnProperty("roles"))
				return data.roles as Array;
			return [];
		}

		public function get atParentX() : Number
		{
			return _atParentX;
		}

		public function set atParentX(value : Number) : void
		{
			_atParentX = value;
		}

		public function get atParentY() : Number
		{
			return _atParentY;
		}

		public function set atParentY(value : Number) : void
		{
			_atParentY = value;
		}

		public function get parentTarget() : DisplayObjectContainer
		{
			return _parentTarget;
		}

		public function set parentTarget(value : DisplayObjectContainer) : void
		{
			_parentTarget = value;
		}

		public function get isEmpty() : Boolean
		{
			return roleId < 0;
		}

		public function get data() : Object
		{
			return _data;
		}

		public function set data(value : Object) : void
		{
			_data = value;
		}

		public function get endScaleX() : Number
		{
			return _endScaleX;
		}

		public function set endScaleX(value : Number) : void
		{
			_endScaleX = value;
		}

		public function get endScaleY():Number
		{
			return _endScaleY;
		}

		public function set endScaleY(value:Number):void
		{
			_endScaleY = value;
		}


	}

}
