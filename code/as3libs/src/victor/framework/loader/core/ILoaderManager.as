package victor.framework.loader.core
{
	import flash.events.IEventDispatcher;

	public interface ILoaderManager extends IEventDispatcher
	{
		/**
		 * 启动加载器
		 */
		function startLoad():void;

		/**
		 * 批量添加
		 * @param list
		 */
		function setUrls( list:Vector.<LoaderListItemData> ):void;

		/**
		 * 单个添加
		 * @param url 资源加载地址
		 * @param type 资源类型
		 */
		function addUrl( url:String, type:String, name:String = "" ):void;

		/**
		 * 获取加载的对象
		 * @param urlOrName
		 * @return
		 *
		 */
		function getTargetByUrlOrName( urlOrName:String ):*;
	}
}
