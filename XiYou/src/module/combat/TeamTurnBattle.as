package module.combat
{
	import module.PlayerAttackModule;
	import module.AttackModule;

	import character.ComplexPawn;
	import character.Pawn;

	import module.RageEffectView;

	import utils.SpriteUtils;

	import com.greensock.TweenLite;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;

	/**
	 * @author Chenzhe
	 */
	public class TeamTurnBattle extends EventDispatcher
	{
		private var players : Array;
		private var timeout_turn : TweenLite;
		private var effectLayer : RageEffectView;
		private var onComplete : Function;
		private var onFaild : Function;
		private var enemies : Array;
		private var pawnLayer : Sprite;
		private var interval_zSort : uint;
		private var interval_check_inPosition : uint;
		private var dic_pawn_position : Dictionary;
		private var all : Array;

		public function startRound(players : Array, enemies : Array, pawnLayer : Sprite, effectLayer : RageEffectView, onComplete : Function, onFaild : Function) : void
		{
			this.pawnLayer = pawnLayer;
			this.enemies = enemies;
			this.onFaild = onFaild;
			this.onComplete = onComplete;
			this.effectLayer = effectLayer;
			this.players = players;
			SpriteUtils.zSort(pawnLayer);
			interval_zSort = setInterval(SpriteUtils.zSort, 250, pawnLayer);
			dic_pawn_position = new Dictionary(false);
			all = players.concat(enemies);
			for each (var pawn : Pawn in all)
			{
				dic_pawn_position[pawn] = SpriteUtils.position(pawn);
			}
			turn(players.concat(), enemies.concat(), enemies.concat());
		}

		private function clean(evt : Event = null) : void
		{
			if (timeout_turn)
				timeout_turn.kill();
			if (pawnLayer)
				SpriteUtils.zSort(pawnLayer);
			clearInterval(interval_zSort);
			clearInterval(interval_check_inPosition);
			// TODO clearTimeout(atkDelay);
			for (var i : * in dic_pawn_position)
			{
				dic_pawn_position[i] = null;
				delete dic_pawn_position[i];
			}
			dic_pawn_position = null;
		}

		private function selectAlive(pawn : Pawn, ...rest) : Boolean
		{
			return pawn.HP > 0;
		}

		private function teamHP(team : Array) : Number
		{
			var tHp : Number = 0;
			for each (var member : Pawn in team)
			{
				tHp += member.HP;
			}
			trace('tHp: ' + (tHp));
			return tHp;
		}

		private function turn(teamA : Array, teamB : Array, teamBCopy : Array, i : int = 0) : void
		{
			if (teamHP(players) == 0)
			{
				clean();
				onFaild();
				return;
			}
			if (teamHP(enemies) == 0)
			{
				clean();
				onComplete();
				return;
			}

			var attacker : ComplexPawn = teamA[i++];

			if (attacker != null)
			{
				if (attacker.HP == 0 || attacker.freezed)
					turn(teamA, teamB, teamBCopy, i);
				else
				{
					teamBCopy = teamBCopy.filter(selectAlive).sortOn(['HP', 'x'], [Array.NUMERIC | Array.DESCENDING, Array.NUMERIC]);
					timeout_turn = TweenLite.to({}, .2, {onComplete:function() : void
					{
						turn(teamA, teamB, teamBCopy, i);
					}});
					if (attacker.extra.attack is PlayerAttackModule)
						PlayerAttackModule(attacker.extra.attack).timeout_turn = timeout_turn;
					//XXX
					AttackModule(attacker.extra.attack).attack(teamBCopy.shift());
					if (teamBCopy.length == 0)
						teamBCopy = teamB.concat();
				}
			}
			else
			{
				var all_alive : Array = all.filter(selectAlive);
				interval_check_inPosition = setInterval(function() : void
				{
					if (timeout_turn.paused)
						return;
					for each (var pawn : Pawn in all_alive)
					{
						var pos : Point = SpriteUtils.position(pawn);
						var originPos : Point = dic_pawn_position[pawn];

						if (pos.x != originPos.x || pos.y != originPos.y)
						{
							return;
						}
					}
					clearInterval(interval_check_inPosition);
					turn(teamB, teamA, teamA.concat(), 0);
				}, 500);
			}
		}
	}
}