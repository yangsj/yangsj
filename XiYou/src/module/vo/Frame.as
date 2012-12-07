package module.vo
{


	public class Frame
	{
		public var name : String;
		public var priority : int;
		public var jumpToOnEnd : String;

		public function Frame(name : String, priority : int = 0, jumpToOnEnd : String = null)
		{
			this.name = name;
			this.priority = priority;
			this.jumpToOnEnd = jumpToOnEnd;
		}
	}
}
