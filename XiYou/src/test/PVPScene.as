package test
{
	import flash.events.Event;
	import character.ComplexPawn;
	import character.Pawn;
	import character.PawnEvent;

	import module.HPBar;
	import module.PlayerAttackModule;
	import module.RageEffectView;
	import module.RageModule;
	import module.combat.TeamTurnBattle;
	import module.effect.KnockbackEffect;
	import module.effect.PawnHitEffect;
	import module.effect.ScatEffect;

	import utils.SpriteUtils;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.setTimeout;

	/**
	 * @author Chenzhe
	 */
	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="1024", height="768")]
	public class PVPScene extends Sprite
	{
		private var battle : TeamTurnBattle;
		private var teamAPawns : Array;
		private var teamBPawns : Array;
		private var pawnLayer : Sprite;
		private var effectLayer : RageEffectView;
		private var teamA : Array;
		private var teamB : Array;

		public function PVPScene()
		{
			addChild(new Bitmap(new bg_panSiDong, 'auto', true));
			pawnLayer = new Sprite();
			addChild(pawnLayer);
			effectLayer = new RageEffectView();
			addChild(effectLayer);
			battle = new TeamTurnBattle();
			start(['11', '14', '20'], ['0', '1', '2']);
		}

		private function pawnFormID(id : *, i : *, team : Array) : Pawn
		{
			var pawn : ComplexPawn = new ComplexPawn(id);
			pawn.extra.hpBar = new HPBar(pawn);
			pawn.addChild(pawn.extra.hpBar);
			new KnockbackEffect(pawn);
			new ScatEffect(pawn, this);
			new PawnHitEffect(pawn);
			pawn.addEventListener(PawnEvent.DISPOSE, onPawnDispose);
			pawn.extra.rage = new RageModule(pawn);
			pawn.extra.attack = new PlayerAttackModule(pawn, team == teamA ? teamAPawns : teamBPawns, effectLayer);
			pawn.speed = 600;
			pawnLayer.addChild(pawn);
			return pawn;
		}

		private function onPawnDispose(event : PawnEvent) : void
		{
			var pawn : ComplexPawn = event.currentTarget as ComplexPawn;
			pawn.removeEventListener(PawnEvent.DISPOSE, onPawnDispose);
			SpriteUtils.safeRemove(pawn);
		}

		public function start(teamA : Array, teamB : Array) : void
		{
			this.teamB = teamB;
			this.teamA = teamA;
			teamAPawns = teamA.map(pawnFormID);
			teamBPawns = teamB.map(pawnFormID);
			var pos : Array = [new Point(85, 403), new Point(200, 420), new Point(93, 540), new Point(217, 507)];
			for (var i : String in teamAPawns)
			{
				var p : Point = pos[i];
				teamAPawns[i].x = p.x;
				teamAPawns[i].y = p.y;
				teamAPawns[i].alliance = 'Player';
				Pawn(teamAPawns[i]).turnRight();
			}
			for (var j : String in teamBPawns)
			{
				var p : Point = pos[j];
				teamBPawns[j].x = 1024 - p.x;
				teamBPawns[j].y = p.y;
				teamAPawns[j].alliance = 'Enemy';
			}
			fight(teamAPawns.shift(), teamBPawns.shift());
		}

		private function fight(a : Pawn, b : Pawn) : void
		{
			if (a.y != 480)
				a.moveTo(new Point(400, 480), null, function() : void
				{
					SpriteUtils.zSort(pawnLayer);
				});
			if (b.y != 480)
				b.moveTo(new Point(1024 - 400, 480),function() : void
				{
					b.turnTo(a.x);
				});

			setTimeout(function() : void
			{
				//TODO 暂时没有做输赢处理
				battle.startRound([a], [b], pawnLayer, null, function() : void
				{
					if (teamBPawns.length)
						fight(a, teamBPawns.shift());
					else
						complete();
				}, function() : void
				{
					if (teamAPawns.length)
						fight(teamAPawns.shift(), b);
					else
						complete();
				});
			}, 1000);
		}

		private function complete() : void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}
