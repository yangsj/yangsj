package victor.framework.socket {
    import flash.events.IEventDispatcher;

    /**
     * @author fireyang
     */
    public interface ISocketManager extends IEventDispatcher {
        function connect(host : String, port : int) : void;

        function close() : void;

        function call(req : SocketReq, callback : Function = null, hasTimeAllow : Boolean = true) : void;

        /**
         * 单次请求
         */
        function onceCall(req : SocketReq, callback : Function, respCla : Class) : void;

        function registerDataCallback(api : uint, callback : Function, respProc : Class = null, isIgnore : Boolean = false) : void

        function get beatTime() : int ;
    }
}
