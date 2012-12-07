package charactersOld
{

	import character.FrameLabels;
	import character.PawnAttr;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import interfaces.ICombatant;




	/**
	 * 基础的战斗角色，能播放攻击动画，能够获取攻击动画的持续时间
	 * @author Chenzhe
	 */
	public class BasicCombatant extends Character implements ICombatant
	{
		public var attr : PawnAttr;

		protected var _fireDuration : Number = 700;

		public function BasicCombatant(attr : PawnAttr)
		{
			this.attr = attr;
			super(new (attr.uiClass) as MovieClip);
			drawShadow();
		}

		private function drawShadow() : void
		{
			// 脚底的阴影
			var w : Number = width * .2;
			var h : Number = w / 7;
			var shadow : Shape = new Shape();
			shadow.graphics.beginFill(0, .5);
			shadow.graphics.drawEllipse(0, 0, w, h);
			graphics.endFill();
			shadow.cacheAsBitmap = true;

//			var bmd : BitmapData = new BitmapData(w, h, true, 0);
//			bmd.draw(shadow);
//			bmd.lock();
//			var bm : Bitmap = new Bitmap(bmd);
//			bm.x = -w / 2;
//			bm.y = -h / 2;
//			bm.smoothing = true;
			addChildAt(shadow, 0);
		}

		override public function get HP() : Number
		{
			return attr.HP;
		}

		override public function set HP(val : Number) : void
		{
			attr.HP = val;
		}

		override public function get name() : String
		{
			return attr.name;
		}

		override public function set name(value : String) : void
		{
			attr.name = value;
			super.name = value;
		}

		public function get attackRange() : Number
		{
			return attr.attackRange;
		}

		public function set attackRange(val : Number) : void
		{
			attr.attackRange = val;
		}

		public function get fireDuration() : Number
		{
			return attr.fireDuration;
		}

		public function set fireDuration(val : Number) : void
		{
			attr.fireDuration = val;
		}

		/**
		 * 攻击动画的持续时间
		 */
		public function get fireAnimDuration() : Number
		{
			return anim.getAnimInfo(FrameLabels.ATTACK).duration;
		}

		override public function get speed() : Number
		{
			return attr.speed;
		}

		override public function set speed(val : Number) : void
		{
			attr.speed = val;
		}

		public function getDamage(targetAttr : PawnAttr) : Number
		{
			return attr.getDamage(targetAttr);
		}

		public function get isArcher() : Boolean
		{
			return attr.combatType == 'range';
		}

		public function get fullHP() : Number
		{
			return attr.fullHP;
		}

		public function get id() : String
		{
			return attr.id;
		}
	}
}
