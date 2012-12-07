package test
{

	import character.ComplexPawn;
	import character.Pawn;
	import com.greensock.TweenNano;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;
	import map.Hexagon;
	import map.HexagonMap;
	import map.HuoYanShan;
	import utils.ArrayUtils;
	import utils.SpriteUtils;






	/**
	 * @author Administrator
	 */
	[SWF(backgroundColor = "#FFFFFF", frameRate = "24", width = "1024", height = "768")]
	public class HexgonMapTest extends Sprite
	{
		private var map : HexagonMap;

		private var players : Array;

		private var pawns : Array;

		private var selectedPawn : Pawn;

		private var enemies : Array;

		private var pawnLayer : Sprite = new Sprite();

		private var rageEffectLayer : Sprite = new Sprite();

		private var dic_id_player : Object = {};

		/**
		 * 行动点数
		 */
		private var actionPoints : uint;

		private var teams : Array;

		private var useRageAttack : Boolean;

		public function HexgonMapTest()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			map = new ui_HexagonMap1();
			addChild(new HuoYanShan());
			addChild(map);
			addChild(pawnLayer);
			addChild(rageEffectLayer);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onStageMouseDown);
			//stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			//start(['17', '14'], ['0']);
			//stage.addChild(new Stats());
		}

		private function showRageEffect(pawn : Pawn, onComplete : Function) : void
		{
			var effect : Bitmap = new Bitmap((new (getDefinitionByName('rage.' + pawn.name))) as BitmapData);
			effect.x = effect.width;
			effect.y = 220;
			rageEffectLayer.addChild(effect);
			TweenNano.to(effect, .5, {x: -80});
			setTimeout(function() : void
			{
				TweenNano.to(effect, .5, {x: -effect.width, onComplete: onComplete});
			}, 1500);
		}

		private function zSort(event : Event) : void
		{
			pawns.sortOn(['y', 'creatTime'], [Array.NUMERIC, Array.NUMERIC]);
			for (var i : * in pawns)
			{
				var pawn : Pawn = pawns[i];
				pawnLayer.setChildIndex(pawn, i);
			}
		}

		public function start(playerTeam : Array, ... rest) : void
		{
			var enemyTeam : Array = ['0', '2', '3', '5'];
			players = [];
			enemies = [];
			var playerPosition : Array = [[190, 540], [320, 540], [160, 660], [290, 660]]; //[[220, 470], [400, 470], [180, 590], [360, 590]];
			var enemyPosition : Array = [[870, 420], [740, 420], [900, 300], [770, 300]]; //[[800, 350], [620, 350], [840, 230], [660, 230]];
			for each (var id : * in playerTeam)
			{
				var player : ComplexPawn = new ComplexPawn(id);
				var position : Array = playerPosition.shift();
				player.x = position[0];
				player.y = position[1];
				player.alliance = 'Player';
				dic_id_player[id] = player;
				players.push(player);
				pawnLayer.addChild(player);
			}

			for each (var id : * in enemyTeam)
			{
				var enemy : ComplexPawn = new ComplexPawn(id);
				var position : Array = enemyPosition.shift();
				enemy.x = position[0];
				enemy.y = position[1];
				enemy.alliance = 'Enemy';
				enemies.push(enemy);
				pawnLayer.addChild(enemy);
			}

			pawns = players.concat(enemies);
			teams = [players, enemies];
			addPawnsEvents();
			addEventListener(Event.ENTER_FRAME, zSort);

			roundStart(teams[0]);
		}

		private function roundStart(team : Array) : void
		{
			actionPoints = team.length;
			SpriteUtils.forEachChild(map, function(cell : Hexagon) : void
			{
				var pawnUpon : Pawn = ArrayUtils.selectOne(team, function(pawn : Pawn) : Boolean
				{
					return pawn.x == cell.x && pawn.y == cell.y;
				});
				if (pawnUpon)
					cell.color = 'green';
			});
		}

		public function enrage(id : String) : void
		{
			if (dic_id_player[id] != null)
				useRageAttack = true;
		}

		private function addPawnsEvents() : void
		{
			for each (var pawn : Pawn in pawns)
			{
				pawn.addEventListener('dead', onPawnDead);
				pawn.addEventListener('dispose', onPawnDispose);
			}
		}

		private function onPawnDispose(event : Event) : void
		{
			SpriteUtils.safeRemove(event.currentTarget as Pawn);
		}

		private function onPawnDead(event : Event) : void
		{
			var pawn : Pawn = event.currentTarget as Pawn;
			for (var id : String in dic_id_player)
			{
				if (dic_id_player[id] == pawn)
				{
					dic_id_player[id] = null;
					delete dic_id_player[id];
				}
			}
			ArrayUtils.remove(pawns, pawn);
			ArrayUtils.remove(players, pawn);
			ArrayUtils.remove(enemies, pawn);
			if (players.length == 0 || enemies.length == 0)
				complete();
		}

		private function complete() : void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}

//		private function onStageMouseUp(event : MouseEvent) : void
//		{
//			if (SimpleMCButton.focus == null)
//				return;
//			var hexagon : Hexagon = SimpleMCButton.focus.parent as Hexagon;
//			var pawnUpon : Pawn = ArrayUtils.selectOne(pawns, function(pawn : Pawn) : Boolean
//			{
//				return pawn.x == hexagon.x && pawn.y == hexagon.y;
//			});
//			if (selectedPawn)
//			{
//				if (pawnUpon && pawnUpon.alliance != selectedPawn.alliance)
//				{
//					var attackPostion : Hexagon = [hexagon.neighbours[1], hexagon.neighbours[2], hexagon.neighbours[4], hexagon.neighbours[5]].filter(function(target : Hexagon, ... rest) : Boolean
//					{
//						if (target == null)
//							return false;
//						for each (var pawn : Pawn in pawns)
//						{
//							if (pawn != selectedPawn && pawn.x == target.x && pawn.y == target.y)
//								return false;
//						}
//						return true;
//					}).sort(function(a : Hexagon, b : Hexagon) : Number
//					{
//						return MathUtils.distance(selectedPawn.x, selectedPawn.y, a.x, a.y) - MathUtils.distance(selectedPawn.x, selectedPawn.y, b.x, b.y);
//					})[0];
//					if (attackPostion)
//					{
//						selectedPawn.addEventListener('arrival', function() : void
//						{
//							selectedPawn.removeEventListener('arrival', arguments.callee);
//							selectedPawn.attack(pawnUpon);
//						});
//						selectedPawn.moveTo(attackPostion);
//					}
//				}
//				else if (pawnUpon == null && (hexagon.x != selectedPawn.x || hexagon.y != selectedPawn.y))
//				{
//					selectedPawn.moveTo(hexagon);
//				}
//			}
//		}

		private function onStageMouseDown(event : MouseEvent) : void
		{
			if (Hexagon.focus == null)
				return;
			var hexagon : Hexagon = Hexagon.focus;
			if (hexagon.visible == false)
				return;
			var pawnUpon : Pawn = ArrayUtils.selectOne(pawns, function(pawn : Pawn) : Boolean
			{
				return pawn.x == hexagon.x && pawn.y == hexagon.y;
			});

			if (pawnUpon)
			{
				if (hexagon.color == 'yello')
				{
					selectedPawn.addEventListener('attack_complete', function(evt : Event) : void
					{
						evt.currentTarget.removeEventListener('attack_complete', arguments.callee);
						map['mapCells']['forEach'](function(cell : Hexagon, ... rest) : void
						{
							if (cell.color == 'yello')
								cell.color = 'blue';
						});
						next();
					});
					if (useRageAttack)
					{
						selectedPawn.addEventListener('rage_start_complete', function() : void
						{
							selectedPawn.removeEventListener('rage_start_complete', arguments.callee);
							showRageEffect(selectedPawn, function() : void
							{
								selectedPawn.attack([pawnUpon], true, 2.5);
							});
						});
						useRageAttack = false;
						selectedPawn.rageStart();
					}
					else
						selectedPawn.attack([pawnUpon]);
					mapCellUnder(selectedPawn).color = 'blue';
				}
				else if (hexagon.color == 'green')
				{
					useRageAttack = false;
					selectedPawn = pawnUpon;
					hideAllMapCell();
					var moveRangeIndicator : MoveRange1 = new MoveRange1();
					moveRangeIndicator.scaleY = moveRangeIndicator.scaleX = 2;
					moveRangeIndicator.x = hexagon.x;
					moveRangeIndicator.y = hexagon.y;
					addChild(moveRangeIndicator);
					var moveRange : Array = map['hitTest'](moveRangeIndicator);
					showMapCell(moveRange);
					showInAttackRangeEnemies(selectedPawn);
				}
			}
			else if (selectedPawn != null)
			{
				useRageAttack = false;
				selectedPawn.addEventListener('arrival', function() : void
				{
					selectedPawn.removeEventListener('arrival', arguments.callee);
					var inRange : Array = showInAttackRangeEnemies(selectedPawn);
					if (inRange.length == 0)
						next();
				});
				mapCellUnder(selectedPawn).color = 'blue';
				selectedPawn.moveTo(hexagon);
				hideAllMapCell();
			}
		}

		private function showInAttackRangeEnemies(target : Pawn) : Array
		{
			var attackRange : AttackRange1 = new AttackRange1();
			attackRange.x = target.x;
			attackRange.y = target.y;

			var inAttackRange : Array = map['hitTest'](attackRange).filter(function(hexagon : Hexagon, ... rest) : Boolean
			{
				for each (var pawn : Pawn in pawns)
				{
					if (pawn.alliance != target.alliance && pawn.x == hexagon.x && pawn.y == hexagon.y)
					{
						return true;
					}
				}
				return false;
			});
			if (inAttackRange.length)
			{
				inAttackRange.map(function(hexagon : Hexagon, ... rest) : void
				{
					hexagon.color = 'yello';
				});
				showMapCell(inAttackRange);
			}
			return inAttackRange;
		}

		private function mapCellUnder(pawn : Pawn) : Hexagon
		{
			return ArrayUtils.selectOne(map['mapCells'], function(cell : Hexagon) : Boolean
			{
				return pawn.x == cell.x && pawn.y == cell.y
			});
		}

		private function next() : void
		{
			selectedPawn = null;
			showAllMapCell();
			if (--actionPoints == 0)
			{
				teams.push(teams.shift());
				roundStart(teams[0]);
			}
		}

		private function hideAllMapCell() : void
		{
			SpriteUtils.forEachChild(map, function(child : Hexagon) : void
			{
				child.visible = false;
			});
		}

		private function showAllMapCell() : void
		{
			SpriteUtils.forEachChild(map, function(child : Hexagon) : void
			{
				child.visible = true;
			});
		}

		private function showMapCell(cells : Array) : void
		{
			cells.map(function(hexagon : Hexagon, ... rest) : void
			{
				hexagon.visible = true;
			});
		}
	}
}
