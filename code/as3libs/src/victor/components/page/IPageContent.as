package victor.components.page
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	import victor.components.interfaces.IDispose;

	/**
	 * ……
	 * @author yangsj
	 */
	public interface IPageContent extends IDispose
	{
		/**
		 * 初始化
		 */
		function initialize():void;

		/**
		 * 刷新显示
		 */
		function refresh():void;
		
		/**
		 * 重置
		 */
		function reset():void;

		/**
		 * 所有页面的数据
		 */
		function get items():Array;

		function set items( value:Array ):void;
		
		/**
		 * 上翻页按钮（第一帧可翻页，第二帧灰态）
		 */
		function set btnPrev(value:MovieClip):void;
			
		/**
		 * 下翻页按钮（第一帧可翻页，第二帧灰态）
		 */
		function set btnNext(value:MovieClip):void;
		
		/**
		 * 页码显示文本
		 */
		function set txtFlip(txt:TextField):void;
			
	}
}
