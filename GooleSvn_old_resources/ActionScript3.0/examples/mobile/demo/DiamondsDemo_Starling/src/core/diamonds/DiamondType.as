package core.diamonds
{

	public class DiamondType
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		/** 普通 */
		public static const generalEffectName:String	= "generalEffectName";
		/** 興奮（极速） */
		public static const excitingEffectName:String	= "excitingEffectName";
		/** 興奮（极速） */
		public static const stoneResourceName:String	= "stoneResourceName";
		/** 道具特效 */
		public static const usePropEffectName:String 	= "usePropEffectName";
		
		public static const CONTAINER_SCALE:Number = 1.1;
		
		
		/** 存储道具id */
		public static var   diamondPropArray:Array 		= [PropCrossBlue, PropHourglassGreen, PropSameColorPurple, PropMatrixRed, PropMatrixYellow, PropSameColorBlue, PropSameColorGreen, PropSameColorRed, PropSameColorYellow];
		
		/** 存储同色消除道具的几个id */
		public static const diamondPropSameColor:Array	= [PropSameColorPurple, PropSameColorBlue, PropSameColorGreen, PropSameColorRed, PropSameColorYellow];
		/** 存储钻石id */
		public static const diamondTypeArray:Array 		= [diamondBlue, diamondGreen, diamondPurple, diamondRed, diamondYellow];
		
		/** 卡片的行数  */
		public static const Rows:uint 	= 10;
		/** 卡片的列数  */
		public static const Cols:uint 	= 10;
		
		//  钻石颜色id
		/** diamond blue id */
		public static const diamondBlue:int				= 1;
		/** diamond Green id */
		public static const diamondGreen:int			= 2;
		/** diamond Purple id */
		public static const diamondPurple:int			= 3;
		/** diamond Red id */
		public static const diamondRed:int				= 4;
		/** diamond Yellow id */
		public static const diamondYellow:int			= 5;
		//  钻石颜色id
		
		/** 空白 */
		public static const statusBlank:int				= -2;
		/** 普通 */
		public static const statusDefault:int	 		= 0;
		/** 兴奋 */
		public static const statusExciting:int 			= -1;
		
		//  道具id
		/** 十字状消除 */
		public static const PropCrossBlue:int			= 10; 
		/** 沙漏（加时间 */
		public static const PropHourglassGreen:int		= 11;
		/** 消除所有 purple 颜色钻石道具（彩色炸弹 */
		public static const PropSameColorPurple:int		= 12;
		/** 5x5炸弹 */
		public static const PropMatrixRed:int			= 13;
		/** 3x3炸弹 */
		public static const PropMatrixYellow:int		= 14;
		/** 消除所有 blue 颜色钻石道具（彩色炸弹 */
		public static const PropSameColorBlue:int 		= 101;
		/** 消除所有 green 颜色钻石道具（彩色炸弹 */
		public static const PropSameColorGreen:int 		= 111;
		/** 消除所有 red 颜色钻石道具（彩色炸弹 */
		public static const PropSameColorRed:int 		= 131;
		/** 消除所有 yellow 颜色钻石道具（彩色炸弹 */
		public static const PropSameColorYellow:int 	= 141;
		//  道具id
		
		/** 能量槽产生道具时需要达到的最大数（附：问过龙涓，不随等级的变化而变化） */
		public static const ENERGY_MAX:int				= 50;
		/** yellow 1 */
		public static const ENERGY_YELLOW_RANGE:Number	= 50;
		/** blue 2 */
		public static const ENERGY_BLUE_RANGE:Number	= 60;
		/** red 3 */
		public static const ENERGY_RED_RANGE:Number		= 70;
		/** purple 4 */
		public static const ENERGY_PURPLE_RANGE:Number	= 80;
		/** green 5*/
		public static const ENERGY_GREEN_RANGE:Number	= 90;
		
		///////////////////// 资源 //////////////////////////////////////
		// 道具特效资源
		/** blue prop */
		public static const TYPE_RESOUCRE_DIAMONDS_EFFECT_BLUE1:String = "net.jt_tech.ui.effect.BlueEffectRes";
		/** green prop */
		public static const TYPE_RESOUCRE_DIAMONDS_EFFECT_GREEN2:String = "net.jt_tech.ui.effect.GreenEffectRes";
		/** purple same prop bomb */
		public static const TYPE_RESOUCRE_DIAMONDS_EFFECT_PURPLE3:String = "net.jt_tech.ui.effect.PurpleEffectRes";
		/** red prop */
		public static const TYPE_RESOUCRE_DIAMONDS_EFFECT_RED4:String = "net.jt_tech.ui.effect.RedEffectRes";
		/** yellow prop */
		public static const TYPE_RESOUCRE_DIAMONDS_EFFECT_YELLOW5:String = "net.jt_tech.ui.effect.YellowEffectRes";
		/** blue same color bomb */
		public static const TYPE_RESOUCRE_DIAMONDS_EFFECT_ANIMATE_BLUE:String = "net.jt_tech.ui.effect.BlueEffectResResAnimate";
		/** green same color bomb */
		public static const TYPE_RESOUCRE_DIAMONDS_EFFECT_ANIMATE_GREEN:String = "net.jt_tech.ui.effect.GreenEffectResResAnimate";
		/** red same color bomb */
		public static const TYPE_RESOUCRE_DIAMONDS_EFFECT_ANIMATE_RED:String = "net.jt_tech.ui.effect.RedEffectResResAnimate";
		/** yellow same color bomb */
		public static const TYPE_RESOUCRE_DIAMONDS_EFFECT_ANIMATE_YELLOW:String = "net.jt_tech.ui.effect.YellowEffectResResAnimate";
		// 道具特效资源
		
		// 钻石资源
		/** BlueDiamonds */
		public static const TYPE_RESOUCRE_DIAMONDS_BLUE1:String = "net.jt_tech.ui.diamonds.BlueDiamonds";
		/** GreenDiamonds */
		public static const TYPE_RESOUCRE_DIAMONDS_GREEN2:String = "net.jt_tech.ui.diamonds.GreenDiamonds";
		/** PurpleDiamonds */
		public static const TYPE_RESOUCRE_DIAMONDS_PURPLE3:String = "net.jt_tech.ui.diamonds.PurpleDiamonds";
		/** RedDiamonds */
		public static const TYPE_RESOUCRE_DIAMONDS_RED4:String = "net.jt_tech.ui.diamonds.RedDiamonds";
		/** YellowDiamonds */
		public static const TYPE_RESOUCRE_DIAMONDS_YELLOW5:String = "net.jt_tech.ui.diamonds.YellowDiamonds";
		// 钻石资源
		
		// 钻石资源 提示特效
		/** BlueDiamondsPrompt */
		public static const TYPE_RESOUCRE_DIAMONDS_PROMPT_BLUE1:String = "net.jt_tech.ui.diamondsprompt.BlueDiamondsPrompt";
		/** GreenDiamondsPrompt */
		public static const TYPE_RESOUCRE_DIAMONDS_PROMPT_GREEN2:String = "net.jt_tech.ui.diamondsprompt.GreenDiamondsPrompt";
		/** PurpleDiamondsPrompt */
		public static const TYPE_RESOUCRE_DIAMONDS_PROMPT_PURPLE3:String = "net.jt_tech.ui.diamondsprompt.PurpleDiamondsPrompt";
		/** RedDiamondsPrompt */
		public static const TYPE_RESOUCRE_DIAMONDS_PROMPT_RED4:String = "net.jt_tech.ui.diamondsprompt.RedDiamondsPrompt";
		/** YellowDiamondsPrompt */
		public static const TYPE_RESOUCRE_DIAMONDS_PROMPT_YELLOW5:String = "net.jt_tech.ui.diamondsprompt.YellowDiamondsPrompt";
		// 钻石资源 提示特效
		
		/** 方块移除时发光效果 (普通 */
//		public static const TYPE_RESOURCE_REMOVE_FLASH_GENERAL:String = "net.jt_tech.ui.animation.ApertureNew";
//		/** 方块移除时发光效果 (兴奋 */
//		public static const TYPE_RESOURCE_REMOVE_FLASH_EXCITING:String = "net.jt_tech.ui.animation.Aperture";
		
		///////////////////// 资源 //////////////////////////////////////
		
		public function DiamondType()
		{
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}