package module
{
	import character.FrameLabels;
	import charactersOld.Character;
	use namespace status;




	public class DeadAction extends Action
	{
		private var host : Character;

		public function DeadAction(host : Character)
		{
			this.host = host;
			super('dead');
		}

		override status function start() : void
		{
			host.play({frames: [FrameLabels.DEAD], loop: false, onComplete: complete});
		}
	}
}
