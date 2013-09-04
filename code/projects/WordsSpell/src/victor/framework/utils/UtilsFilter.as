package victor.framework.utils {

    import flash.filters.*;

    public class UtilsFilter {
        // 灰色
        public static var COLOR_GREW : ColorMatrixFilter = new ColorMatrixFilter([0.3, 0.3, 0.3, 0, 0, 0.3, 0.3, 0.3, 0, 0, 0.3, 0.3, 0.3, 0, 0, 0, 0, 0, 1, 1]);
        public static var filter2 : GlowFilter = new GlowFilter(0, 1, 2, 2, 4, 1);
        public static var filter3 : DropShadowFilter = new DropShadowFilter(4);
        // 高亮
        public static var COLOR_HIGHTLIGHT : ColorMatrixFilter = new ColorMatrixFilter([1, 0, 0, 0, 45, 0, 1, 0, 0, 45, 0, 0, 1, 0, 45, 0, 0, 0, 1, 0]);
        public static var dropFilter : DropShadowFilter = new DropShadowFilter(0, 45, 0, 1, 2, 2, 10);
        public static var stroke : GlowFilter = new GlowFilter(0, 0.7, 2, 2, 17, 1, false, false);
        // 初始化
        public static const BLACK_BORDER : GlowFilter = new GlowFilter(0, 1, 2, 2, 10);
        public static const WHITE_BORDER : GlowFilter = new GlowFilter(0xffffff, 1, 2, 2, 10);
    }
}
