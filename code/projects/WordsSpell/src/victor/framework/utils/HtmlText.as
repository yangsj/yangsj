package victor.framework.utils {
    /**
     * @author fireyang
     */
    public class HtmlText {
        public static const Yellow : uint = 0xffff00;
        public static const Red : uint = 0xff0000;
        public static const White : uint = 0xffffff;
        public static const Green : uint = 0x00ff00;
        public static const Blue : uint = 0x0000ff;
        public static const Orange : uint = 0xf7941d;
        public static const Blue2 : uint = 0x00aeef;
        public static const Yellow2 : uint = 0xfff200;
        public static const Purple : uint = 0xff00ff;
        public static const ALIGN_RIGHT : String = "right";
        public static const ALIGN_LEFT : String = "left";

        public static function yellow(msg : String) : String {
            return format(msg, Yellow);
        }

        public static function red(msg : String) : String {
            return format(msg, Red);
        }

        public static function white(msg : String) : String {
            return format(msg, White);
        }

        public static function green(msg : String) : String {
            return format(msg, Green);
        }

        public static function blue(msg : String) : String {
            return format(msg, Blue);
        }

        public static function orange(msg : String) : String {
            return format(msg, Orange);
        }

        public static function blue2(msg : String) : String {
            return format(msg, Blue2);
        }

        public static function yellow2(msg : String) : String {
            return format(msg, Yellow2);
        }

        public static function purple(msg : String) : String {
            return format(msg, Purple);
        }

        public static function format(msg : String, color : uint = 0, size : uint = 12, font : String = "", isBold : Boolean = false, italic : Boolean = false, isUnderLine : Boolean = false, url : String = null, align : String = null) : String {
            if (isBold) {
                msg = "<b>" + msg + "</b>";
            }
            if (italic) {
                msg = "<i>" + msg + "</i>";
            }
            if (isUnderLine) {
                msg = "<u>" + msg + "</u>";
            }
            var fontDes : String = "";

            if (font) {
                fontDes = fontDes + (" face=\"" + font + "\"");
            }
            if (size > 0) {
                fontDes = fontDes + (" size=\"" + size + "\"");
            }
            fontDes = fontDes + (" color=\"#" + color.toString(16) + "\"");
            msg = "<font" + fontDes + ">" + msg + "</font>";
            if (url) {
                msg = "<a href=\"" + url + "\" target=\"_blank\">" + msg + "</a>";
            }
            if (align) {
                msg = "<p align=\"" + align + "\">" + msg + "</p>";
            }
            return msg;
        }

        public static function align(str : String, align : String) : String {
            return  "<p align=\"" + align + "\">" + str + "</p>";
        }

        public static function urlEvent(str : String, params : String, color : uint = 0) : String {
            var msg : String = "<a href=\"event:" + params + "\" ><u>" + str + "</u></a>";
            if (color != 0) {
                msg = "<font color=\"# " + color.toString(16) + "\">" + msg + "</font>";
            }
            return msg;
        }

        public static function color(string : String, color : uint) : String {
            return "<font color='#" + color.toString(16) + "'>" + string + "</font>" ;
        }

        public static function unline(msg : String) : String {
            return "<u>" + msg + "</u>";
        }

        public static function center(str:String):String {
            return "<p align=\"center\">" + str + "</p>";
        }
    }
}
