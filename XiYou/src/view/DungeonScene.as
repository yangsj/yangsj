package view
{

	import character.PawnAttr;
	import charactersOld.AIFreeCombatant;
	import charactersOld.Character;
	import charactersOld.CharacterEvent;
	import charactersOld.FreeCombatant;
	import com.greensock.TweenNano;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import global.Global;
	import level.ILevel;
	import level.LevelEvent;
	import level.Wave;
	import module.DragIndicator;
	import utils.ArrayUtils;
	import utils.MathUtils;
	import utils.SpriteUtils;








	public class DungeonScene extends BasicBattleScene
	{
		protected var chars : Array = [];
		protected var players : Array = [];
		protected var enemies : Array = [];
		protected var selected : FreeCombatant;
		protected var bMouseDown : Boolean;
		protected var top : Number;
		private var indicator : DragIndicator;
		private var selectedEnemy : FreeCombatant;



		public function DungeonScene()
		{
			super();
			//

			indicator = new DragIndicator;
			addChild(indicator);
		}

		/**
		 *
		 */
		public function start(playerTeam : Array, levels : Array, interactiveLayer : InteractiveObject, top : Number = 480) : void
		{
			this.top = top;
			setupGlobalValue();

			createPlayers.apply(this, playerTeam);
//			createEnemies.apply(this, team2); //('2', '0', '10');

			levels.map(function(lv : ILevel, ... rest) : void
			{
				lv.addEventListener(LevelEvent.START, onLevelStart);
			});

			ArrayUtils.last(levels).addEventListener(LevelEvent.COMPLETE, onLevelAllComplete);
			setTimeout(startFirstLevel, 4000, levels[0]);

			updateChars();
			addEventListener(Event.ENTER_FRAME, zSort);

			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}



		protected function updateChars() : void
		{
			chars = players.concat(enemies);
		}

		protected function setupGlobalValue() : void
		{
			Global.FPS = 18;
			Global.speedFactor = 12;
			PawnAttr.factor_STR_AD = 0.4;
			PawnAttr.factor_DEX_AD = 0.1;
			PawnAttr.factor_STR_NearDMG = 1;
			PawnAttr.factor_DEX_RangeDMG = 0.5;
			PawnAttr.factor_INT_AP = 0.5;
		}

		protected function startFirstLevel(lv : ILevel) : void
		{
			var pos : * = {'2': new Point(-100, top), '1': new Point(-100, Global.standardHeight + 100), '3': new Point(Global.standardWidth + 100, top), '4': new Point(Global.standardWidth + 100, Global.standardHeight + 100)};
			pos['6'] = MathUtils.middlePt(pos['2'], pos['1']);
			pos['8'] = MathUtils.middlePt(pos['3'], pos['4']);
			pos['5'] = MathUtils.middlePt(pos['1'], pos['4']);
			lv.start(getPlayers, pos);
		}

		protected function onLevelStart(evt : Event) : void
		{
			var lv : ILevel = evt.currentTarget as ILevel;
			lv.removeEventListener(LevelEvent.START, onLevelStart);
			lv.enemies.map(addBots);
			updateChars();
		}

		protected function onLevelAllComplete(evt : Event) : void
		{
			win();
		}

		protected function addBots(bot : FreeCombatant, ... rest) : void
		{
			enemies.push(bot);

			bot.addEventListener(CharacterEvent.DEAD, onCharDead);
			bot.addEventListener(CharacterEvent.DISPOSE, onCharDispose);

			addChild(bot);
			if (bot.isArcher)
			{
				//远程兵要先进场才开打
				bot.moveToPos(400, 400);
			}
//				bot.moveToPos(200, 200);
			setTimeout(function() : void
			{
				bot.attackTarget(ArrayUtils.random(players));
			}, 3000);
//				bot.follow(players[0]);
//				bot.follow(ArrayUtils.random(players));
		}

		override protected function onRemoved(event : Event) : void
		{
			super.onRemoved(event);
			removeEventListener(Event.ENTER_FRAME, zSort);
		}

		protected function getPlayers() : Array
		{
			return players;
		}

		protected function getEnemies() : Array
		{
			return enemies;
		}

		public function createPlayers(... ids) : void
		{
			players = [];
			var posTeamA : Array = [[202.25, 206], [254.2, 309.65], [106, 231], [157.95, 334.65]];
			for (var i : * in ids)
			{
				var attr : PawnAttr = Attrs.instance.getAttrById(ids[i]);
				var player : FreeCombatant = new FreeCombatant(attr, getEnemies, 'Player');
				players[i] = player

				addPlayerEvents(player);

				player.x = i > 1 ? -200 : -100;
				var _y : Number = posTeamA[i][1] * (Global.standardHeight - top) / 480 + top;
				player.y = _y;
				FreeCombatant(players[i]).moveToPos(posTeamA[i][0] * Global.standardWidth / 800, _y);
				addChild(player);
			}
			var moveZone : Rectangle = new Rectangle(50, top, Global.standardWidth - 100, Global.standardHeight - 50 - top);

			setTimeout(function() : void
			{
				players.map(function(player : FreeCombatant, ... rest) : void
				{
					player.moveZone = moveZone;
				});
			}, 4000);
		}

		public function enrage(id : String) : void
		{
			for each (var player : FreeCombatant in players)
			{
				if (player.id == id)
					player.enrage();
			}
		}

		private function addPlayerEvents(player : FreeCombatant) : void
		{
			player.addEventListener(CharacterEvent.DEAD, onCharDead);
			player.addEventListener(CharacterEvent.DISPOSE, onCharDispose);
			player.addEventListener(CharacterEvent.DEAD, onPlayerDead);
		}

		protected function onCharDead(evt : CharacterEvent) : void
		{
			ArrayUtils.remove(chars, evt.currentTarget);
			ArrayUtils.remove(players, evt.currentTarget);
			ArrayUtils.remove(enemies, evt.currentTarget);
		}

		protected function onCharDispose(evt : CharacterEvent) : void
		{
			trace(evt.currentTarget.name, '销毁');
			evt.currentTarget.removeEventListener(CharacterEvent.DISPOSE, onCharDispose);
			removeChild(evt.currentTarget as DisplayObject);
		}

		protected function onPlayerDead(event : CharacterEvent) : void
		{
			var player : * = event.currentTarget;
			removePlayerEvents(player);
			if (players.length == 0)
				faild()
		}

		protected function removePlayerEvents(player : FreeCombatant, ... rest) : void
		{
			player.removeEventListener(CharacterEvent.DEAD, onCharDead);
			player.removeEventListener(CharacterEvent.DEAD, onPlayerDead);
			player.removeEventListener(CharacterEvent.MOVING, onSelectedMoving);
			player.removeEventListener(CharacterEvent.DEAD, onSelectedDead);
		}

		protected function removeEnemyEvents(enemy : FreeCombatant, ... rest) : void
		{
			enemy.removeEventListener(CharacterEvent.DEAD, onCharDead);
//			enemy.removeEventListener(CharacterEvent.DEAD, onEnemyDead);
		}


		override protected function faild() : void
		{
			super.faild();
			setTimeout(complete, 0);
		}

		override protected function win() : void
		{
			super.win();
			setTimeout(complete, 0);
		}

		protected function complete() : void
		{
			selected = null;
			SpriteUtils.safeRemove(indicator);
			graphics.clear();
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			players.map(removePlayerEvents);
			enemies.map(removeEnemyEvents);


			var n : uint = chars.length;
			var _x : Number = Global.standardWidth / 2 - ((n - 1) * 150) * .5;
			chars.sortOn('x');
			for each (var char : FreeCombatant in chars)
			{
				char.moveToPos(_x, Global.standardHeight / 2 + 100);
				_x += 150;
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}

		protected function onStageMouseMove(event : MouseEvent) : void
		{
			indicator.setPoint(mouseX, mouseY);
			if (selectedEnemy == null)
			{
				var enemyUnderMouse : Array = enemies.filter(selectCharUnderMouse);
				enemyUnderMouse.sortOn('y', Array.NUMERIC);
				selectedEnemy = enemyUnderMouse.pop();
				indicator.selectEnemy(selectedEnemy);
			}
			else if (!selectedEnemy.hitTestPoint(mouseX, mouseY))
			{
				selectedEnemy = null;
				indicator.selectEnemy(null);
			}

		}

		private function selectCharUnderMouse(char : FreeCombatant, ... rest) : Boolean
		{
			return char.hitTestPoint(mouseX, mouseY);
		}

		protected function onSelectedDead(event : Event) : void
		{
			selected = null;
			graphics.clear();
		}

		protected function onSelectedMoving(event : Event) : void
		{
			if (selected == null)
				return;
			var b : Point = bMouseDown ? new Point(mouseX, mouseY) : new Point(selected.x, selected.y);
		}

		protected function onMouseDown(event : Event) : void
		{
			var playerUnderMouse : Array = players.filter(selectCharUnderMouse);
			playerUnderMouse.sortOn('y', Array.NUMERIC);
			if (playerUnderMouse.length == 0)
				return;
			var target : FreeCombatant = playerUnderMouse.pop();
			bMouseDown = true;
			if (selected)
			{
				selected.removeEventListener(CharacterEvent.MOVING, onSelectedMoving);
				selected.removeEventListener(CharacterEvent.DEAD, onSelectedDead);
			}
			selected = target;
			selected.addEventListener(CharacterEvent.MOVING, onSelectedMoving);
			selected.addEventListener(CharacterEvent.DEAD, onSelectedDead);
			indicator.select(selected);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
		}

		protected function onMouseUp(event : MouseEvent) : void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			if (selected && bMouseDown)
			{
				if (selectedEnemy)
				{
					selected.attackTarget(selectedEnemy);
				}
				else
				{
					if (!selected.hitTestPoint(mouseX, mouseY, true))
						selected.moveToPos(mouseX, mouseY);
				}
				indicator.setPoint(mouseX, mouseY);
				indicator.play();
			}
			bMouseDown = false;
		}

		protected function zSort(event : Event) : void
		{
			chars.sortOn(['y', 'creatTime'], [Array.NUMERIC, Array.NUMERIC]);
			for (var iChar : * in chars)
			{
				var char : Character = chars[iChar];
				setChildIndex(char, iChar + 1);
			}
		}
	}
}
