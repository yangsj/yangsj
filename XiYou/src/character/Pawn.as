package character
{
	import global.Orientation;

	import flash.utils.setTimeout;

	import utils.SpriteUtils;

	import com.greensock.TweenNano;

	import flash.geom.Point;

	import test.AdvanceMC;

	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;

	import module.HPBar;

	import utils.MathUtils;

	/**
	 * @author jamtype7
	 */
	[Event(name = "attack_complete", type = "character.PawnEvent")]
	[Event(name = "HURT", type = "character.PawnEvent")]
	[Event(name = "arrival", type = "character.PawnEvent")]
	[Event(name = "dispose", type = "character.PawnEvent")]
	[Event(name = "rage_start_complete", type = "character.PawnEvent")]
	[Event(name = "ATTACK_START", type = "character.PawnEvent")]
	public class Pawn extends Sprite
	{
		public var creatTime : int;
		public var alliance : String;
		public var mc : AdvanceMC;
		public var defaultFrame : String = 'stand';
		private var anim : TweenLite;
		private var destination : *;
		private var movement : TweenMax;
		protected var _speed : Number = 200;
		protected var _damage : Number = 25;
		private var _HP : Number = 100;
		private var _fullHP : Number = 100;
		public var projectile : MovieClip;
		public var extra : Object = {};
		private var frameParser : FrameInfoParser;
		private var jump : TweenMax;
		private var projectileFlight : TweenLite;
		public var freezed : Boolean;

		// public var hpBar : HPBar;
		public function Pawn(mc : AdvanceMC)
		{
			creatTime = getTimer();
			this.mc = mc;
			frameParser = mc.frameParser;
			this.name = getQualifiedClassName(mc.mc).split('::').pop();
			addChild(new Shadow());
			addChild(mc);
			trace('mc.y: ' + (mc.y));
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		protected function onAddedToStage(event : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			playDefault();
			// hpBar = new HPBar(this);
			//
			// addChild(hpBar);
		}

		public function setFrameHandler(frameName : String, pos : int, func : Function) : void
		{
			var info : FrameInfo = getFrameInfo(frameName);
			if (info == null) return;
			var end : int = info.end;
			if (pos < 0)
				pos = end + pos;
			else
				pos = info.start + pos - 2;
			if (pos > end)
				pos = end;
			mc.addFrameScript(pos, func);
		}

		private function getFrameInfo(frameName : String) : FrameInfo
		{
			var info : FrameInfo = frameParser.getFrameInfo(frameName);
			// if (info == null)
			// throw name + '没有帧' + frameName;
			return info;
		}

		public function playDefault() : void
		{
			if (anim)
				anim.kill();
			if (defaultFrame == null) return;
			var info : FrameInfo = getFrameInfo(defaultFrame);
			if (info == null) return;
			mc.gotoAndStop(info.start);
			anim = TweenLite.to(mc, info.end - info.start - 1, {useFrames:true, ease:Linear.easeNone, onUpdate:mc.nextFrame, onComplete:playDefault});
		}

		public function play(frames : Array) : void
		{
			if (anim)
				anim.kill();
			var frame : String = frames.shift();
			if ((currentLabel == 's_start' && frame == 'hurt'))
				return;
			var info : FrameInfo = getFrameInfo(frame);
			if (info == null)
			{
				trace(mc, '没有帧：', frame);
				playDefault();
				return;
			}
			mc.gotoAndStop(info.start);
			anim = TweenLite.to(mc, info.end - info.start, {useFrames:true, ease:Linear.easeNone, onComplete:function() : void
			{
				if (frames.length)
					play(frames);
				else
					playDefault();
			}, onUpdate:mc.nextFrame});
		}

		public function stopAnim() : void
		{
			if (anim)
				anim.kill();
		}
//, 
		public function moveTo(destination : *, onComplete : Function = null,onUpdate : Function = null) : void
		{
			if (freezed) return;
			this.destination = destination;
			if (movement)
				movement.kill();
			setFrameHandler(FrameLabels.WALK, -1, function() : void
			{
				play([FrameLabels.WALK]);
			});
			play([FrameLabels.WALK]);
//			var _x : Number = x;
//			var _y : Number = y;
			movement = TweenMax.to(this, 999, {ease:Linear.easeNone, onUpdate:function() : void
			{
//				if (x != destination.x)
//					_x = x;
				turnTo(destination.x);
				var distance : Number = MathUtils.distance(x, y, destination.x, destination.y);
				// if (distance < 1)
				// {
				// movement.complete();
				// return;
				// }
				movement.duration = distance / speed;
				movement.updateTo({x:destination.x, y:destination.y}, true);
				if (onUpdate != null)
					onUpdate();
			}, onComplete:function() : void
			{
//				_x > destination.x ? turnLeft() : turnRight();
				setFrameHandler(FrameLabels.WALK, -1, null);
				playDefault();
				if (onComplete != null)
					onComplete();
				dispatchEvent(new PawnEvent(PawnEvent.ARRIVAL));
				// trace('this: ' + (name), 'ARRIVAL.');
			}});
		}

		public function jumpTo(_x : Number, _y : Number, height : Number) : void
		{
			if (freezed) return;
			var dummy : Object = {h:0};
			var _me : Pawn = this;
			play([FrameLabels.WALK]);
			stopAnim();
			jump = TweenMax.to(dummy, .3, {h:-height, repeat:1, yoyo:true});
			movement = TweenMax.to(_me, .6, {ease:Linear.easeNone, x:_x, y:_y, onComplete:function() : void
			{
				dispatchEvent(new PawnEvent(PawnEvent.ARRIVAL));
			}, onUpdate:function() : void
			{
				_me.y += dummy.h;
			}});
		}

		private function targetHurt(target : Pawn, dmgAmp : Number) : Number
		{
			var dmg : Number;
			if (target.HP > 0)
			{
				dmg = damageCalc(target) * dmgAmp;
				target.hurt(dmg);
			}
			return dmg;
		}

		public function attack(targets : Array, isRageAttack : Boolean = false, dmgAmp : Number = 1, frame : String = null, atkOnFrame : int = 6) : void
		{
			if (freezed) return;
			if (targets[0].stage)
				turnTo(targets[0].localToGlobal(new Point()).x, true);
			var dmg : Number;
			frame ||= isRageAttack ? 's_attack' : 'attack';
			if (getFrameInfo(frame) == null || getFrameInfo(frame).length < atkOnFrame)
			{
				frame = 'attack';
				atkOnFrame = 6;
			}
			setFrameHandler(frame, atkOnFrame, function() : void
			{
				if (projectile == null)
				{
					for each (var target : Pawn in targets)
					{
						dmg = targetHurt(target, dmgAmp);
						dispatchEvent(new PawnEvent(PawnEvent.ATTACK, dmg));
						if (isRageAttack)
							dispatchEvent(new PawnEvent(PawnEvent.RAGE_ATTACK, dmg));
					}
				}
				else
				{
					shoot(targets, dmgAmp);
				}
			});
			if (projectile == null)
			{
				setFrameHandler(frame, -1, function() : void
				{
					dispatchEvent(new PawnEvent(PawnEvent.ATTACK_COMPLETE, dmg));
				});
			}
			play([frame]);
			dispatchEvent(new PawnEvent(PawnEvent.ATTACK_START));
		}

		private function shoot(targets : Array, dmgAmp : Number) : void
		{
			// TODO 远程现在只能攻击一个敌人
			var pos : Point = localToGlobal(new Point());
			var tPos : Point = targets[0].localToGlobal(new Point());
			var dif : Point = tPos.subtract(pos);
			projectile.x = x;
			projectile.y = y - 80;
			projectile.scaleX = mc.scaleX;
			parent.addChild(projectile);
			projectileFlight = TweenLite.to(projectile, .5, {ease:Linear.easeNone, x:x + dif.x, y:y + dif.y - 80, onComplete:function() : void
			{
				var dmg : Number = targetHurt(targets[0], dmgAmp);
				SpriteUtils.safeRemove(projectile);
				dispatchEvent(new PawnEvent(PawnEvent.ATTACK_COMPLETE, dmg));
			}});
		}

		// public function rageAttack(target : Pawn, dmgAmp : Number = 2.5) : void
		// {
		// turnTo(target.x);
		// var dmg : Number = 0;
		// var frame : String;
		// var iFrame_atk : int;
		//
		//			//  如果s_attack帧标签不足8帧，就用普通攻击的帧标签把吧=___,=
		// var s_atkAvailable : Boolean = false;
		// if (getFrameInfo(FrameLabels.S_ATTACK))
		// if (getFrameInfo(FrameLabels.S_ATTACK).length > 8)
		// s_atkAvailable = true;
		// if (s_atkAvailable)
		// {
		// frame = FrameLabels.S_ATTACK;
		// iFrame_atk = 8;
		// }
		// else
		// {
		// frame = FrameLabels.ATTACK;
		// iFrame_atk = 6;
		// }
		// setFrameHandler(frame, iFrame_atk, function() : void
		// {
		// if (target.HP > 0)
		// {
		// dmg = damageCalc(target) * dmgAmp;
		// if (projectile == null)
		// target.hurt(dmg);
		// else
		// shoot([target], dmgAmp);
		// }
		// dispatchEvent(new PawnEvent(PawnEvent.ATTACK, dmg));
		// dispatchEvent(new PawnEvent(PawnEvent.RAGE_ATTACK, dmg));
		// });
		// setFrameHandler(frame, -1, function() : void
		// {
		// dispatchEvent(new PawnEvent(PawnEvent.ATTACK_COMPLETE, dmg));
		// });
		// play([frame]);
		// }
		private function hurt(damage : Number) : void
		{
			if (HP <= 0) return;
			HP -= damage;
			trace(FrameLabels.HURT, damage, HP);
			if (HP <= 0)
			{
				HP = 0;
				dead();
			}
			else
				play([FrameLabels.HURT]);
			dispatchEvent(new PawnEvent(PawnEvent.HURT, damage, 0, HP, fullHP));
		}

		private function dead() : void
		{
			setFrameHandler(FrameLabels.DEAD, -1, dispose);
			play([FrameLabels.DEAD]);
			dispatchEvent(new PawnEvent(PawnEvent.DEAD));
		}

		private function dispose() : void
		{
			if (movement)
				movement.kill();
			stopAnim();
			dispatchEvent(new PawnEvent(PawnEvent.DISPOSE));
		}

		public function turnTo(_x : Number, isGlobal : Boolean = false) : void
		{
			_x < (isGlobal ? localToGlobal(new Point()).x : x) ? turnLeft() : turnRight();
		}

		public function stopMove() : void
		{
			if (movement)
				movement.kill();
			playDefault();
		}

		public function get speed() : Number
		{
			return _speed;
		}

		public function set speed(speed : Number) : void
		{
			this._speed = speed;
		}

		/**
		 * 向右转
		 */
		public function turnRight() : void
		{
			mc.scaleX = -1;
		}

		/**
		 * 向左转
		 */
		public function turnLeft() : void
		{
			mc.scaleX = 1;
		}

		public function get orientation() : int
		{
			return mc.scaleX;
		}

		public function get damage() : Number
		{
			return _damage;
		}

		override public function toString() : String
		{
			return "Play.Pawn - " + name + " | x: " + x + " | y: " + y;
		}

		public function rageStart(completeDelay : Number = 0) : void
		{
			if (getFrameInfo('s_start'))
			{
				setFrameHandler(FrameLabels.S_START, -1, function() : void
				{
					stopAnim();
					setTimeout(dispatchEvent, completeDelay, new PawnEvent(PawnEvent.RAGE_START_COMPLETE));
				});
				play([FrameLabels.S_START]);
			}
			else
				setTimeout(dispatchEvent, completeDelay, new PawnEvent(PawnEvent.RAGE_START_COMPLETE));
			dispatchEvent(new PawnEvent(PawnEvent.RAGE_START));
		}

		protected function damageCalc(target : Pawn) : Number
		{
			return damage;
		}

		public function set damage(damage : Number) : void
		{
			_damage = damage;
		}

		public function get HP() : Number
		{
			return _HP;
		}

		public function set HP(hP : Number) : void
		{
			_HP = hP;
			dispatchEvent(new PawnEvent(PawnEvent.HP_UPDATE, 0, 0, hP, fullHP));
		}

		public function get fullHP() : Number
		{
			return _fullHP;
		}

		public function set fullHP(fullHP : Number) : void
		{
			this._fullHP = fullHP;
		}

		public function get currentLabel() : String
		{
			return mc.currentLabel;
		}

		public function pause() : void
		{
			if (anim)
				anim.pause();
			if (movement)
				movement.pause();
			if (jump)
				jump.pause();
			if (projectileFlight)
				projectileFlight.pause();
			mc.stop();
		}

		public function resume() : void
		{
			if (anim)
				anim.resume();
			if (movement)
				movement.resume();
			if (jump)
				jump.resume();
			if (projectileFlight)
				projectileFlight.resume();
		}

		public function get isArcher() : Boolean
		{
			return projectile != null;
		}
	}
}
