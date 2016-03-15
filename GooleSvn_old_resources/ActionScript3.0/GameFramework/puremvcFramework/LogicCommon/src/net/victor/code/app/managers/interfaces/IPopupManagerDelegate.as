package net.victor.code.app.managers.interfaces
{
	import flash.display.DisplayObjectContainer;
	
	import net.victor.code.managers.interfaces.IManagerCernterable;
	
	public interface IPopupManagerDelegate extends net.victor.code.managers.interfaces.IManagerCernterable
	{
		/**
		 *显示PopUp 
		 * @param meidatorName  面板mediator名称
		 * @param $parent		要显示的父容器
		 * @param $modal		是否唯一响应
		 * @param $center		是否居中
		 * @param $modalColor	背景着色
		 * @param $modalAlpha	背景透明
		 * 
		 */		
		function showPopUp(meidatorName:String,
						   $parent:DisplayObjectContainer = null, 
						   $modal:Boolean = true, 
						   $center:Boolean = true,
						   $modalColor:uint = 0xABCFDE, 
						   $modalAlpha:Number = -1):void;
		
		/**
		 * 隐藏PopUp
		 * @param meidatorName
		 * 
		 */		
		function hidePopUp(meidatorName:String):void;
	}
}