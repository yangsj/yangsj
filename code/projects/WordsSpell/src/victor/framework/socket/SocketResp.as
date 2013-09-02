package victor.framework.socket {
    /**
     * @author fireyang
     */
    public class SocketResp {
        // 响应
        public var data : * ;
        private var _api : uint;
        // 返回数据类型
        public var type : uint;
        // 请求seq
        public var seq : uint;
        // 响应
        private static var _pool : Array = [];

        public function get api() : uint {
            return _api;
        }

        public function set api(api : uint) : void {
            _api = api;
        }

        private function reset() : void {
            data = null;
            _api = 0;
        }

        public static function creat() : SocketResp {
            var req : SocketResp;
            if (_pool.length > 0) {
                req = _pool.pop();
            } else {
                req = new SocketResp();
            }
            return req;
        }

        public static function disposeResp(req : SocketResp) : void {
            req.reset();
            _pool.push(req);
        }
    }
}
