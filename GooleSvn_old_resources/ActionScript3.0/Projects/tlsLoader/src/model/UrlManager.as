package model
{

    public class UrlManager extends Object
    {
        private static var _instance:UrlManager;

        public function UrlManager()
        {
            return;
        }// end function

        public function getUrl(url:String, type:int = 1) : String
        {
            var _loc_3:String = "";
            if (type == 1)
            {
                _loc_3 = InitDomain.instance.urlHead + url;
            }
            else if (type == 2)
            {
                _loc_3 = InitDomain.instance.urlHead_fram + url;
            }
            else if (type == 3)
            {
                _loc_3 = InitDomain.instance.urlHead_tiger + url;
            }
            return _loc_3;
        }// end function

        public static function get instance() : UrlManager
        {
            if (_instance == null)
            {
                _instance = new UrlManager;
            }
            return _instance;
        }// end function

    }
}
