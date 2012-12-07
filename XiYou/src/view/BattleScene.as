package view
{

	import charactersOld.Character;
	import charactersOld.CharacterEvent;
	import charactersOld.RushCombatant;
	import com.greensock.TweenNano;
	import flash.display.Sprite;
	import flash.events.Event;
	import module.combat.RushCombatModule;
	import utils.ArrayUtils;
	import utils.Heartbeat;






	public class BattleScene extends Sprite
	{
		/**
		 * 所有角色
		 */
		private var chars : Array = [];

		/**
		 * 玩家角色
		 */
		private var players : Array = [];

		/**
		 * 敌方角色
		 */
		private var enemies : Array = [];

		private var seperate : int = 100;

		private var logo : LogoWin;

		public function BattleScene()
		{
			super();
			logo = new LogoWin;
			logo.x = 412.6;
			logo.y = 108.1;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		protected function onRemovedFromStage(event : Event) : void
		{
			for each (var char : Character in chars)
			{
				char.dispose();
			}
			RushCombatModule.stop();
		}

		public function start(team1 : Array, team2 : Array, baseY : Number) : void
		{
			initPlayerChars.apply(null, team1);
			createRightSidePlayers.apply(null, team2);
			chars = players.concat(enemies);
			for each (var char : Character in chars)
			{
				char.y = baseY - (char.width / 300) * 30;
				addCharEvents(char);
				addChild(char);
			}

			zSort(null);
			RushCombatModule.start(getPlayers, getEnemies);
		}

		protected function onAddedToStage(event : Event) : void
		{

		}

		private function getPlayers() : Array
		{
			return players;
		}

		private function getEnemies() : Array
		{
			return enemies;
		}

		private function createRightSidePlayers(... enemyID) : void
		{
			enemies.length = 0;
			var i : int = 0;
			for each (var id : String in enemyID)
			{
				var enemy : RushCombatant = new RushCombatant(Attrs.instance.getAttrById(id), getPlayers);
				enemy.x = 750 + i;
				enemies.push(enemy);
				i -= seperate;
			}
		}

		/**
		 * 初始化玩家角色
		 */
		private function initPlayerChars(... playerID) : void
		{
			players.length = 0;
			var i : int = 0;
			for each (var id : String in playerID)
			{
				var player : RushCombatant = new RushCombatant(Attrs.instance.getAttrById(id), getEnemies);
				player.x = 50 + i;
				player.turnRight();
				players.push(player);
				i += seperate;
			}
		}

		private function addCharEvents(char : Character) : void
		{
			char.addEventListener(CharacterEvent.DISPOSE, onCharDispose);
			char.addEventListener(CharacterEvent.DEAD, onCharDead);
		}

		/**
		 *
		 * @param event
		 */
		protected function onCharDead(event : Event) : void
		{
			var char : Character = event.currentTarget as Character;
			log(char, '\t死亡');

			ArrayUtils.remove(players, char);
			ArrayUtils.remove(enemies, char);
			char.removeEventListener(CharacterEvent.DEAD, onCharDead);

			if (players.length == 0)
				faild();
			else if (enemies.length == 0)
				win();
		}

		private function win() : void
		{
			log('胜利！');

			logo.scaleX = logo.scaleY = 0;
			TweenNano.to(logo, 1, {scaleX: 1, scaleY: 1});
			addChild(logo);
			allStand();
			complete();
		}

		private function complete() : void
		{
			Heartbeat.instance.reset();
			dispatchEvent(new Event(Event.COMPLETE));
		}

		private function allStand() : void
		{
			for each (var char : Character in chars)
			{
				//XXX
//				char.stand();
			}
		}

		private function faild() : void
		{
			log('失败！');
			allStand();
			complete();
		}

		/**
		 *
		 * @param event
		 */
		protected function onCharDispose(event : Event) : void
		{
			var char : Character = event.currentTarget as Character;
			removeChild(char);
			chars.splice(chars.indexOf(char), 1);
			char.removeEventListener(CharacterEvent.DISPOSE, onCharDispose);
		}

		/**
		 * 给场景的人物进行深度排序，人物的深度由宽度决定
		 */
		protected function zSort(event : Event) : void
		{
			chars.sortOn('width', Array.NUMERIC | Array.DESCENDING);
			for (var iChar : * in chars)
			{
				var char : Character = chars[iChar];
				setChildIndex(char, iChar);
			}
		}
	}
}
