package charactersOld
{

	import battle.BaiGuFuRen;
	import battle.BaiGuFuRenFly;
	import battle.BullKing;
	import battle.ErLangShen;
	import battle.HongHaiiHuoFly;
	import battle.MoHaiFly;
	import battle.MoLiHai;
	import battle.MoLiHong;
	import battle.MoLiQing;
	import battle.MoLiQingFly;
	import battle.MoLiSou;
	import battle.RedBoy;
	import battle.SaShen;
	import battle.ShanShen;
	import battle.SunWuKong;
	import battle.TaiShangLaoJun;
	import battle.TangSanZang;
	import battle.TianBing;
	import battle.TieShanGongZhu;
	import battle.TuoTaLiTianWang;
	import battle.XiaBin;
	import battle.ZhuBaJie;
	import character.FrameLabels;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import interfaces.IWalkImpl;
	import interfaces.IWalkable;
	import module.Action;
	import module.DeadAction;
	import module.FrameAnimationModule;
	import module.Rule;
	import module.StatManager;
	import module.Walk;








	/**
	 * 人物
	 * @author Chenzhe
	 */
	[Event(name = "DEAD", type = "charactersOld.CharacterEvent")]
	public class Character extends Sprite implements IWalkable, IWalkImpl
	{
		public var creatTime : int;

		public var mc : MovieClip;

		protected var _HP : Number = 100;

		protected var _speed : Number = 100;

		/**
		 * 角色的联盟
		 */
		public var alliance : String;

		// MODULES ----------------------------------------------
		/**
		 * 走路逻辑的模块
		 */
		public var walk : Walk;

		/**
		 * 解析帧动画的模块
		 */
		public var anim : FrameAnimationModule;

		// ---------------------------------------------- MODULES
		private var interval : uint;

		protected var _bDead : Boolean;

		private var basicSacleX : Number = 1;

		protected var stats : StatManager;


		public var deadAction : DeadAction;



		public function Character(mc : MovieClip)
		{
			this.mc = mc;
			addChild(mc);
			super();
			initModule();
			creatTime = getTimer();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		protected function onAddedToStage(event : Event) : void
		{

		}

		protected function onWalkUpdate() : void
		{
			dispatchEvent(new CharacterEvent(CharacterEvent.MOVING));
		}

		protected function initModule() : void
		{
			stats = new StatManager(this);
			stats.makeRules('walk', 'dead', Rule.KILL);
			stats.makeRules('walk', 'walk', Rule.KILL);
			stats.makeRules('walk', 'stand', Rule.WAIT);

			walk = new Walk(this);
			walk.onUpdate = onWalkUpdate;
			deadAction = new DeadAction(this);
			anim = new FrameAnimationModule(mc);

			walk.addEventListener(Event.COMPLETE, playStand);
			deadAction.addEventListener(Event.COMPLETE, dispose);
		}

		public function playStand(evt : Event = null) : void
		{
			play({frames: [FrameLabels.STAND]});
		}

		public function get HP() : Number
		{
			return _HP;
		}

		/**
		 * 人物的生命值，低于或等于0会死亡
		 */
		public function set HP(value : Number) : void
		{
			_HP = value;
			if (_HP <= 0)
			{
				_HP = 0;
				dead();
			}
		}

		// ANIM -------------------------------------------------
		public function play(info : *) : TweenMax
		{
			return anim.play(info);
		}

		public function pause() : int
		{
			return anim.pause();
		}

		/**
		 * 角色死亡
		 */
		public function dead() : void
		{
			requestAction(deadAction);
			dispatchEvent(new CharacterEvent(CharacterEvent.DEAD));
		}


		public function requestAction(act : Action) : void
		{
			stats.requestAction(act);
		}

		// ------------------------------------------------- ANIM

		/**
		 * 销毁人物，请将销毁资源的动作放在此处调用
		 */
		public function dispose(... args) : void
		{
			anim = null;
			clearInterval(interval);
			dispatchEvent(new CharacterEvent(CharacterEvent.DISPOSE));
		}

		/**
		 * 向右转
		 */
		public function turnRight() : void
		{
			mc.scaleX = -basicSacleX;
		}

		/**
		 * 向左转
		 */
		public function turnLeft() : void
		{
			mc.scaleX = basicSacleX;
		}

		/**
		 * 判断目标角色是不是敌人
		 */
		public function isEnemy(target : Character) : Boolean
		{
			return target.alliance != this.alliance;
		}

		/**
		 * 判断人物是否在移动
		 */
		public function get isMoving() : Boolean
		{
			return mc.currentLabel == FrameLabels.WALK;
		}

		public function turnTo(_x : Number) : void
		{
			walk.turnTo(_x);
		}

		public function moveToPos(_x : Number, _y : Number) : void
		{
			walk.destination = new Point(_x, _y);
			requestAction(walk);
		}

		public function get orientation() : int
		{
			return mc.scaleX * -1;
		}

		override public function toString() : String
		{
			return name + "\tHP: " + HP;
		}

		public function get speed() : Number
		{
			return _speed;
		}

		public function set speed(value : Number) : void
		{
			_speed = value;
		}

	}
}
