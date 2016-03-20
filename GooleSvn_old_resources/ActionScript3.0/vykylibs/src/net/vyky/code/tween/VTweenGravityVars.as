package net.vyky.code.tween
{
	import flash.display.DisplayObject;
	
	/**
	 * 说明：TweenVars
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-2-10
	 */
	
	public class VTweenGravityVars
	{
		
		/////////////////////////////////static ////////////////////////////
		
		
		
		///////////////////////////////// vars /////////////////////////////////
		
		/**
		 * 一个函数的实例TweenGravity应该派一TweenGravityEvent每次它更新的值
		 */
		public var onUpdateListener:Function;
		/**
		 * 一个函数的实例TweenGravity应该派一TweenGravityEvent在完成时
		 */
		public var onCompleteListener:Function;
		/**
		 * 用于存取指定的目标对象的名称
		 */
		public var targetName:String;
		/**
		 * 开始到结束的持续时间
		 */
		public var duration:Number;
		/**
		 * 指定的目标对象
		 */
		public var target:DisplayObject;
		/**
		 * 两个TweenGravity间的延迟时间
		 */
		public var delay:Number;
		
		public function VTweenGravityVars()
		{
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
		
	}
	
}