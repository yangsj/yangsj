package view.ectypal
{

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import global.Global;
	
	import utils.FunctionUtils;


	/**
	 * 说明：EctypalLevelItem
	 * @author Victor
	 * 2012-10-1
	 */

	public class EctypalLevelItem
	{
		private static var pool:Vector.<EctypalLevelItem>;
		
		private const LAB_FRAME:String = "lab_";

		private var _target : MovieClip;
		private var _data : Object;
		private var _callBackFunction : Function;

		public function EctypalLevelItem()
		{
		}
		
		public static function create():EctypalLevelItem
		{
			if (pool == null) 
			{
				pool = new Vector.<EctypalLevelItem>()
			}
			if (pool.length > 0)
			{
				return pool.pop();
			}
			return new EctypalLevelItem();
		}
		
		public static function dispose():void
		{
			if (Global.isUsePool == true) return ;
			while (pool.length > 0)
			{
				pool.pop();
			}
			pool = null;
		}

		public function initialization() : void
		{
			if (_target)
			{
				_target.mc.gotoAndStop(1);
				_target.mc.visible = false;
				_target.mouseChildren = false;
				
				
				if (isLocked)
				{
					_target.gotoAndStop(EctypalType.LABEL_FRAME_1);
				}
				else if (isUnlocked)
				{
					if (isBoss)
					{
						_target.gotoAndStop(EctypalType.LABEL_FRAME_4);
					}
					else if (canToPrev)
					{
						_target.gotoAndStop(EctypalType.LABEL_FRAME_5);
					}
					else if (canToNext)
					{
						_target.gotoAndStop(EctypalType.LABEL_FRAME_6);
					}
					else
					{
						_target.gotoAndStop(EctypalType["LABEL_FRAME_" + status]);
					}
				}
				
				addEvents();
			}
		}

		private function addEvents() : void
		{
			if (_target)
			{
				_target.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
				_target.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
				_target.parent.addEventListener(MouseEvent.MOUSE_DOWN, parentClick);
			}
		}
		
		private function removeEvents() : void
		{
			if (_target)
			{
				_target.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
				_target.removeEventListener(MouseEvent.MOUSE_DOWN, onClick);
				_target.parent.removeEventListener(MouseEvent.MOUSE_DOWN, parentClick);
			}
		}

		protected function removedFromStageHandler(event : Event) : void
		{
			removeEvents();
			
			_callBackFunction = null;
			
			_target = null;
			
			_data = null;
			
			if (pool)
			{
				pool.push(this);
			}
		}
		
		protected function onClick(event:Event):void
		{
			if (callBackFunction != null)
			{
				callBackFunction.call(this, this);
			}
			_target.mc.visible = true;
			_target.mc.gotoAndPlay(2);
		}
		
		protected function parentClick(event:MouseEvent):void
		{
			var target:DisplayObject = event.target as DisplayObject;
			if (target != _target)
			{
				_target.mc.visible = false;
				_target.mc.gotoAndStop(1);
			}
		}

		
		/**
		 * 表示解锁和过关状态
		 */
		private function get status():int
		{
			return int(data.status);
		}
		
		/**
		 * 关卡等级
		 */
		public function get level():int
		{
			return int(data.level);
		}
		
		/**
		 * 当前关卡的类型
		 */
		public function get type():int
		{
			return int(data.type);
		}
		
		/**
		 * 关卡名称
		 */
		public function get name():String
		{
			return String(data.name);
		}
		
		/**
		 * 指向设定的队伍id值
		 */
		public function get teamId():String
		{
			return String(data.team);
		}
		
		/**
		 * 关卡描述 
		 */		
		public function get des():String
		{
			return String(data.des);
		}
		
		/**
		 * 未解锁的
		 */
		public function get isLocked():Boolean
		{
			return (status == EctypalType.STATUS_1);
		}
		
		/**
		 * 是否是解锁的（未打过和已打过两状态）
		 */
		public function get isUnlocked():Boolean
		{
			return (status == EctypalType.STATUS_2) || (status == EctypalType.STATUS_3);
		}
		
		/**
		 * 该关卡为打boss关
		 */
		public function get isBoss():Boolean
		{
			return (type == EctypalType.TYPE_2);
		}
		
		/**
		 * 可以跳至前一个副本
		 */
		public function get canToPrev():Boolean
		{
			return (type == EctypalType.TYPE_3);
		}
		
		/**
		 * 可以跳至前一个副本
		 */
		public function get canToNext():Boolean
		{
			return (type == EctypalType.TYPE_4);
		}

		public function get target() : MovieClip
		{
			return _target;
		}

		public function set target(value : MovieClip) : void
		{
			_target = value;
		}

		public function get data() : Object
		{
			return _data;
		}

		public function set data(value : Object) : void
		{
			_data = value;
		}

		/**
		 * 点击后的一个回调函数
		 */
		public function get callBackFunction() : Function
		{
			return _callBackFunction;
		}

		/**
		 * @private
		 */
		public function set callBackFunction(value : Function) : void
		{
			_callBackFunction = value;
		}
		


	}

}
