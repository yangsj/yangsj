package sound
{
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.media.SoundLoaderContext;

	/**
	 * @author Chenzhe
	 */
	public class EmbededSound extends Sound
	{
		/**
		 * @param sndClass 播放的声音资源类，例如:SoundResource.instance.attack
		 * @param loops 循环的次数，0为不循环
		 */
		public static function play(sndClass : Class, loops : int = 0) : SoundChannel
		{
			var snd : EmbededSound = new EmbededSound(sndClass);
			return snd.play(0, loops);
		}

		/**
		 * @param sndClass 播放的声音资源类，例如:SoundResource.instance.attack
		 */
		public function EmbededSound(sndClass : Class)
		{
			super();
			var ba : ByteArray = new sndClass as ByteArray;
			loadCompressedDataFromByteArray(ba, ba.length);
		}
	}
}
