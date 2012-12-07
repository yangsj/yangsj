package level
{


	public class LevelMaker
	{
		public static function makeWaves(wavesInfo : Array) : Array
		{
			var waves : Array = [];
			for (var i : int = 0; i < wavesInfo.length; i++)
			{
				var waveInfo : Array = wavesInfo[i];
				log('waveInfo:', waveInfo);
				var wave : Wave = new Wave(waveInfo[0], waveInfo[1]);
				waves[i] = wave;
				if (i > 0)
				{
					wave.prevWave = waves[i - 1];
				}
			}
			log('waves.length:', waves.length);
			return waves;
		}
	}
}
