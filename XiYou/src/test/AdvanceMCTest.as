package test
{
	import flash.utils.setTimeout;
	import flash.geom.Point;

	import character.ComplexPawn;
	import character.Pawn;

	import battle.XiaBin;

	import flash.display.Sprite;

	/**
	 * @author Administrator
	 */
	[SWF(backgroundColor = "#000000", frameRate = "10", width = "640", height = "480")]
	public class AdvanceMCTest extends Sprite
	{
		public function AdvanceMCTest()
		{
			var pawn : ComplexPawn = new ComplexPawn('62', 1);
			pawn.x = pawn.y = 300;
			addChild(pawn);
			pawn.setFrameHandler('attack3', -1, function() : void
			{
				throw 3;
			});
			setTimeout(function() : void
			{
				pawn.play(['attack3']);
			}, 2000);
		}
	}
}
