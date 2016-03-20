package net.victor.ui
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class BaseMc extends MovieClip
	{
		public var id:int = 0;
		
		public var lineX:int = 0;
		public var lineY:int = 0;
		
		protected var wireFrame:MovieClip = new MovieClip();;

		public function BaseMc()
		{
			this.mouseChildren = false;
		}
		
		public function isClickDown():void
		{
			wireFrame.visible = true;
		}
		
		public function isClickOthers():void
		{
			wireFrame.visible = false;
		}
		
		public function hideWireFrame():void
		{
			wireFrame.visible = false;
		}

	}

}