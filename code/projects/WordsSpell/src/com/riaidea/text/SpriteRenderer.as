/**
 * RichTextField
 * @author Alex.li - www.riaidea.com
 * @homepage http://code.google.com/p/richtextfield/
 */
package com.riaidea.text {
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import flash.text.TextLineMetrics;
    import flash.utils.Dictionary;
    import flash.utils.getQualifiedClassName;

    /**
     * @private
     */
    internal class SpriteRenderer {
        private var _rtf : RichTextField;
        private var _numSprites : int;
        private var _spriteContainer : Sprite;
        private var _spriteIndices : Dictionary;
        public var spriteOffsetY : Number = 0;

        public function SpriteRenderer(rtf : RichTextField) {
            _rtf = rtf;
            _numSprites = 0;
            _spriteContainer = new Sprite();
            _spriteIndices = new Dictionary();
        }

        internal function render() : void {
            if (_numSprites > 0) {
                _spriteContainer.addEventListener(Event.ENTER_FRAME, onEnterFrame);
            }
        }

        /**
         * prevent executing rendering code more than one time during a frame
         * @param	e ENTER_FRAME evnet
         */
        private function onEnterFrame(e : Event) : void {
            _spriteContainer.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            doRender();
        }

        /**
         * the real rendering function
         */
        private function doRender() : void {
            _spriteContainer.y = -textRenderer.scrollHeight;
            renderVisibleSprites();
        }

        private function renderVisibleSprites() : void {
            // all visible sprites are between lines scrollV and bottomScrollV
            var startLine : int = textRenderer.scrollV - 1;
            var endLine : int = textRenderer.bottomScrollV - 1;
            var startIndex : int = textRenderer.getLineOffset(startLine);
            var endIndex : int = textRenderer.getLineOffset(endLine) + textRenderer.getLineLength(endLine) - 1;

            // clear all rendered sprites
            while (_spriteContainer.numChildren > 0) _spriteContainer.removeChildAt(0);

            // render sprites which between sdtartIndex and endIndex
            while (startIndex <= endIndex) {
                if (_rtf.isSpriteAt(startIndex)) {
                    var sprite : DisplayObject = getSprite(startIndex);
                    if (sprite != null) renderSprite(sprite, startIndex);
                }
                startIndex++;
            }
        }

        private function renderSprite(sprite : DisplayObject, index : int) : void {
            var rect : Rectangle = textRenderer.getCharBoundaries(index);
            if (rect != null) {
                sprite.x = (rect.x + (rect.width - sprite.width) * 0.5 + 0.5 - textRenderer.scrollH) >> 0;
//                sprite.x = (rect.x + (rect.width - sprite.width) * 0.5 + 0.5 ) >> 0;
                var y : Number = (rect.height - sprite.height) * 0.5;
                var lineMetrics : TextLineMetrics = textRenderer.getLineMetrics(textRenderer.getLineIndexOfChar(index));
                // make sure the sprite's y is not smaller than the ascent of line metrics
                if (y + sprite.height < lineMetrics.ascent) y = lineMetrics.ascent - sprite.height;
                sprite.y = (rect.y + y + 0.5) + spriteOffsetY + textRenderer.scrollHeight >> 0;
                _spriteContainer.addChild(sprite);
            }
        }

        internal function adjustSpritesIndex(changeIndex : int, changeLength : int) : Boolean {
            var adjusted : Boolean = false;
            for (var s:* in _spriteIndices) {
                var index : int = int(s.name);
                if (index > changeIndex - changeLength) {
                    s.name = index + changeLength;
                    adjusted = true;
                }
            }
            return adjusted;
        }

        internal function insertSprite(sprite : DisplayObject, index : int) : void {
            if (_spriteIndices[sprite] == null) {
                sprite.name = String(index);
                _spriteIndices[sprite] = true;
                _numSprites++;
            }
        }

        internal function removeSprite(index : int) : void {
            var sprite : DisplayObject = getSprite(index);
            if (sprite != null) {
                if (_spriteContainer.contains(sprite)) _spriteContainer.removeChild(sprite);
                delete _spriteIndices[sprite];
                _numSprites--;
            }
        }

        internal function getSprite(index : int) : DisplayObject {
            for (var s:* in _spriteIndices) {
                if (index == int(s.name)) return s;
            }
            return null;
        }

        internal function getSpriteIndex(sprite : DisplayObject) : int {
            if (_spriteIndices[sprite] == true) return int(sprite.name);
            return -1;
        }

        internal function clear() : void {
            while (_spriteContainer.numChildren > 0) _spriteContainer.removeChildAt(0);
            for (var p:* in _spriteIndices) delete _spriteIndices[p];
            _numSprites = 0;
        }

        private function get textRenderer() : TextRenderer {
            return _rtf.textfield as TextRenderer;
        }

        internal function get container() : Sprite {
            return _spriteContainer;
        }

        internal function get numSprites() : int {
            return _numSprites;
        }

        internal function exportXML() : XML {
            var arr : Array = [];
            for (var s:* in _spriteIndices) {
                var info : Object = {src:getQualifiedClassName(s), index:s.name};
                arr.push(info);
            }
            if (arr.length > 1) arr.sortOn("index", Array.NUMERIC);

            var xml : XML = <sprites/>;
            for (var i : int = 0; i < arr.length; i++) {
                var node : XML = <sprite src={arr[i].src} index={arr[i].index - i} />;
                xml.appendChild(node);
            }
            return xml;
        }
    }
}