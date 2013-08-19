package code
{
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class PathVo
	{
		public var id:int;
		
		public var url:String;
		
		public var window:String;
		
		public var name:String;
		
		public function PathVo( id:int, url:String = "", name:String = "", window:String = "_blank" )
		{
			this.id = id;
			this.url = url;
			this.name = name;
			this.window = window;
		}
	}
}