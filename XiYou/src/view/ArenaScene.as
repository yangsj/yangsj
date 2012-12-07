package view
{

	import character.PawnAttr;
	import charactersOld.AIFreeCombatant;
	import charactersOld.CharacterEvent;
	import charactersOld.FreeCombatant;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	import global.Global;
	import utils.ArrayUtils;





	public class ArenaScene extends DungeonScene
	{
		public function ArenaScene()
		{
			super();
		}

		public function startFight(playerTeam : Array, enemyTeam : Array, top : Number = 480) : void
		{
			this.top = top;
			setupGlobalValue();
			createPlayers.apply(this, playerTeam);
			createEnemies.apply(this, enemyTeam); //('2', '0', '10');

			updateChars();
			addEventListener(Event.ENTER_FRAME, zSort);
		}

		override public function createPlayers(... ids) : void
		{
			players = [];
			var posTeamA : Array = [[202.25, 206], [254.2, 309.65], [106, 231], [157.95, 334.65]];
			for (var i : * in ids)
			{
				var attr : PawnAttr = Attrs.instance.getAttrById(ids[i]);
				players[i] = new AIFreeCombatant(attr, getEnemies);
				players[i].addEventListener(CharacterEvent.DEAD, onCharDead);
				players[i].addEventListener(CharacterEvent.DISPOSE, onCharDispose);
				players[i].addEventListener(CharacterEvent.DEAD, onPlayerDead);

				players[i].x = i > 1 ? -200 : -100;
				var _y : Number = (Global.standardHeight - top) * Math.random() + top; //posTeamA[i][1] * (Global.standardHeight - top) / 480 + top;
				players[i].y = _y;
				FreeCombatant(players[i]).moveToPos(posTeamA[i][0] * Global.standardWidth / 800, _y);
				addChild(players[i]);
			}
			var moveZone : Rectangle = new Rectangle(50, top, Global.standardWidth - 100, Global.standardHeight - 50 - top);
			setTimeout(function() : void
			{
				players.map(function(player : FreeCombatant, ... rest) : void
				{
//					player.addEventListener(MouseEvent.MOUSE_DOWN, onPlayerMouseDown);
					player.moveZone = moveZone;
					player.attackTarget(ArrayUtils.random(enemies));
				});
			}, 3000);
		}

		protected function createEnemies(... ids) : void
		{
			enemies = [];
			var posTeamA : Array = [[202.25, 206], [254.2, 309.65], [106, 231], [157.95, 334.65]];
			for (var i : * in ids)
			{
				var attr : PawnAttr = Attrs.instance.getAttrById(ids[i]);
				enemies[i] = new AIFreeCombatant(attr, getPlayers);
				enemies[i].alliance = 'ENEMY';
				enemies[i].addEventListener(CharacterEvent.DEAD, onCharDead);
				enemies[i].addEventListener(CharacterEvent.DISPOSE, onCharDispose);
				enemies[i].addEventListener(CharacterEvent.DEAD, onEnemyDead);

				enemies[i].x = i > 1 ? Global.standardWidth + 200 : Global.standardWidth + 100;
				var _y : Number = (Global.standardHeight - top) * Math.random() + top; //posTeamA[i][1] * (Global.standardHeight - top) / 480 + top;
				enemies[i].y = _y;
				FreeCombatant(enemies[i]).moveToPos(Global.standardWidth - (posTeamA[i][0] * Global.standardWidth / 800), _y);
				addChild(enemies[i]);
			}
			var moveZone : Rectangle = new Rectangle(50, top, Global.standardWidth - 100, Global.standardHeight - 50 - top);
			setTimeout(function() : void
			{
				enemies.map(function(player : FreeCombatant, ... rest) : void
				{
					player.moveZone = moveZone;
					player.attackTarget(ArrayUtils.random(players));
				});
			}, 3000);
		}

		protected function onEnemyDead(event : Event) : void
		{
			var enemy : * = event.currentTarget;
			removeEnemyEvents(enemy);
			if (enemies.length == 0)
				win();
		}
	}
}
