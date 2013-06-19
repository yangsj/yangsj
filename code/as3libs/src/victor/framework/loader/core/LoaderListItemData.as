package victor.framework.loader.core
{

	/**
	 * ……
	 * @author yangsj
	 */
	public class LoaderListItemData
	{
		public function LoaderListItemData( url:String, type:String, name:String )
		{
			this.url = url;
			this.type = type;
		}

		/**
		 * 资源地址
		 */
		public var url:String = "";
		/**
		 * 资源类型
		 * @see ysj.loader.core.LoaderType
		 */
		public var type:String = "";
		/**
		 * 获取当前资源的名称
		 */
		public var name:String = "";


	}
}
