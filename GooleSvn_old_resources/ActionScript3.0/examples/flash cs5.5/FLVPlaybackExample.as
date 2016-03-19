package 
{
	import fl.video.FLVPlayback;
	import flash.display.Sprite;

	public class FLVPlaybackExample extends Sprite
	{

		private var videoPath:String = "Video.flv";

		public function FLVPlaybackExample()
		{
			player.source = videoPath;
			player.skinBackgroundColor = 0x666666;
			player.skinBackgroundAlpha = 0.5;
		}
	}
}