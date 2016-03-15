package net.victor.code.ui
{
	import flash.display.Sprite;
	
	import net.victor.code.managers.AppManagerIn;
	import net.victor.code.managers.UIResourceManager;
	
	/**
	 * 只有界面元素，没有任务控制响应 。此类的子类只由工具生成
	 * @author jonee
	 * 
	 */	
	public class JTPanelBase extends Sprite 
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		
		public function JTPanelBase()
		{
			super();
		}
		
		protected function createUIItem(classFullName:String):Object
		{
			return UIResourceManager.AppManagerIn::instance.createDefinitionByClassName(classFullName);
		}
	}
}