package victor.framework.components.scroll {

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    import victor.framework.interfaces.IDisposable;

    /**
     * @author fireyang
     */
    public class BaseScrollPanel implements IDisposable {
        protected var _bar : ScrollBar;
        protected var _target : Sprite;
        // 显示大小
        protected var _contentRect : Rectangle;
        protected var _maskSp : Shape;
        private var _whellSp : Sprite;
        private var _targetY : Number;
        private var _mainHeight : int;
        protected var _posRadio : Number;
        private var _emptyLen : Number;
        // 设置滚动条高度
        private var _barHeight : int;
        private var _barPos : Point;
        private var _barContainer : DisplayObjectContainer;

        function BaseScrollPanel(skin : Sprite) : void {
            _bar = new ScrollBar(skin);
            _bar.init(1);
            _bar.onChange = onBarChange;
            _maskSp = creatSp(Shape) as Shape;
            _whellSp = creatSp(Sprite) as Sprite;
            _whellSp.alpha = 0;
			
			if ( _bar.parent == null )
				_bar.addEventListener(Event.ADDED, addedToParentHandler );
        }
		
		private function addedToParentHandler(event:Event):void
		{
			if ( _bar )
				_bar.removeEventListener(Event.ADDED, addedToParentHandler );
			
			reRender();
		}
		
        private function onBarChange(value : Number) : void {
            _posRadio = value;
            _target.y = _targetY - value * _emptyLen;
        }

        private function creatSp(cla : Class) : DisplayObject {
            var sp : DisplayObject = new cla();
            var graphic : Graphics;
            if (sp is Shape) {
                graphic = (sp as Shape).graphics;
            } else {
                graphic = (sp as Sprite).graphics;
            }
            graphic.beginFill(0);
            graphic.drawRect(0, 0, 1, 1);
            graphic.endFill();
            return sp;
        }

        public function setTarget(targetMc : Sprite) : void {
            if (_target && _target != targetMc) {
                removeTarget();
            } else {
                _target = targetMc;
            }
            _targetY = _target.y;
            _mainHeight = _target.height;
            if (_contentRect) {
                _mainHeight -= _contentRect.y;
            }
        }

        private function removeTarget() : void {
            if (_target) {
                _target.y = _targetY;
            }
            _target = null;
        }

        public function setContent(x : int, y : int, w : int, h : int) : void {
            _contentRect = new Rectangle(x, y, w, h);
            reRender();
        }

        /**
         * 重新渲染
         */
        protected function reRender() : void {
            if (_target && _target.parent && _contentRect) {
                if (_barContainer) {
                    _barContainer.addChild(_bar);
                } else {
                    _target.parent.addChild(_bar);
                }
                setMask();
                setScrollBar();
                updateBar();
            }
        }

        protected function updateBar() : void {
            setWheel();
            _emptyLen = _mainHeight - _contentRect.height;
            if (_emptyLen < 0) {
                _emptyLen = 0;
            }
            _posRadio = _contentRect.height / _mainHeight;
            if (_posRadio > 1) {
                _posRadio = 1;
            }
            _bar.radio = _posRadio;
        }

        public function updateMainHeight(value : int = -1) : void {
            if (_target) {
                if (value == -1) {
                    _mainHeight = _target.height - _contentRect.y;
                } else {
                    _mainHeight = value;
                }
                updateBar();
            }
        }

        public function changeShowHeight(value : int) : void {
            _contentRect.height = value;
            reRender();
        }

        private function setWheel() : void {
            if (_target  ) {
                _whellSp.width = _contentRect.width;
                _whellSp.height = _mainHeight;
                _target.addChildAt(_whellSp, 0);
                _target.addEventListener(MouseEvent.MOUSE_WHEEL, onScrollWheel);
            }
        }

        private function onScrollWheel(event : MouseEvent) : void {
            if (event.delta > 0) {
                _bar.upMove();
            } else {
                _bar.downMove();
            }
        }

        public function setBarContainer(container : DisplayObjectContainer, x : int, y : int, height : int) : void {
            _barContainer = container;
            _bar.x = x;
            _bar.y = y;
            _bar.setBarHeight(height);
            _barContainer.addChild(_bar);
        }

        private function setScrollBar() : void {
            if (_bar == null || _barContainer) {
                return;
            }
            if (_barPos) {
                _bar.x = _target.x + _barPos.x;
                _bar.y = _target.y + _barPos.y;
            } else if (_contentRect) {
                _bar.x = _maskSp.x + _maskSp.width - _bar.width;
                _bar.y = _maskSp.y;
            }
            if (_barHeight == 0 && _contentRect) {
                _bar.setBarHeight(_contentRect.height);
            } else {
                _bar.setBarHeight(_barHeight);
            }
        }

        private function setMask() : void {
            if (_target && _target.parent) {
                _maskSp.width = _contentRect.width;
                _maskSp.height = _contentRect.height;
                _maskSp.x = _target.x + _contentRect.x;
                _maskSp.y = _target.y + _contentRect.y;
                _target.parent.addChild(_maskSp);
                _target.mask = _maskSp;
            }
        }

        public function set barHeight(barHeight : int) : void {
            _barHeight = barHeight;
            setScrollBar();
        }

        public function changeBarPos(x : int, y : int) : void {
            _barPos = new Point(x, y);
            setScrollBar();
        }

        public function dispose() : void {
        }
    }
}
