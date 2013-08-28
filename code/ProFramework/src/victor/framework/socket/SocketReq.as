package victor.framework.socket {

    /**
     * @author fireyang
     */
    public class SocketReq {
        // 发送对象
        public var obj : *;
        private var _api : uint;
        // 请求seq
        private var _seq : uint;
        private static var _pool : Array = [];

        /**
         * Construct a <code>SocketReq</code>.
         */
        public function SocketReq() {
        }

        private function reset() : void {
            obj = null;
            _api = 0;
        }

        public function get api() : uint {
            return _api;
        }

        public function set api(api : uint) : void {
            _api = api;
        }

        public function get seq() : uint {
            return _seq;
        }

        public static function creatReq() : SocketReq {
            var req : SocketReq;
            if (_pool.length > 0) {
                req = _pool.pop();
            } else {
                req = new SocketReq();
            }
            req._seq = PacketParse.getSeq();
            return req;
        }

        public static function disposeReq(req : SocketReq) : void {
            req.reset();
            _pool.push(req);
        }
    }
}
