package app.core.text {
    import com.riaidea.text.RichTextField;
    
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.FocusEvent;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.events.TextEvent;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    
    import mx.utils.StringUtil;
    
    import app.managers.LoaderManager;
    
    import victor.framework.components.scroll.ScrollBar;

    /**
     * @author fireyang
     */
    public class RichTextPanel extends Sprite {
        private var _text : RichTextField;
        private var _bar : ScrollBar;
        private var _tf : TextField;
        private var _oldMaxScroll : int;
        public var focusChangeHandler : Function;
        private var _stage : Stage;

        /**
         * Construct a <code>RichTextPanel</code>.
         */
        public function RichTextPanel() {
            _text = new RichTextField();
            _text.html = true;
            _tf = _text.textfield;
            _text.autoScroll = true;
            _text.lineHeight = 18;
            // _text.textfield.background = true;
            // _text.textfield.backgroundColor = 0xaaaaaa;
            _bar = new ScrollBar(getBarSkin());
            _tf.addEventListener(MouseEvent.MOUSE_WHEEL, onWheelHandler);
            _tf.addEventListener(TextEvent.TEXT_INPUT, onInput);
            _tf.addEventListener(FocusEvent.FOCUS_IN, onFocusChange);
            _tf.addEventListener(FocusEvent.FOCUS_OUT, onFocusChange);
            _bar.onChange = onBarChange;
            addChild(_text);
            _bar.init(1);
            addChild(_bar);
            updateBar();
        }

        private function onFocusChange(event : FocusEvent) : void {
            if (focusChangeHandler == null) {
                return;
            }
            if (event.type == FocusEvent.FOCUS_IN) {
                focusChangeHandler(true);
            } else {
                focusChangeHandler(false);
            }
        }

        private function onBarChange(value : Number) : void {
            _tf.scrollV = value * _tf.maxScrollV;
        }

        private function onWheelHandler(event : MouseEvent) : void {
            if (_bar) {
                var cur : int = _tf.scrollV - 1;
                var max : int = _tf.maxScrollV - 1;
                _bar.pos = max == 0 ? 0 : cur / max;
            }
        }

        public function exportXML() : XML {
            return _text.exportXML();
        }

        public function get isEmpty():Boolean{
            return _text.numSprites==0 && StringUtil.trim(_text.text).length == 0;
        }

        /**
         * 打印消息
         */
        public function printMsg(value : String) : void {
            var msg : XML = <rtf>
							<text></text>
							<sprites>
							</sprites>
							</rtf>;
            msg.text[0] = value;
            traceMsg(msg);
        }

        public function traceMsg(xml : XML) : void {
            _text.importXML(xml);
            updateBar();
        }

        public function set type(type : String) : void {
            _text.type = type;
            if (type == TextFieldType.INPUT) {
                _text.textfield.addEventListener(MouseEvent.CLICK, this.sendTextClick);
            }
        }

        private function sendTextClick(event : MouseEvent) : void {
            _stage = this._text.stage;
            _stage.focus = _text.textfield;
            _stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyUpHandler, false, 1);
            _stage.addEventListener(MouseEvent.MOUSE_DOWN, onStageDown);
        }

        private function onStageDown(event : MouseEvent) : void {
            if (!this.hitTestPoint(this.mouseX, this.mouseY)) {
                clearSendEvent();
            }
        }

        private function clearSendEvent() : void {
            if (_stage) {
                _stage.focus = null;
                _stage.removeEventListener(MouseEvent.MOUSE_DOWN, onStageDown);
                _stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyUpHandler);
            }
        }

        public function dispose() : void {
            _text.textfield.removeEventListener(MouseEvent.CLICK, this.sendTextClick);
            clearSendEvent();
        }

        private function onKeyUpHandler(event : KeyboardEvent) : void {
            event.stopImmediatePropagation();
        }

        private function updateBar() : void {
            var radio : Number ;
            if (_tf.maxScrollV == 1) {
                radio = 1;
            } else {
                radio = (_tf.numLines - _tf.maxScrollV) / _tf.numLines;
            }
            _bar.radio = radio;
            _bar.pos = 1;
        }

        public function set selectEnable(value : Boolean) : void {
            _text.textfield.selectable = value;
        }

        public function getBarSkin() : Sprite {
            var skin : Sprite = LoaderManager.instance.getObj("ui_scrollBar5") as Sprite;
            return skin;
        }

        public function setSize(w : int, h : int) : void {
            _text.setSize(w - _bar.width, h);
            _bar.setBarHeight(h);
            _bar.x = _text.x + _text.width;
        }

        public function setTextFormat(inputFormat : TextFormat) : void {
            _text.defaultTextFormat = inputFormat;
        }

        private function onInput(event : TextEvent) : void {
            var value : int = _tf.maxScrollV;
            if (value != _oldMaxScroll) {
                updateBar();
                _oldMaxScroll = value;
            }
        }

        public function clear() : void {
            _text.clear();
            updateBar();
        }

        public function offsetBarPos(x : int, y : int) : void {
            _bar.x = _text.x + _text.width + x;
            _bar.y = y;
        }

        public function get text() : RichTextField {
            return _text;
        }

        public function insertSprite(smileyCla : Class) : void {
            _text.insertSprite(smileyCla, _text.caretIndex);
            _text.caretIndex++;
        }
    }
}
