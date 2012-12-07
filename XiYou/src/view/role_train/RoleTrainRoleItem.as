package view.role_train
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	/**
	 * 说明：RoleTrainRoleItem
	 * @author Victor
	 * 2012-10-2
	 */
	
	public class RoleTrainRoleItem
	{
		private static var pool:Vector.<RoleTrainRoleItem> = new Vector.<RoleTrainRoleItem>();
		
		private var _target:DisplayObject;
		private var _selectedEffect:MovieClip;
		private var _data:Object;
		private var _callBackClick:Function;
		private var _isSelected:Boolean = false;
		private var _isDefault:Boolean = false;
		
		public function RoleTrainRoleItem()
		{
		}
		
		public static function create():RoleTrainRoleItem
		{
			var item:RoleTrainRoleItem;
			if (pool && pool.length > 0) item = pool.pop();
			else item = new RoleTrainRoleItem();
			return item;
		}
		
		public function initialization():void
		{
			stopSelectedEffect();
			if (_target)
			{
				if (_target.hasOwnProperty("role"))
				{
					_target["role"]["gotoAndStop"]("lab_" + id);
				}
				else if (_target.hasOwnProperty("gotoAndStop"))
				{
					_target["gotoAndStop"]("lab_" + id);
				}
				if (_target.hasOwnProperty("mouseChildren"))
				{
					_target["mouseChildren"] = false;
				}
				if (_target.parent)
				{
					addEvents();
				}
				else
				{
					_target.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
				}
			}
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			_target.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEvents();
		}
		
		private function addEvents():void
		{
			if (_target)
			{
				_target.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
				_target.addEventListener(MouseEvent.CLICK, mouseHandler);
				_target.parent.addEventListener(MouseEvent.CLICK, parentMouseHandler);
				
				if (_isDefault)
				{
					_target.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
				}
			}
		}
		
		private function removeEvents():void
		{
			_target.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			_target.removeEventListener(MouseEvent.CLICK, mouseHandler);
			_target.parent.removeEventListener(MouseEvent.CLICK, parentMouseHandler);
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			removeEvents();
			stopSelectedEffect();
			
			pool.push(this);
			
			_target = null;
			_selectedEffect = null;
			_callBackClick = null;
			_data = null;
		}
		
		protected function parentMouseHandler(event:MouseEvent):void
		{
			var target:DisplayObject = event.target as DisplayObject;
			if (target != _target)
			{
				stopSelectedEffect();
			}
		}
		
		protected function mouseHandler(event:Event):void
		{
			if (_isSelected == false)
			{
				playSelectedEffect();
				runCallBackFun();
			}
		}
		
		private function runCallBackFun():void
		{
			if (_callBackClick != null)
			{
				_callBackClick.call(this, this);
			}
		}
		
		private function playSelectedEffect():void
		{
			if (_selectedEffect)
			{
				_isSelected = true;
//				_selectedEffect.gotoAndPlay(2);
				_selectedEffect.visible = true;
				
				_selectedEffect.gotoAndStop(1);
			}
		}
		
		private function stopSelectedEffect():void
		{
			if (_selectedEffect)
			{
				_isSelected = false;
				_selectedEffect.gotoAndStop(1);
				_selectedEffect.visible = false;
			}
		}
		
		
		public function get id():int
		{
			return int(data);
		}
		
		/**
		 * 力量属性值
		 */
		public function get power():Number
		{
			return int(Math.random() * 50 + 50);
		}
		
		/**
		 * 智力属性值
		 */
		public function get wisdom():Number
		{
			return int(Math.random() * 50 + 50);
		}
		
		/**
		 * 体质属性值
		 */
		public function get physique():Number
		{
			return int(Math.random() * 50 + 50);
		}
		
		/**
		 * 力量属性值
		 */
		public function get agile():Number
		{
			return int(Math.random() * 50 + 50);
		}
		
		/**
		 * 角色名称
		 */
		public function get name():String
		{
			return "name";
		}
		
		/**
		 * 等级属性值
		 */
		public function get level():int
		{
			return int(Math.random() * 50);
		}
		
		/**
		 * 角色的技能
		 */
		public function get skill():Object
		{
			return new Object();
		}
		
		/**
		 * 人物技能描述
		 */
		public function get skillDes():String
		{
			return "skill description：<br><br>			this is the skill description information.";
		}
		
		/**
		 * 需要消耗的【仙灵值】属性值
		 */
		public function get expendImmortalValue():Number
		{
			return int(Math.random() * 20 + 10);
		}
		
		public function get expendExp():Number
		{
			return int(Math.random() * 50 + 50);
		}
		
		
		public function get target():DisplayObject
		{
			return _target;
		}

		public function set target(value:DisplayObject):void
		{
			_target = value;
		}

		public function get selectedEffect():MovieClip
		{
			return _selectedEffect;
		}

		public function set selectedEffect(value:MovieClip):void
		{
			_selectedEffect = value;
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}

		/**
		 * 点击后一个回调函数
		 */
		public function get callBackClick():Function
		{
			return _callBackClick;
		}

		/**
		 * @private
		 */
		public function set callBackClick(value:Function):void
		{
			_callBackClick = value;
		}

		/**
		 * 是否设置为默认选中状态
		 */
		public function get isDefault():Boolean
		{
			return _isDefault;
		}

		/**
		 * @private
		 */
		public function set isDefault(value:Boolean):void
		{
			_isDefault = value;
		}
		
		
		


	}
	
}