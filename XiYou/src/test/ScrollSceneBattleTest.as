package test
{
	import module.HPBar;
	import module.RageModule;
	import module.effect.ScatEffect;
	import module.effect.PawnHitEffect;
	import module.effect.KnockbackEffect;

	import air.update.logging.Level;

	import flash.display.StageQuality;
	import flash.utils.getDefinitionByName;

	import battle.ZhiZhuJing;

	import module.ZhiZhuJingAttackModule;
	import module.AttackModule;

	import character.ComplexPawn;
	import character.Pawn;
	import character.PawnEvent;

	import module.PlayerAttackModule;
	import module.RageEffectView;
	import module.combat.TeamTurnBattle;

	import sound.EmbededSound;
	import sound.SoundResource;

	import ui_scrollBattlePanel.btn_moveForward;
	import ui_scrollBattlePanel.btn_return;

	import utils.ArrayUtils;
	import utils.EventUtils;
	import utils.SpriteUtils;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.SoundChannel;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	/**
	 * @author Chenzhe
	 */
	[SWF(backgroundColor = "#FFFFFF", frameRate = "24", width = "1024", height = "768")]
	public class ScrollSceneBattleTest extends Sprite
	{
		private var bg : ScrollBackGround;
		private var players : Array = [];
		private var pawnLayer : Sprite = new Sprite();
		private var sceneObjects : Array = [];
		private var timeout_pauseMove : uint;
		private var scatlayer : Sprite = new Sprite();
		private var effectLayer : RageEffectView;
		private var snd : SoundChannel;

		public function ScrollSceneBattleTest()
		{
			CONFIG::DEBUG
			{
				start(['14', '11', '20', '19']);
				// '14', '11', '20', '19'
				addChild(new Stats());
				var _this : ScrollSceneBattleTest = this;
				EventUtils.careOnce(this, Event.COMPLETE, function() : void
				{
					SpriteUtils.safeRemove(_this);
				});
			}
		}

		private function dispose(event : Event) : void
		{
			players.length = 0;
			sceneObjects.length = 0;
			pawnLayer.removeChildren();
			scatlayer.removeChildren();
			effectLayer.removeChildren();
			removeChildren();
			pawnLayer = null;
			scatlayer = null;
			effectLayer = null;
		}

		private function pauseMove(... args) : void
		{
			players.map(function(player : Pawn, ... rest) : void
			{
				player.playDefault();
			});
			bg.pause();
		}

		public function start(team : Array, ... rest) : void
		{
			initUI();
			players = [];
			var playerPos : Array = [[423 - 50, 512], [429 - 50, 394], [340 - 50, 451], [262 - 50, 537], [295 - 50, 392], [184 - 50, 457]];
			for each (var id : String in team)
			{
				var player : ComplexPawn = new ComplexPawn(id, 1.5, 30);
				var pos : Array = playerPos.shift();
				player.x = pos[0];
				player.y = pos[1];
				player.speed = 600;
				player.alliance = 'Player';
				player.extra.rage = new RageModule(player);
				player.extra.attack = new PlayerAttackModule(player, players, effectLayer);
				new ScatEffect(player, scatlayer);
				new PawnHitEffect(player);
				new PawnSoundEffect(player);
				new KnockbackEffect(player);
				player.extra.hpBar = new HPBar(player);
				player.addChild(player.extra.hpBar);
				players.push(player);
				player.turnRight();
				pawnLayer.addChild(player);
			}
			SpriteUtils.zSort(pawnLayer);
			players.forEach(function(player : Pawn, ... rest) : void
			{
				player.setFrameHandler('walk', -1, function() : void
				{
					player.play(['walk']);
				});
			});

			sceneObjects = [];
			initSceneObjects();
			sceneObjects.sortOn('x', Array.NUMERIC);
			var hpBtn : HPUpButton = new HPUpButton(players);
			hpBtn.x = 40;
			hpBtn.y = 80;
			addChild(hpBtn);
			snd = EmbededSound.play(SoundResource.instance.bg_battle, 9999);
		}

		private function initUI() : void
		{
			bg = new ScrollBackGround(new bg_panSiDong);
			addChild(bg);

			addChild(pawnLayer);
			addChild(scatlayer);

			var panel : ui_scrollBattlePanel = new ui_scrollBattlePanel();
			panel.cacheAsBitmap = true;
			panel.y = 19;
			addChild(panel);

			effectLayer = new RageEffectView();
			addChild(effectLayer);
			function moveShortRange(... args) : void
			{
				clearTimeout(timeout_pauseMove);
				if (bg.paused)
				{
					continueMove();
					timeout_pauseMove = setTimeout(pauseMove, 5000);
				}
			}
			EventUtils.careOnce(this, Event.REMOVED_FROM_STAGE, dispose);
			var stoped : Boolean = false;
			var _this : ScrollSceneBattleTest = this;
			var bat : TeamTurnBattle = new TeamTurnBattle();
			bg.onUpdate = function() : void
			{
				var dist : Number = bg.x + sceneObjects[0].x;
				if (dist < 10)
				{
					pauseMove();
					stoped = true;
					var obj : * = sceneObjects.shift();
					if (obj is Level)
					{
						clearTimeout(timeout_pauseMove);
						setTimeout(function() : void
						{
							switch((obj as Level).type)
							{
								case 'battle':
									// TODO
									// EmbededSound.play(SoundResource.instance.battle_start);
									var enemies : Array = (obj as Level).pawns;
									for each (var enemy : Pawn in enemies)
									{
										var gPos : Point = enemy.localToGlobal(new Point());
										enemy.x = gPos.x;
										enemy.y = gPos.y;
										pawnLayer.addChild(enemy);
									}
									bat.startRound(players, enemies, pawnLayer, effectLayer, function() : void
									{
										if (sceneObjects.length)
										{
											setTimeout(function() : void
											{
												stoped = false;
											}, 100);
										}
										else
										{
											snd.stop();
											dispatchEvent(new Event(Event.COMPLETE));
										}
									}, function() : void
									{
										snd.stop();
										dispatchEvent(new Event(Event.COMPLETE));
									});
									break;
								case 'chest':
									var hint : ChestHint = new ChestHint();
									addChild(hint);
									var chest : AdvanceMC = (obj as Level).chest;
									chest.addEventListener('chest', function(evt : ChestEvent) : void
									{
										panel.tf_sliver.text = String(int(panel.tf_sliver.text) + evt.money);
										setTimeout(function() : void
										{
											stoped = false;
											SpriteUtils.safeRemove(hint);
											SpriteUtils.safeRemove(chest);
										}, 500);
									});
									chest.play();
									EmbededSound.play(SoundResource.instance.chest_open);
									break;
								default:
							}
						}, 500);
					}
				}
				else if (dist < 1024)
				{
					if (sceneObjects[0] is Level)
						bg.addChild(sceneObjects[0]);
				}
			};
			addEventListener(PawnEvent.DEAD, onPawnDead, true);
			addEventListener(PawnEvent.DISPOSE, onPawnDispose, true);
			addEventListener(MouseEvent.MOUSE_DOWN, function(evt : Event) : void
			{
				switch(evt.target.constructor)
				{
					case ui_scrollBattlePanel.btn_moveForward:
						if (!stoped)
							moveShortRange();
						break;
					case ui_scrollBattlePanel.btn_return:
						snd.stop();
						dispatchEvent(new Event(Event.COMPLETE));
						break;
					default:
				}
			});
		}

		private function initSceneObjects() : void
		{
			var _x : int = 500;

			var objects : Array = 
			// ------------------------------- 
			//[{type:'chest', objects:[{money:50, exp:200}]}, {type:'battle', objects:[{id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}]},
			// {type:'battle', objects:[{id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}]}, 
			[{type:'battle', objects:[{id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}]},
			// {type:'battle', objects:[{id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}]}, 
			{type:'battle', objects:[{id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, null, {id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}]},
			// {type:'battle', objects:[{id:'5', scale:1.2, lv:5}, null, {id:'5', scale:1.2, lv:5}, null, {id:'5', scale:1.2, lv:5}]}, 
			{type:'battle', objects:[{id:'4', scale:1.2, lv:5}, null, {id:'4', scale:1.2, lv:5}, null, {id:'4', scale:1.2, lv:5}, {id:'4', scale:1.2, lv:5}, null, {id:'4', scale:1.2, lv:5}]}, 
			//
			{type:'battle', objects:[{id:'5', scale:1.2, lv:5}, {id:'5', scale:1.2, lv:5}, null, null, {id:'3', scale:1.2, lv:5}, {id:'3', scale:1.2, lv:5}]}, 
			//
			{type:'battle', objects:[{id:'62', scale:1.2, lv:70, offset:new Point(0, -100), isBoss:true}]}];
			// -------------------
			// [{type:'battle', objects:[{id:'62', scale:1.2, lv:70, offset:new Point(0, -100), isBoss:true}]}];
			// [{type:'chest', objects:[{money:50, exp:200}]}, {type:'battle', objects:[{id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}]}, {type:'battle', objects:[{id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}]}, {type:'battle', objects:[{id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}]}, {type:'battle', objects:[{id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}]}, {type:'battle', objects:[{id:'2', scale:1}, {id:'2', scale:1}, {id:'2', scale:1}, null, {id:'0', scale:1}, {id:'0', scale:1}, {id:'0', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}, {id:'1', scale:1}]}, {type:'battle', objects:[{id:'5', scale:1.2, lv:5}, null, {id:'5', scale:1.2, lv:5}, null, {id:'5', scale:1.2, lv:5}]}, {type:'battle', objects:[{id:'4', scale:1.2, lv:5}, null, {id:'4', scale:1.2, lv:5}, null, {id:'4', scale:1.2, lv:5}, {id:'4', scale:1.2, lv:5}, null, {id:'4', scale:1.2, lv:5}]}, {type:'battle', objects:[{id:'5', scale:1.2, lv:5}, {id:'5', scale:1.2, lv:5}, null, null, {id:'3', scale:1.2, lv:5}, {id:'3', scale:1.2, lv:5}]}, {type:'battle', objects:[{id:'18', scale:2.2, lv:40}]}];

			for each (var objectsInfo : * in objects)
			{
				var level : Level;
				switch(objectsInfo.type)
				{
					case 'battle':
						level = new Level(objectsInfo.objects.map(function(enemyInfo : *, ... rest) : Pawn
						{
							if (enemyInfo == null)
								return null;
							trace('offset: ' + (enemyInfo.offset));
							var enemy : ComplexPawn = new ComplexPawn(enemyInfo.id, enemyInfo.scale, enemyInfo.lv ? enemyInfo.lv : 1, enemyInfo.offset, enemyInfo.isBoss ? new <String>['stand', 'hurt'] : null);
							enemy.speed = 600;
							enemy.alliance = 'Enemy';
							// XXX boss战测试
							var dic_atkMod : Object = {ZhiZhuJing:ZhiZhuJingAttackModule};
							var atkModule : AttackModule = dic_atkMod[enemy.name] ? new dic_atkMod[enemy.name](enemy) : new AttackModule(enemy);
							if (atkModule.hasOwnProperty('players'))
								atkModule['players'] = players;

							enemy.extra.attack = atkModule;
							enemy.extra.hpBar = new HPBar(enemy, 0x355EFF);
							enemy.addChild(enemy.extra.hpBar);
							new ScatEffect(enemy, scatlayer);
							new PawnHitEffect(enemy);
							new PawnSoundEffect(enemy);
							new KnockbackEffect(enemy);

							return enemy;
						}));
						break;
					case 'chest':
						var chest : Chest = new Chest(objectsInfo.objects[0].money, objectsInfo.objects[0].exp);
						level = new Level([chest], 'chest');
						break;
					default:
				}
				level.x = _x;
				_x += 1024;
				sceneObjects.push(level);
				// bg.addChild(level);
			}
		}

		private function onPawnDispose(event : Event) : void
		{
			var pawn : Pawn = (event.target as Pawn);
			SpriteUtils.safeRemove(pawn);
		}

		private function onPawnDead(event : Event) : void
		{
			trace('死亡: ' + (event.target));
			var pawn : Pawn = (event.target as Pawn);
			ArrayUtils.remove(players, pawn);
			ArrayUtils.remove(sceneObjects, pawn);
		}

		private function continueMove(... args) : void
		{
			bg.resume();
			players.forEach(function(player : Pawn, ... rest) : void
			{
				player.setFrameHandler('walk', -1, function() : void
				{
					player.play(['walk']);
				});
				player.play(['walk']);
			});
		}
	}
}
import character.Pawn;
import character.PawnEvent;

import sound.EmbededSound;
import sound.SoundResource;

import test.AdvanceMC;

import utils.ArrayUtils;
import utils.EventUtils;
import utils.SpriteUtils;

import com.greensock.TweenMax;
import com.greensock.TweenNano;
import com.greensock.easing.Elastic;
import com.greensock.easing.Linear;
import com.greensock.easing.Sine;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.media.SoundChannel;
import flash.utils.setTimeout;

/**
 * @author Administrator
 */
class ScrollBackGround extends Sprite
{
	private var tween : TweenMax;
	public var onUpdate : Function;
	private var bm : Bitmap;

	public function ScrollBackGround(source : BitmapData)
	{
		var bmd : BitmapData = new BitmapData(2048, 768, false);
		bmd.copyPixels(source, new Rectangle(0, 0, 1024, 768), new Point(0, 0));
		bmd.copyPixels(source, new Rectangle(0, 0, 1024, 768), new Point(1024, 0));
		bmd.lock();
		bm = new Bitmap(bmd, 'auto', true);
		addChild(bm);
		tween = TweenMax.to(this, 2.5, {ease:Linear.easeNone, x:-1024, onUpdate:function() : void
		{
			if (onUpdate)
				onUpdate();
		}, onComplete:function() : void
		{
			bm.x += 1024;
			tween.updateTo({x:x - 1024}, true);
		}});
		tween.pause();
		EventUtils.careOnce(this, Event.REMOVED_FROM_STAGE, function() : void
		{
			bmd.dispose();
			tween = null;
			bm = null;
			removeChildren();
		});
	}

	public function resume() : void
	{
		tween.resume();
		bm.smoothing = false;
	}

	public function pause() : void
	{
		tween.pause();
		bm.smoothing = true;
	}

	public function get paused() : Boolean
	{
		return tween.paused;
	}
}
/**
 * @author Chenzhe
 */
class Level extends Sprite
{
	public var pawns : Array;
	public var chest : AdvanceMC;
	public var type : String;

	public function Level(objects : Array, type : String = 'battle')
	{
		this.type = type;
		if (type == 'battle')
		{
			var formation : Array = [new Point(693.55, 494.9), new Point(701.55, 448.9), new Point(705.55, 396.9), new Point(721.55, 527.85), new Point(770.45, 459.85), new Point(771.55, 419.9), new Point(790.45, 507.85), new Point(844.45, 458.9), new Point(849.45, 405.9), new Point(870.45, 510.9)];

			if (objects.length == 1)
			{
				objects[0].x = formation[4].x;
				objects[0].y = formation[4].y;
				addChild(objects[0]);
			}
			else
			{
				for (var i : * in objects)
				{
					var pawn : Pawn = objects[i];
					if (pawn)
					{
						pawn.x = formation[i].x;
						pawn.y = formation[i].y;
						addChild(pawn);
					}
				}
			}
			this.pawns = ArrayUtils.removeNull(objects.concat());
			SpriteUtils.zSort(this);
		}
		else if (type == 'chest')
		{
			chest = objects[0] as AdvanceMC;
			chest.x = 512;
			chest.y = 384;
			addChild(chest);
		}
	}
}
/**
 * @author Chenzhe
 */
class PawnSoundEffect
{
	private var rageStartSnd : SoundChannel;
	private var host : Pawn;

	public function PawnSoundEffect(host : Pawn)
	{
		this.host = host;
		host.addEventListener(PawnEvent.ATTACK_START, playSound);
		host.addEventListener(PawnEvent.RAGE_START, playSound);
		host.addEventListener(PawnEvent.RAGE_ATTACK, playSound);
		// host.addEventListener(PawnEvent.HURT, playSound);
		host.addEventListener(PawnEvent.DEAD, playSound);
		// host.addEventListener(PawnEvent.RAGE_START_COMPLETE, function() : void
		// {
		// rageStartSnd.stop();
		// });
	}

	private function playSound(evt : PawnEvent) : void
	{
		switch(evt.type)
		{
			// case PawnEvent.HURT:
			// EmbededSound.play(host.alliance == 'Player' ? SoundResource.instance.hurt : SoundResource.instance.enemy_hurt);
			// break;
			// case PawnEvent.DEAD:
			// EmbededSound.play(SoundResource.instance.dead);
			// break;
			case PawnEvent.RAGE_ATTACK:
			case PawnEvent.ATTACK_START:
				trace('host: ' + (host));
				if (host.alliance == 'Player')
				{
					EmbededSound.play(SoundResource.instance.player_attack);
				}
				else
					EmbededSound.play(SoundResource.instance.enemy_attack);
				break;
			// case PawnEvent.RAGE_ATTACK:
			// switch(host.name) {
			// case "ZhuBaJie":
			// EmbededSound.play(SoundResource.instance.zhubajie_rage_attack);
			// break;
			// default:
			// EmbededSound.play(SoundResource.instance.attack);
			// }
			// break;
			case PawnEvent.RAGE_START:
				rageStartSnd = EmbededSound.play(SoundResource.instance.rage_start);
				break;
			default:
		}
	}
}
/**
 * @author Chenzhe
 */
class HPUpButton extends Sprite
{
	private var times : Number = 10;

	public function HPUpButton(players : Array)
	{
		addChild(new btn_HP_up());
		addEventListener(MouseEvent.MOUSE_DOWN, function() : void
		{
			if (times > 0)
				for each (var player : Pawn in players)
				{
					if (player.HP > 0)
						player.HP += 100;
				}
		});
		times--;
	}
}
/**
 * @author Chenzhe
 */
class Chest extends AdvanceMC
{
	private var money : Number;
	private var exp : Number;

	public function Chest(money : Number, exp : Number)
	{
		this.exp = exp;
		this.money = money;
		super(new ui_Chest(), new <String>['all']);
		var dropSilver : AdvanceMC = new AdvanceMC(new ui_DropSilver(), new <String>['all'], 10);
		var dropExp : AdvanceMC = new AdvanceMC(new ui_DropExp(), new <String>['all'], 10);
		dropSilver.x = 140;
		dropSilver.y = 83;
		dropExp.x = 160;
		dropExp.y = 83;
		addFrameScript(20, function() : void
		{
			addChild(dropSilver);
			addChild(dropExp);
			dropSilver.play();
			dropExp.play();
		});

		var _this : Chest = this;
		addFrameScript(65, function() : void
		{
			EventUtils.careOnce(_this, MouseEvent.MOUSE_DOWN, function() : void
			{
				dispatchEvent(new ChestEvent('chest', money, exp));
			});
		});
	}
}
/**
 * @author Chenzhe
 */
class ChestEvent extends Event
{
	public var money : Number;
	public var exp : Number;

	public function ChestEvent(type : String, money : Number, exp : Number)
	{
		this.exp = exp;
		this.money = money;
		super(type);
	}
}