package net.victor.code.app.managers.interfaces
{
	import net.victor.code.managers.interfaces.IManagerCernterable;

	/**
	 * 面板管理器 
	 * 
	 */	
	public interface IPanelManager extends IManagerCernterable
	{
		/**
		 *  显示面板
		 * @param meidatorName
		 * @param layer 所在的层
		 * @see net.jt_tech.app.ContainerLayer
		 */		
		function showPanel(meidatorName:String, layer:String="", $alpha:Number=0.4):void;
		/**
		 * 从显示列表中移除面板 
		 * @param meidatorName
		 * 
		 */		
		function hidePanel(meidatorName:String):void;
		/**
		 * 从内存中清除 
		 * @param meidatorName
		 * 
		 */		
		function destroyPanel(meidatorName:String):void;
		
		/**
		 * 面板是否已经在显示列表中 
		 * @param meidatorName
		 * @return 
		 * 
		 */		
		function isPanelShow(meidatorName:String):Boolean;
	}
}