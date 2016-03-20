package net.vyky.control.button
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	
	
	/**
	 * 说明：Button
	 * @author杨胜金
	 * 2011-11-3 下午11:18:13
	 */
	
	public class VButton extends Sprite
	{
		private var _upState:DisplayObject;
		private var _overState:DisplayObject;
		private var _downState:DisplayObject
		
		private var _enabled:Boolean = true;
		private var _useHandCursor:Boolean = true;
		
		/**
		 * downState 鼠标按下后状态<br>
		 * overState 鼠标移上后状态<br>
		 * upState 鼠标弹起后状态<br>
		 */
		/**
		 * 
		 * @param upState 指定一个用作按钮弹起状态（当鼠标没有位于按钮上方时，按钮所处的状态）的可视对象的显示对象。
		 * @param overState 指定一个用作按钮经过状态（当鼠标位于按钮上方时，按钮所处的状态）的可视对象的显示对象。
		 * @param downState 指定一个用作按钮“按下”状态（当用户单击 hitTestState 对象时，按钮所处的状态）的可视对象的显示对象。
		 * 
		 */
		public function VButton(upState:DisplayObject=null, overState:DisplayObject=null, downState:DisplayObject=null)
		{
			super();
			this.mouseChildren = false;
			this.buttonMode = useHandCursor;
			
			if (upState)this.upState = upState;
			if (overState) this.overState = overState;
			if (downState) this.downState = downState;
		}
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		/**
		 * 指定一个用作按钮弹起状态（当鼠标没有位于按钮上方时，按钮所处的状态）的可视对象的显示对象。
		 */
		public function get upState():DisplayObject
		{
			return _upState;
		}
		
		/**
		 * @private
		 */
		public function set upState(value:DisplayObject):void
		{
			_upState = value;
		}
		
		/**
		 * 指定一个用作按钮经过状态（当鼠标位于按钮上方时，按钮所处的状态）的可视对象的显示对象。
		 */
		public function get overState():DisplayObject
		{
			return _overState;
		}
		
		/**
		 * @private
		 */
		public function set overState(value:DisplayObject):void
		{
			_overState = value;
		}
		
		/**
		 * 指定一个用作按钮“按下”状态（当用户单击 hitTestState 对象时，按钮所处的状态）的可视对象的显示对象。
		 */
		public function get downState():DisplayObject
		{
			return _downState;
		}
		
		/**
		 * @private
		 */
		public function set downState(value:DisplayObject):void
		{
			_downState = value;
		}
		
		/**
		 * 布尔值，指定按钮是否处于启用状态。 
		 */
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		/**
		 * @private
		 */
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
		}
		
		/**
		 * 一个布尔值，当设置为 true 时，指示鼠标指针滑过按钮上方时 Flash Player 是否显示手形光标。
		 */
//		public function get useHandCursor():Boolean
//		{
//			return _useHandCursor;
//		}
		
		/**
		 * @private
		 */
//		public function set useHandCursor(value:Boolean):void
//		{
//			_useHandCursor = value;
//			this.buttonMode = value;
//		}
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////

		


	}
}