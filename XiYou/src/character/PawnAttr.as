package character
{
	import flash.utils.getDefinitionByName;

	import global.Global;

	import interfaces.IRushCombatant;

	/**
	 *
	 * @author Chenzhe
	 */
	public class PawnAttr
	{
		public static var factor_STR_AD : Number = 0.7;
		public static var factor_STR_NearDMG : Number = 1.5;
		public static var factor_STR_NearDEF : Number = 1.5;
		public static var factor_DEX_AD : Number = 0.3;
		public static var factor_DEX_RangeDMG : Number = 1;
		public static var factor_DEX_RangeDEF : Number = 1;
		public static var factor_INT_MP : Number = 15;
		public static var factor_INT_AP : Number = 1;
		public static var factor_INT_APDEF : Number = 1;
		public static var factor_VIT_HP : Number = 15;
		public static var factor_VIT_ADDEF : Number = 1;
		/**
		 *
		 * @default
		 */
		public var id : String;
		/**
		 * RANK等级
		 * @default
		 */
		public var rank : int;
		/**
		 * 角色名称
		 * @default
		 */
		public var name : String;
		private var _projectileClass : Class;
		private var _uiClass : Class;
		private var _level : int = 1;
		// 四属性标准值
		/**
		 * 力量标准值
		 * @default
		 */
		public var basicSTR : int = 12;
		/**
		 * 敏捷标准值
		 * @default
		 */
		public var basicDEX : int = 8;
		/**
		 * 智力标准值
		 * @default
		 */
		public var basicINT : int = 8;
		/**
		 * 体质标准值
		 * @default
		 */
		public var basicVIT : Number = 12;
		// 潜力值
		public var potentialMax : Number = 4;
		public var potentialMin : Number = 8;
		// 潜力值-获得值
		private var _potentialGain : int = -1;
		// 力成长比
		public var STRGrowPercent : Number = .3;
		// 敏成长比
		public var DEXGrowPercent : Number = .4;
		// 智成长比
		public var INTGrowPercent : Number = .2;
		// 体成长比
		public var VITGrowPercent : Number = .3;
		// 近防修正系数
		public var closeDefCorrect : Number;
		// 远防修正系数
		public var rangeDefCorrect : Number;
		// 魔防修正系数
		public var APDefCorrect : Number;
		// 物防修正系数
		public var ADDefCorrect : Number;

		// 力量-初始值		F（初始力量）=标准力量+潜力获得值*力量成长比例
		public function get initSTR() : Number
		{
			return basicSTR + potentialGain * STRGrowPercent;
		}

		// 敏捷-初始值		F（初始敏捷）=标准敏捷+潜力获得值*敏捷成长比例
		public function get initDEX() : Number
		{
			return basicDEX + potentialGain * DEXGrowPercent;
		}

		// 智力-初始值
		// 体质-初始值
		// 力量-当前值		F（当前力量）=初始力量+潜力获得值*(当前角色等级-1)*力量成长比例
		public function get STR() : Number
		{
			return initSTR + potentialGain * (level - 1) * STRGrowPercent;
		}

		// 敏捷-当前值		F（当前敏捷）=初始敏捷+潜力获得值*(当前角色等级-1)*敏捷成长比例
		public function get DEX() : Number
		{
			return initDEX + potentialGain * (level - 1) * DEXGrowPercent;
		}

		// 智力-当前值
		// 体质-当前值		F（当前体质）=初始体质+潜力获得值*(当前角色等级-1)*体质成长比例
		public function get VIT() : Number
		{
			return basicVIT + potentialGain * (level - 1) * VITGrowPercent;
		}

		// RANK等级
		// 移动速度
		private var _speed : Number = 8;
		// HP
		private var _HP : Number = NaN;
		// MP
		public var MP : Number = 100;
		// 物理攻击加成
		public var ADAmp : Number = 0;
		// 魔法攻击加成
		public var APAmp : Number = 0;
		// 远程攻击加成	F（远程攻击加成）=远程攻击加成+技能加成
		public var rangeDamageAmp : Number = 0;
		// 近身攻击加成
		public var closeCombatAmp : Number = 0;
		// 物理防御加成
		// 魔法防御加成
		// 远程防御加成
		// 近身防御加成
		// 额外伤害减免
		// 额外伤害
		// 物理攻击
		public var ADDamage : Number;
		// 魔法攻击
		public var APDamage : Number;

		/**
		 * 远程攻击 	F(远程攻击)=（F（当前敏捷）*敏捷远程攻击系数）*（1+远程攻击加成）
		 */
		private function get rangeDamage() : Number
		{
			return (DEX * factor_DEX_RangeDMG) * (1 + rangeDamageAmp);
		}

		/**
		 * F(物理攻击)=（F（当前力量）*力量物理攻击系数+F（当前敏捷）*敏捷物理攻击系数）*（1+物理攻击加成）
		 */
		private function get AD_DMG() : Number
		{
			return (STR * factor_STR_AD + DEX * factor_DEX_AD) * (1 + ADAmp);
		}

		/**
		 * F(近身攻击)=（F（当前力量）*力量近身攻击系数）*（1+近身攻击加成）
		 */
		private function get nearCombatDamage() : Number
		{
			return STR * factor_STR_NearDMG * (1 + closeCombatAmp);
		}

		/**
		 * F伤害普攻单次 = Int(（己方F(类型攻击)*对方类型防御修正*（1-F(类型防御)/（防御基准系数+F(类型防御)））+（己方F(距离攻击)*对方距离防御修正*(1-对方F(距离防御)/(防御基准系数+F(距离防御)))))*额外伤害减免+额外伤害
		 */
		public function getDamage(targetAttr : PawnAttr) : Number
		{
			var dmg : Number;
			if (combatType == 'range')
			{
				dmg = (AD_DMG * targetAttr.ADDefCorrect) + (rangeDamage * targetAttr.rangeDefCorrect);
			}
			else
			{
				dmg = (AD_DMG * targetAttr.ADDefCorrect) + (nearCombatDamage * targetAttr.closeDefCorrect);
			}
			return dmg;
		}

		/**
		 * F（当前体质）*HP换算系数0
		 */
		public function get fullHP() : Number
		{
			return VIT * factor_VIT_HP;
		}

		public function get HP() : Number
		{
			if (isNaN(_HP))
			{
				_HP = fullHP;
			}
			return _HP;
		}

		public function set HP(value : Number) : void
		{
			if (value <= 0)
			{
				_HP = value = 0;
			}
			else
			{
				_HP = value;
			}
		}

		public function get potentialGain() : int
		{
			if (_potentialGain < 0)
			{
				_potentialGain = Math.random() * (potentialMax - potentialMin) + potentialMin;
				log(name, '\t潜力获得值:', _potentialGain);
			}
			return _potentialGain;
		}

		/**
		 *
		 * @default
		 */
		public function get level() : int
		{
			return _level;
		}

		/**
		 * @private
		 */
		public function set level(value : int) : void
		{
			_level = value;
		}

		public function get uiClass() : Class
		{
			return _uiClass;
		}

		public function set uiClass(value : *) : void
		{
			_uiClass = Class(value is Class ? value : getDefinitionByName(value));
		}

		public function get speed() : Number
		{
			return _speed * Global.speedFactor;
		}

		public function set speed(value : Number) : void
		{
			_speed = value;
		}

		// 物理防御
		public var ADDEF : Number;
		// 魔法防御
		public var APDEF : Number;
		// 远程防御
		// 近身防御
		// 近防修正系数
		// 远防修正系数
		// 魔防修正系数
		// 物防修正系数
		// AI模式
		// 攻击类型
		// 攻击距离
		public var attackRange : Number = 70;
		// 发射间隔
		public var fireDuration : Number = 1000;
		// 弹药类型	0为箭矢，1为魔法球
		public var projectleType : int = 0;
		// 弹药飞行速度
		public var projectileSpeed : Number = 20;
		public var combatType : String = 'close';
		public var jumpAttack : Boolean = false;

		/**
		 *
		 */
		public function PawnAttr()
		{
		}

		public function get projectileClass() : Class
		{
			return _projectileClass;
		}

		public function set projectileClass(value : *) : void
		{
			this._projectileClass = Class(value is Class ? value : getDefinitionByName(value));
			;
		}
	}
}

