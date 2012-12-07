package module
{

	import charactersOld.Character;
	import charactersOld.CharacterEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import utils.MathUtils;




	public class DragIndicator extends Sprite
	{
		private var selectedHalo : SelectedHalo = new SelectedHalo;
		private var disk : Disk1 = new Disk1;
		private var link : Link = new Link;
		private var char : Character;
		private var enemy : Character;

		public function DragIndicator()
		{
			super();
			reset();
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}

		protected function onRemoved(event : Event) : void
		{
			selectEnemy(null);
			select(null);
			reset();
		}

		private function reset() : void
		{
			disk.stop();
			//disk.onEnd = disk.stop;
			link.stop();
			//link.onEnd = link.stop;
			link.visible = disk.visible = selectedHalo.visible = false;
			addChild(link);
			addChild(selectedHalo);
			addChild(disk);
		}

		public function play() : void
		{
			disk.gotoAndPlay(0);
			link.gotoAndPlay(0);
		}

		public function setPoint(x : Number, y : Number) : void
		{
			if (enemy)
				return;
			disk.x = mouseX;
			disk.y = mouseY;

			updateLink(mouseX, mouseY);

			disk.visible = true;
			link.visible = true;
		}

		private function updateLink(_x : Number, _y : Number) : void
		{
			if (char == null)
				return;
			link.x = char.x;
			link.y = char.y;

			link.rotation = 0;
			link.width = MathUtils.distance(link.x, link.y, _x, _y);
			link.rotation = MathUtils.anglePt(link.x, link.y, _x, _y);
		}

		public function select(char : Character) : void
		{
			if (this.char != null)
				removeEvents(this.char);
			this.char = char;
			if (char)
			{
				addEvents(char);
				selectedHalo.visible = true;
				selectedHalo.x = char.x;
				selectedHalo.y = char.y;
				disk.gotoAndStop(0);
				link.gotoAndStop(0);
				disk.visible = false;
			}
		}

		public function selectEnemy(target : Character) : void
		{
			if (enemy)
				removeEnemyEvents(enemy);
			enemy = target;
			if (enemy)
			{
				disk.x = enemy.x;
				disk.y = enemy.y;
				updateLink(enemy.x, enemy.y);
				addEnemyEvents(enemy);
			}
			else
			{
				disk.x = mouseX;
				disk.y = mouseY;
				updateLink(mouseX, mouseY);
			}
		}

		private function addEnemyEvents(enemy : Character) : void
		{
			enemy.addEventListener(CharacterEvent.MOVING, onEnemyMoving);
			enemy.addEventListener(CharacterEvent.DEAD, onEnemyDead);
		}

		protected function onEnemyDead(event : Event) : void
		{
			selectEnemy(null);
		}

		private function removeEnemyEvents(enemy : Character) : void
		{
			enemy.removeEventListener(CharacterEvent.MOVING, onEnemyMoving);
			enemy.removeEventListener(CharacterEvent.DEAD, onEnemyDead);
		}

		protected function onEnemyMoving(event : Event) : void
		{
			disk.x = enemy.x;
			disk.y = enemy.y;
			updateLink(enemy.x, enemy.y);
		}

		private function addEvents(char : Character) : void
		{
			char.addEventListener(CharacterEvent.MOVING, onCharMoving);
			char.addEventListener(CharacterEvent.DEAD, onCharDead);
		}

		private function removeEvents(char : Character) : void
		{
			char.removeEventListener(CharacterEvent.MOVING, onCharMoving);
			char.removeEventListener(CharacterEvent.DEAD, onCharDead);
		}

		protected function onCharDead(event : Event) : void
		{
			selectEnemy(null);
			select(null);
			disk.visible = false;
			link.visible = false;
			selectedHalo.visible = false;
		}

		protected function onCharMoving(event : Event) : void
		{
			selectedHalo.x = char.x;
			selectedHalo.y = char.y;
			if (enemy == null)
				updateLink(mouseX, mouseY);
			else
				updateLink(enemy.x, enemy.y);
		}
	}
}
