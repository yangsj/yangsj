package character
{
	/**
	 * @author jamtype7
	 */
	public class FrameInfo
	{
		public var name : String;
		public var start : int;
		public var end : int;
		public var frameRate : Number;

		public function FrameInfo(name : String, start : int, end : int, frameRate : Number)
		{
			this.frameRate = frameRate;
			this.end = end;
			this.start = start;
			this.name = name;
		}

		public function get duration() : Number
		{
			return length / frameRate;
		}

		public function get length() : int
		{
			return (end - start);
		}

		public function toString() : String
		{
			return "character.FrameInfo" + " - name: " + name + " | start: " + start + " | end: " + end;
		}
	}
}
