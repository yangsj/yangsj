package victor.framework.socket {
    import flash.utils.Dictionary;

    /**
     * @author fireyang
     */
    public class Protocol {
        private static var _wired : Dictionary;

        public static function keepAlive(api : int) : Boolean {
            return _wired[api];
        }

        public static function init() : void {
            if (_wired == null) {
                _wired = new Dictionary();
            }
        }

        public static function addWired(api : int) : void {
            _wired[api] = true;
        }
    }
}
