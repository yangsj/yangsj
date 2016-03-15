package model
{
    import flash.display.*;

    public class InitDomain extends Sprite
    {
        public var registerNum:int = 9999;
        public var ssid:String = "";
        public var urlHead:String = "http://222.73.41.217:801/niuniu/index.php/Index/";
        public var urlHead_fram:String = "http://222.73.41.217:801/niuniu/index.php/Game/Farm/";
        public var urlHead_tiger:String = "http://222.73.41.217:801/niuniu/index.php/Game/Tiger/";
        private static var _instance:InitDomain;

        public function InitDomain()
        {
            return;
        }// end function

        public static function get instance() : InitDomain
        {
            if (_instance == null)
            {
                _instance = new InitDomain;
            }
            return _instance;
        }// end function

    }
}
