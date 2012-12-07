package global
{
	import battle.ZhiZhuJing;
	import rage.TangSanZang;
	import rage.MoLiSou;
	import rage.MoLiQing;
	import rage.MoLiHong;
	import rage.MoLiHai;
	import rage.TuoTaLiTianWang;
	import rage.TieShanGongZhu;
	import rage.TaiShangLaoJun;
	import rage.RedBoy;
	import rage.HuangShiJing;
	import rage.BaiGuFuRen;
	import rage.SaShen;

	import battle.BaiGuFuRen;
	import battle.BaiGuFuRenFly;
	import battle.BullKing;
	import battle.ErLangShen;
	import battle.HongHaiiHuoFly;
	import battle.HuangShiJing;
	import battle.JingXiLingLi;
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
	import battle.XiaoGongShou;
	import battle.XiaoGongShouFly;
	import battle.XiaoQiBing;
	import battle.ZhuBaJie;
	
	import rage.ErLangShen;
	import rage.ShanShen;
	import rage.SunWuKong;
	import rage.ZhuBaJie;

	import flash.desktop.NativeApplication;
	import flash.display.Stage;
	
	import rage.ErLangShen;
	import rage.ShanShen;
	import rage.SunWuKong;
	import rage.ZhuBaJie;
	
	import ui.role.ResourceRoleWholeBodyImage_10;
	import ui.role.ResourceRoleWholeBodyImage_11;
	import ui.role.ResourceRoleWholeBodyImage_12;
	import ui.role.ResourceRoleWholeBodyImage_13;


	/**
	 * 一些全局的常量值
	 */
	public class Global
	{
		/**
		 * 帧频
		 */
		public static var FPS : int = 24;

		public static var knockbackMin : int = 30;

		public static var knockbackMax : int = 200;

		public static var knockbackScale : int = 1000;

		public static var knockbackOnDead : int = 300;

		public static var speedFactor : Number = 24;

		/**
		 * 击退敌人的时间
		 * @default 500
		 */
		public static var knockbackTime : Number = 300;


		/** 设定的标准【宽度】（资源制作的标准尺寸） */
		public static var standardWidth : Number = 1024;

		/** 设定的标准【高度】（资源制作的标准尺寸） */
		public static var standardHeight : Number = 768;

		/**
		 * 用户id。需要在注册或这登陆后重新设定获取到的uid值
		 */
		public static var uid : String = "0";

		/**
		 * 是否区分平台资源
		 */
		public static var isDifferenceSwf : Boolean = false;

		/**
		 * 是否在device上运行应用程序
		 */
		public static var isOnDevice : Boolean = true;

		/**
		 * 是否允许全局使用对象池。  若使用可能会占用更多的内存
		 */
		public static var isUsePool : Boolean = false;

		/**
		 * 退出应用程序回调
		 */
		public static var exitApp : Function = NativeApplication.nativeApplication.exit;

		private static var _stage : Stage;

		private static var _isDebug : Boolean = true;

		private static var _deviceType : String = DeviceType.IPAD;

		private static var _stageWidth : Number = 1024;

		private static var _stageHeight : Number = 768;

		private static var _stageScale : Number = -1;


		//////////////  getters/setters /////////////////////////////////////////////////////////

		/**
		 * 设定的标准舞台需要放大到实际舞台大小的【系数】, 用于适应不同尺寸的显示缩放比例【系数】
		 */
		public static function get stageScale() : Number
		{
			if (_stageScale < 0)
			{
				var scalex : Number = _stageWidth / standardWidth;
				var scaley : Number = _stageHeight / standardHeight;
				_stageScale = Math.min(scalex, scaley);
			}
			return _stageScale;
		}

		/**
		 * 当前舞台的实际【宽度】
		 */
		public static function get stageWidth() : Number
		{
			return _stageWidth;
		}

		public static function set stageWidth(value : Number) : void
		{
			_stageWidth = value;
		}

		/**
		 * 当前舞台的实际【高度】
		 */
		public static function get stageHeight() : Number
		{
			return _stageHeight;
		}

		public static function set stageHeight(value : Number) : void
		{
			_stageHeight = value;
		}

		/**
		 * 发布应用程序运行的设备类型
		 */
		public static function get deviceType() : String
		{
			return _deviceType;
		}

		public static function set deviceType(value : String) : void
		{
			_deviceType = value;
			if (_stage)
			{
				setStandardSize(value);
			}
		}

		public static function setStandardSize($deviceType : String) : void
		{
			switch ($deviceType)
			{
				case DeviceType.IPAD:
//					standardWidth = 1024;
//					standardHeight = 768;
					stage.stageWidth = 1024;
					stage.stageHeight = 768;
					break;
				case DeviceType.IPHONE:
//					standardWidth = 960;
//					standardHeight = 640;
					stage.stageWidth = 960;
					stage.stageHeight = 640;
					break;
				case DeviceType.ANDROID:
					standardWidth = 1024;
					standardHeight = 768;
					stage.stageWidth = 800;
					stage.stageHeight = 480;
					break;
				default:
//					standardWidth = 1024;
//					standardHeight = 768;
					stage.stageWidth = 1024;
					stage.stageHeight = 768;
			}
		}

		public static function get stage() : Stage
		{
			return _stage;
		}

		public static function set stage(value : Stage) : void
		{
			_stage = value;
			if (_deviceType)
			{
				setStandardSize(_deviceType);
			}
		}

		public static function get isDebug() : Boolean
		{
			return _isDebug;
		}

		public static function set isDebug(value : Boolean) : void
		{
			_isDebug = value;
		}

		public static const FIGHTER_ATTACK_RANGE : Number = 70;

		public static var hurtDelay : Number = 250;

		private static const allResources : Function = function() : void
		{
			battle.MoHaiFly;
			battle.XiaoGongShouFly;
			battle.MoLiQingFly;
			battle.HongHaiiHuoFly;
			battle.BaiGuFuRenFly;
			battle.XiaoGongShou;
			battle.XiaoQiBing;
			battle.ShanShen;
			battle.MoLiQing;
			battle.MoLiHong;
			battle.MoLiSou;
			battle.MoLiHai;
			battle.JingXiLingLi;
			battle.XiaBin;
			battle.ZhuBaJie;
			battle.HuangShiJing;
			battle.SaShen;
			battle.TangSanZang;
			battle.RedBoy;
			battle.BullKing;
			battle.SunWuKong;
			battle.BaiGuFuRen;
			battle.ErLangShen;
			battle.TaiShangLaoJun;
			battle.TuoTaLiTianWang;
			battle.TieShanGongZhu;
			battle.TianBing;
			battle.ZhiZhuJing;
			
			rage.BaiGuFuRen;
			rage.ErLangShen;
			rage.HuangShiJing;
			rage.RedBoy;
			rage.SaShen;
			rage.ShanShen;
			rage.SunWuKong;
			rage.TangSanZang;
			rage.TaiShangLaoJun;
			rage.TieShanGongZhu;
			rage.TuoTaLiTianWang;
			rage.ZhuBaJie;
			rage.MoLiHai;
			rage.MoLiHong;
			rage.MoLiQing;
			rage.MoLiSou;
			
			// 人物全身形象资源
			ui.role.ResourceRoleWholeBodyImage_6;
			ui.role.ResourceRoleWholeBodyImage_7;
			ui.role.ResourceRoleWholeBodyImage_8;
			ui.role.ResourceRoleWholeBodyImage_9;
			ui.role.ResourceRoleWholeBodyImage_10;
			ui.role.ResourceRoleWholeBodyImage_11;
			ui.role.ResourceRoleWholeBodyImage_12;
			ui.role.ResourceRoleWholeBodyImage_13;
			ui.role.ResourceRoleWholeBodyImage_14;
			ui.role.ResourceRoleWholeBodyImage_15;
			ui.role.ResourceRoleWholeBodyImage_16;
			ui.role.ResourceRoleWholeBodyImage_17;
			ui.role.ResourceRoleWholeBodyImage_18;
			ui.role.ResourceRoleWholeBodyImage_19;
			ui.role.ResourceRoleWholeBodyImage_20;
			ui.role.ResourceRoleWholeBodyImage_21;
			

		};
	}
}
