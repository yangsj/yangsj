package diamonds
{

	public class DiamondType
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		/** 普通 */
		public static const generalEffectName:String	= "generalEffectName";
		/** 興奮（极速） */
		public static const excitingEffectName:String	= "excitingEffectName";
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
		public static const Rows:uint 	= 8;
		/** 卡片的列数  */
		public static const Cols:uint 	= 8;
		
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
		public static const propEffectIdArray:Array = [10,11,12,13,14,101,111,131,141];
		public static const PROP_EFFECT_LINKAGE:String = "prop_effect_linkage_";
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
		// 道具资源
		/** blue prop */
		public static const TYPE_RESOUCRE_PROP_BLUE1:String = "net.jt_tech.ui.dispelscene.ResourcePropBlue";
		/** green prop */
		public static const TYPE_RESOUCRE_PROP_GREEN2:String = "net.jt_tech.ui.dispelscene.ResourcePropGreen";
		/** purple same prop bomb */
		public static const TYPE_RESOUCRE_PROP_PURPLE3:String = "net.jt_tech.ui.dispelscene.ResourcePropPurpleSame";
		/** red prop */
		public static const TYPE_RESOUCRE_PROP_RED4:String = "net.jt_tech.ui.dispelscene.ResourcePropRed";
		/** yellow prop */
		public static const TYPE_RESOUCRE_PROP_YELLOW5:String = "net.jt_tech.ui.dispelscene.ResourcePropYellow";
		/** blue same color bomb */
		public static const TYPE_RESOUCRE_PROP_SAME_BLUE:String = "net.jt_tech.ui.dispelscene.ResourcePropBlueSame";
		/** green same color bomb */
		public static const TYPE_RESOUCRE_PROP_SAME_GREEN:String = "net.jt_tech.ui.dispelscene.ResourcePropGreenSame";
		/** red same color bomb */
		public static const TYPE_RESOUCRE_PROP_SAME_RED:String = "net.jt_tech.ui.dispelscene.ResourcePropRedSame";
		/** yellow same color bomb */
		public static const TYPE_RESOUCRE_PROP_SAME_YELLOW:String = "net.jt_tech.ui.dispelscene.ResourcePropYellowSame";
		// 道具资源
		
		// 使用道具特效资源
		/** blue prop effects */
		public static const TYPE_RESOUCRE_PROP_EFFECTS_BLUE1:String = "net.jt_tech.ui.dispelscene.ResourceEffectPropBlue"; 
		/** green prop effects */
		public static const TYPE_RESOUCRE_PROP_EFFECTS_GREEN2:String = "net.jt_tech.ui.dispelscene.ResourceEffectPropGreen";
		/** purple same prop bomb effects */
		public static const TYPE_RESOUCRE_PROP_EFFECTS_PURPLE3:String = "net.jt_tech.ui.dispelscene.ResourceEffectPropPurpleSame";
		/** red prop effects */
		public static const TYPE_RESOUCRE_PROP_EFFECTS_RED4:String = "net.jt_tech.ui.dispelscene.ResourceEffectPropRed";
		/** yellow prop effects */
		public static const TYPE_RESOUCRE_PROP_EFFECTS_YELLOW5:String = "net.jt_tech.ui.dispelscene.ResourceEffectPropYellow";
		/** blue same color bomb effects */
		public static const TYPE_RESOUCRE_PROP_EFFECTS_SAME_BLUE:String = "net.jt_tech.ui.dispelscene.ResourceEffectPropBlueSame";
		/** green same color bomb effects */
		public static const TYPE_RESOUCRE_PROP_EFFECTS_SAME_GREEN:String = "net.jt_tech.ui.dispelscene.ResourceEffectPropGreenSame";
		/** red same color bomb effects */
		public static const TYPE_RESOUCRE_PROP_EFFECTS_SAME_RED:String = "net.jt_tech.ui.dispelscene.ResourceEffectPropRedSame";
		/** yellow same color bomb effects */
		public static const TYPE_RESOUCRE_PROP_EFFECTS_SAME_YELLOW:String = "net.jt_tech.ui.dispelscene.ResourceEffectPropYellowSame";
		// 使用道具特效资源
		
		// 钻石资源
		/** BlueDiamonds */
		public static const TYPE_RESOUCRE_DIAMONDS_BLUE1:String = "net.jt_tech.ui.dispelscene.ResourceBlueDiamonds";
		/** GreenDiamonds */
		public static const TYPE_RESOUCRE_DIAMONDS_GREEN2:String = "net.jt_tech.ui.dispelscene.ResourceGreenDiamonds";
		/** PurpleDiamonds */
		public static const TYPE_RESOUCRE_DIAMONDS_PURPLE3:String = "net.jt_tech.ui.dispelscene.ResourcePurpleDiamonds";
		/** RedDiamonds */
		public static const TYPE_RESOUCRE_DIAMONDS_RED4:String = "net.jt_tech.ui.dispelscene.ResourceRedDiamonds";
		/** YellowDiamonds */
		public static const TYPE_RESOUCRE_DIAMONDS_YELLOW5:String = "net.jt_tech.ui.dispelscene.ResourceYellowDiamonds";
		// 钻石资源
		
		// 钻石资源 提示特效
		/** BlueDiamondsPrompt */
		public static const TYPE_RESOUCRE_DIAMONDS_PROMPT_BLUE1:String = "net.jt_tech.ui.dispelscene.ResourcePromptEffectBlue";
		/** GreenDiamondsPrompt */
		public static const TYPE_RESOUCRE_DIAMONDS_PROMPT_GREEN2:String = "net.jt_tech.ui.dispelscene.ResourcePromptEffectGreen";
		/** PurpleDiamondsPrompt */
		public static const TYPE_RESOUCRE_DIAMONDS_PROMPT_PURPLE3:String = "net.jt_tech.ui.dispelscene.ResourcePromptEffectPurple";
		/** RedDiamondsPrompt */
		public static const TYPE_RESOUCRE_DIAMONDS_PROMPT_RED4:String = "net.jt_tech.ui.dispelscene.ResourcePromptEffectRed";
		/** YellowDiamondsPrompt */
		public static const TYPE_RESOUCRE_DIAMONDS_PROMPT_YELLOW5:String = "net.jt_tech.ui.dispelscene.ResourcePromptEffectYellow";
		// 钻石资源 提示特效
		
		/** 方块移除时发光效果 (普通 */
		public static const TYPE_RESOURCE_REMOVE_FLASH_GENERAL:String = "RemovedEffectGeneral_MovieClip";
//		/** 方块移除时发光效果 (兴奋 */
		public static const TYPE_RESOURCE_REMOVE_FLASH_EXCITING:String = "RemoveEffectExciting_MovieClip";
		
		//场景背景图资源
		/** 消除钻石界面背景资源 */
		public static const TYPE_RESOURCE_SCENE_DISPEL_DIAMONDS:String = "scene.DiamondsScene";
		
			////////// others ///////
		/** DiamondsRockEffect(震动动画 */
		public static const TYPE_RESOURCE_ROCK_FRAME_EFFECT:String = "net.jt_tech.ui.dispelscene.ResourceDiamondsRockEffect";
		/** go 动画资源 */
		public static const TYPE_RESOURCE_DISPEL_WORDS_GO:String = "net.jt_tech.ui.dispelscene.ResourceWordGo";
		/** ready 动画资源 */
		public static const TYPE_RESOURCE_DISPEL_WORDS_READY:String = "net.jt_tech.ui.dispelscene.ResourceWordReady";
		/** times up 动画资源 */
		public static const TYPE_RESOURCE_DISPEL_WORDS_TIMESUP:String = "net.jt_tech.ui.dispelscene.ResourceWordTimesUp";
		/** 增加6秒 动画资源 */
		public static const TYPE_RESOURCE_DISPEL_ADD_TIME_SECONDS_SIX:String = "net.jt_tech.ui.dispelscene.ResourceIncreaseSeconds";
		/** 减少2秒 动画资源 */
		public static const TYPE_RESOURCE_DISPEL_MINUS_TIME_SECONDS_TWO:String = "net.jt_tech.ui.dispelscene.ResourceMinusTwoSeconds";
		
		
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