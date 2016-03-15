package net.victor.project.views
{
	import com.newbye.framework.interfaces.IView;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import net.victor.code.managers.AppManagerIn;
	import net.victor.code.managers.UIResourceManager;
	
	[Event(name="btn_confirm_click", type="net.victor.project.views.JTViewEvent")]
	[Event(name="panel_close", type="net.victor.project.views.JTViewEvent")]
	[Event(name="btn_cancel_click", type="net.victor.project.views.JTViewEvent")]
	[Event(name="btn_share_click", type="net.victor.project.views.JTViewEvent")]
	
	/**
	 * 只有界面控制/响应，没有具体逻辑 
	 */	
	public class JTViewBase extends Sprite implements IView
	{
		/**
		 * 40% 透明度的黑色背景
		 */
		protected var bgMaskRes:Sprite;
		
		public function JTViewBase()
		{
			super();
			createBgMaskRes();
			bgMaskRes.cacheAsBitmap = true;
		}
		
		public function dispose():void
		{
			
		}
		protected function createUIItem(classFullName:String):Object
		{
			return UIResourceManager.AppManagerIn::instance.createDefinitionByClassName(classFullName);
		}
		
		private function createBgMaskRes():void
		{
			bgMaskRes = new Sprite();
			bgMaskRes.graphics.beginFill(0x000000, 0.4);
			bgMaskRes.graphics.drawRect(0,0,760, 600);
			bgMaskRes.graphics.endFill();
			bgMaskRes.mouseEnabled = bgMaskRes.mouseChildren = false;
		}
		
		
	}
}