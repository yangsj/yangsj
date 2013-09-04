/**
 * RichTextField
 * @author Alex.li - www.riaidea.com
 * @homepage http://code.google.com/p/richtextfield/
 */
package com.riaidea.text {
    import com.riaidea.text.plugins.IRTFPlugin;
    
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextLineMetrics;
    import flash.utils.getDefinitionByName;

    /**
     * <p>RichTextField是一个基于TextField的图文混编的组件。</p>
     * <p>众所周知，TextField可以用html的方式来插入图片，但无法有效控制图片的位置且不能实时编辑。RichTextField可以满足这方面的需求。</p>
     * <p>RichTextField有如下特性：
     * <br><ul>
     * <li>在文本末尾追加文本和显示元素。</li>
     * <li>在文本任何位置替换(删除)文本和显示元素。</li>
     * <li>支持HTML文本和显示元素的混排。</li>
     * <li>可动态设置RichTextField的尺寸大小。</li>
     * <li>可导入和导出XML格式的文本框内容。</li>
     * </ul></p>
     * 
     * 
     * @example 下面的例子演示了RichTextField基本使用方法：
     * <listing>
    var rtf:RichTextField = new RichTextField();			
    rtf.x = 10;
    rtf.y = 10;
    addChild(rtf);

    // 设置rtf的尺寸大小
    rtf.setSize(500, 400);
    // 设置rtf的类型
    rtf.type = RichTextField.INPUT;
    // 设置rtf的默认文本格式
    rtf.defaultTextFormat = new TextFormat("Arial", 12, 0x000000);

    // 追加文本和显示元素到rtf中
    rtf.append("Hello, World!", [ { index:5, src:SpriteClassA }, { index:13, src:SpriteClassB } ]);
    // 替换指定位置的内容为新的文本和显示元素
    rtf.replace(8, 13, "世界", [ { src:SpriteClassC } ]);</listing>
     * 
     * 
     * @example 下面是一个RichTextField的内容的XML例子，你可以使用importXML()来导入具有这样格式的XML内容，或用exportXML()导出这样的XML内容方便保存和传输：
     * <listing>
    &lt;rtf&gt;
    &lt;text&gt;Hello, World!&lt;/text&gt;
    &lt;sprites&gt;
    &lt;sprite src="SpriteClassA" index="5"/&gt;
    &lt;sprite src="SpriteClassB" index="13"/&gt;
    &lt;/sprites&gt;
    &lt;/rtf&gt;</listing>
     */
    public class RichTextField extends Sprite {
        private var _width : Number;
        private var _height : Number;
        private var _textRenderer : TextRenderer;
        private var _spriteRenderer : SpriteRenderer;
        private var _formatCalculator : TextField;
        private var _plugins : Array;
        private var _placeholder : String;
        private var _placeholderColor : uint;
        private var _placeholderMarginH : int;
        private var _placeholderMarginV : int;
        /**
         * 一个布尔值，指示文本字段是否以HTML形式插入文本。
         * @default false
         */
        public var html : Boolean;
        /**
         * 指示文本字段的显示元素的行高（最大高度）。
         * @default 0
         */
        public var lineHeight : int;
        /**
         * 一个布尔值，指示当追加内容到RichTextField后是否自动滚动到最底部。
         * @default true
         */
        public var autoScroll : Boolean;
        /**
         * 用于指定动态类型的RichTextField。
         */
        public static const DYNAMIC : String = "dynamic";
        /**
         * 用于指定输入类型的RichTextField。
         */
        public static const INPUT : String = "input";
        /**
         * RichTextField的版本号。
         */
        public static const version : String = "2.0.2";
        public var textHeight : int;

        /**
         * 构造函数。
         */
        public function RichTextField() {
            // text renderer
            _textRenderer = new TextRenderer();
            addChild(_textRenderer);

            // sprite renderer
            _spriteRenderer = new SpriteRenderer(this);
            addChild(_spriteRenderer.container);

            // default settings
            setSize(100, 100);
            type = DYNAMIC;
            lineHeight = 0;
            textHeight = 12;
            html = false;
            autoScroll = false;

            // default placeholder
            _placeholder = String.fromCharCode(12288);
            _placeholderColor = 0x000000;
            _placeholderMarginH = 1;
            _placeholderMarginV = 0;

            // an invisible textfield for calculating placeholder's textFormat
            _formatCalculator = new TextField();
            _formatCalculator.text = _placeholder;

            // make sure that can't input placeholder
            _textRenderer.restrict = "^" + _placeholder;
        }

        /**
         * 追加newText参数指定的文本和newSprites参数指定的显示元素到文本字段的末尾。
         * @param	newText 要追加的新文本。
         * @param	newSprites 要追加的显示元素数组，每个元素包含src和index两个属性，如：{src:sprite, index:1}。
         * @param	autoWordWrap 指示是否自动换行。
         * @param	format 应用于追加的新文本的格式。
         */
        public function append(newText : String, newSprites : Array = null, autoWordWrap : Boolean = false, format : TextFormat = null) : void {
            // append text
            var scrollV : int = _textRenderer.scrollV;
            var oldLength : int = _textRenderer.length;
            var textLength : int = 0;

            if (!newText) newText = "";
            if (newText || newSprites || autoWordWrap) {
                if (newText) newText = newText.split("\r").join("\n");
                // plus a newline(\n) only if append as normal text
                if (autoWordWrap && !html) newText += "\n";
                _textRenderer.recoverDefaultFormat();
                if (html) {
                    // make sure the new text have the default text format
                    _textRenderer.htmlText += "<p>" + newText + "</p>";
                } else {
                    _textRenderer.appendText(newText);
                    if (format == null) format = _textRenderer.defaultTextFormat;
                    //_textRenderer.setTextFormat(format, oldLength, _textRenderer.length-1);
					//setInputXml error
					var idx:int = _textRenderer.length-1;
					if(idx==0) idx=1;
					_textRenderer.setTextFormat(format, oldLength, idx);
                }
                // record text length added
                if (html || (autoWordWrap && !html)) textLength = _textRenderer.length - oldLength;
                else textLength = _textRenderer.length - oldLength;
            }

            // append sprites
            var newline : Boolean = html && (oldLength != 0);
            insertSprites(newSprites, oldLength, oldLength + textLength, newline);

            // auto scroll
            if (autoScroll && _textRenderer.scrollV != _textRenderer.maxScrollV) {
                _textRenderer.scrollV = _textRenderer.maxScrollV;
            } else if (!autoScroll && _textRenderer.scrollV != scrollV) {
                _textRenderer.scrollV = scrollV;
            }

            // if doesn't scroll but have sprites to render, do it
            if (newSprites != null) _spriteRenderer.render();
        }

        /**
         * 使用newText和newSprites参数的内容替换startIndex和endIndex参数指定的位置之间的内容。
         * @param	startIndex 要替换的起始位置。
         * @param	endIndex 要替换的末位位置。
         * @param	newText 要替换的新文本。
         * @param	newSprites 要替换的显示元素数组，每个元素包含src和index两个属性，如：{src:sprite, index:1}。
         */
        public function replace(startIndex : int, endIndex : int, newText : String, newSprites : Array = null) : void {
            // replace text
            var oldLength : int = _textRenderer.length;
            var textLength : int = 0;
            if (endIndex > oldLength) endIndex = oldLength;
            newText = newText.split(_placeholder).join("");
            _textRenderer.replaceText(startIndex, endIndex, newText);
            textLength = _textRenderer.length - oldLength + (endIndex - startIndex);

            if (textLength > 0) {
                _textRenderer.setTextFormat(_textRenderer.defaultTextFormat, startIndex, startIndex + textLength);
            }

            // remove sprites which be replaced
            for (var i : int = startIndex; i < endIndex; i++) {
                _spriteRenderer.removeSprite(i);
            }

            // adjust sprites after startIndex
            var adjusted : Boolean = _spriteRenderer.adjustSpritesIndex(startIndex - 1, _textRenderer.length - oldLength);

            // insert sprites
            insertSprites(newSprites, startIndex, startIndex + textLength);

            // if adjusted or have sprites inserted, do render
            if (adjusted || (newSprites && newSprites.length > 0)) _spriteRenderer.render();
        }

        /**
         * 从参数startIndex指定的索引位置开始，插入若干个由参数newSprites指定的显示元素。
         * @param	newSprites 要插入的显示元素数组，每个元素包含src和index两个属性，如：{src:sprite, index:1}。
         * @param	startIndex 要插入显示元素的起始位置。
         * @param	maxIndex 要插入显示元素的最大索引位置。	
         * @param	newline 指示是否为文本的新行。	
         */
        private function insertSprites(newSprites : Array, startIndex : int, maxIndex : int, newline : Boolean = false) : void {
            if (newSprites == null) return;
            newSprites.sortOn("index", Array.NUMERIC);

            for (var i : int = 0; i < newSprites.length; i++) {
                var obj : Object = newSprites[i];
                var sprite : Object = obj.src;
                var index : int = obj.index;
                if (obj.index == undefined || index < 0 || index > maxIndex - startIndex) {
                    obj.index = maxIndex - startIndex;
                    newSprites.splice(i, 1);
                    newSprites.push(obj);
                    i--;
                    continue;
                }

                // if (newline && index > 0 && index < maxIndex - startIndex) index += startIndex + i-1;
                // else index += startIndex + i;
                index += startIndex + i - 1;
                insertSprite(sprite, index, false, obj.cache);
            }
        }

        /**
         * 在参数index指定的索引位置（从零开始）插入由newSprite参数指定的显示元素。
         * @param	newSprite 要插入的显示元素。其格式包含src和index两个属性，如：{src:sprite, index:1}。
         * @param	index 要插入的显示元素的索引位置。
         * @param	autoRender 指示是否自动渲染插入的显示元素。
         * @param	cache 指示是否对显示元素使用缓存。
         */
        public function insertSprite(newSprite : Object, index : int = -1, autoRender : Boolean = true, cache : Boolean = false) : void {
            // create a instance of sprite
            var spriteObj : DisplayObject = getSpriteFromObject(newSprite);
            if (spriteObj == null) throw Error("Specific sprite:" + newSprite + " is not a valid display object!");

            if (cache) spriteObj.cacheAsBitmap = true;
            // resize spriteObj if lineHeight is specified
            var pH : int = lineHeight + 5;
            if (lineHeight > 0 && spriteObj.height > pH) {
                var scaleRate : Number = pH / spriteObj.height;
                spriteObj.height = pH;
                spriteObj.width = spriteObj.width * scaleRate;
            }
            

            // verify the index to insert
            if (index < 0 || index > _textRenderer.length) index = _textRenderer.length;
            // insert a placeholder into textfield by using replaceText method
            _textRenderer.replaceText(index, index, _placeholder);
            // calculate a special textFormat for spriteObj's placeholder

            var format : TextFormat;
            if (_textRenderer.multiline) {
                format = calcPlaceholderFormat(spriteObj.width, lineHeight);
            } else {
                format = calcPlaceholderFormat(spriteObj.width, textHeight);
            }
            // apply the textFormat to placeholder to make it as same size as the spriteObj
            _textRenderer.setTextFormat(format, index, index + 1);

            // adjust sprites index which come after this sprite
            _spriteRenderer.adjustSpritesIndex(index, 1);
            // insert spriteObj to specific index and render it if it's visible
            _spriteRenderer.insertSprite(spriteObj, index);

            // if autoRender, just do it
            if (autoRender) _spriteRenderer.render();
        }

        private function getSpriteFromObject(obj : Object) : DisplayObject {
            if (obj is String) {
                var clazz : Class = getDefinitionByName(String(obj)) as Class;
                return new clazz() as DisplayObject;
            } else if (obj is Class) {
                return new obj() as DisplayObject;
            } else {
                return obj as DisplayObject;
            }
        }

        /**
         * 计算显示元素的占位符的文本格式（若使用不同的占位符，可重写此方法）。
         * @param	width 宽度。
         * @param	height 高度。
         * @return
         */
        private function calcPlaceholderFormat(width : Number, height : Number) : TextFormat {
            var format : TextFormat = new TextFormat();
            format.color = _placeholderColor;
            format.size = height + 2 * _placeholderMarginV;

            // calculate placeholder text metrics with certain size to get actual letterSpacing
            _formatCalculator.setTextFormat(format);
            var metrics : TextLineMetrics = _formatCalculator.getLineMetrics(0);

            // letterSpacing is the key value for placeholder
            format.letterSpacing = width - metrics.width + 2 * _placeholderMarginH;
            format.underline = format.italic = format.bold = false;
            return format;
        }

        /**
         * 设置RichTextField的尺寸大小（长和宽）。
         * @param	width 宽度。
         * @param	height 高度。
         */
        public function setSize(width : Number, height : Number) : void {
            if (_width == width && _height == height) return;
            _width = width;
            _height = height;
            _textRenderer.width = _width;
            _textRenderer.height = _height;
            this.scrollRect = new Rectangle(0, 0, _width, _height);
            _spriteRenderer.render();
        }

        /**
         * 指示index参数指定的索引位置上是否为显示元素。
         * @param	index 指定的索引位置。
         * @return
         */
        public function isSpriteAt(index : int) : Boolean {
            if (index < 0 || index >= _textRenderer.length) return false;
            return _textRenderer.text.charAt(index) == _placeholder;
        }

        private function scrollHandler(e : Event) : void {
            _spriteRenderer.render();
        }

        private function changeHandler(e : Event) : void {
            var index : int = _textRenderer.caretIndex;
            var offset : int = _textRenderer.length - _textRenderer.oldLength;
            if (offset > 0) {
                _spriteRenderer.adjustSpritesIndex(index - 1, offset);
            } else {
                // remove sprites
                for (var i : int = index; i < index - offset; i++) {
                    _spriteRenderer.removeSprite(i);
                }
                _spriteRenderer.adjustSpritesIndex(index + offset, offset);
            }
            _spriteRenderer.render();
        }

        /**
         * 清除所有文本和显示元素。
         */
        public function clear() : void {
            _spriteRenderer.clear();
            _textRenderer.clear();
        }

        /**
         * 指示RichTextField的类型。
         * @default RichTextField.DYNAMIC
         */
        public function get type() : String {
            return _textRenderer.type;
        }

        public function set type(value : String) : void {
            _textRenderer.type = value;
            _textRenderer.addEventListener(Event.SCROLL, scrollHandler);
            if (value == INPUT) {
                _textRenderer.addEventListener(Event.CHANGE, changeHandler);
            }
        }

        /**
         * TextField实例。
         */
        public function get textfield() : TextField {
            return _textRenderer;
        }

        /**
         * 指示显示元素占位符的水平边距。
         * @default 1
         */
        public function set placeholderMarginH(value : int) : void {
            _placeholderMarginH = value;
        }

        /**
         * 指示显示元素占位符的垂直边距。
         * @default 0
         */
        public function set placeholderMarginV(value : int) : void {
            _placeholderMarginV = value;
        }

        /**
         * 返回RichTextField对象的可见宽度。
         */
        public function get viewWidth() : Number {
            return _width;
        }

        /**
         * 返回RichTextField对象的可见高度。
         */
        public function get viewHeight() : Number {
            return _height
        }

        /**
         * 返回文本字段中的内容（包括显示元素的占位符）。
         */
        public function get content() : String {
            return _textRenderer.text;
        }

        /**
         * 返回文字字段中的内容长度（包括显示元素的占位符）。
         */
        public function get contentLength() : int {
            return _textRenderer.length;
        }

        /**
         * 返回文本字段中的文本（不包括显示元素的占位符）。
         */
        public function get text() : String {
            return _textRenderer.text.split(_placeholder).join("");
        }

        /**
         * 返回文字字段中的文本长度（不包括显示元素的占位符）。
         */
        public function get textLength() : int {
            return _textRenderer.length - _spriteRenderer.numSprites;
        }

        /**
         * 返回由参数index指定的索引位置的显示元素。
         * @param	index
         * @return
         */
        public function getSprite(index : int) : DisplayObject {
            return _spriteRenderer.getSprite(index);
        }

        /**
         * 返回RichTextField中显示元素的数量。
         */
        public function get numSprites() : int {
            return _spriteRenderer.numSprites;
        }

        /**
         * 指定鼠标指针的位置。
         */
        public function get caretIndex() : int {
            return _textRenderer.caretIndex;
        }

        public function set caretIndex(index : int) : void {
            _textRenderer.setSelection(index, index);
        }

        /**
         * 指定文本字段的默认文本格式。
         */
        public function get defaultTextFormat() : TextFormat {
            return _textRenderer.defaultTextFormat;
        }

        public function set defaultTextFormat(format : TextFormat) : void {
            if (format.color != null) _placeholderColor = uint(format.color);
            _textRenderer.defaultTextFormat = format;
        }

        /**
         * 导出XML格式的RichTextField的文本和显示元素内容。
         * @return
         */
        public function exportXML() : XML {
            var xml : XML = <rtf/>;
            if (html) {
                xml.htmlText = _textRenderer.htmlText.split(_placeholder).join("");
            } else {
                xml["text"] = _textRenderer.text.split(_placeholder).join("");
            }

            xml.sprites = _spriteRenderer.exportXML();
            return xml;
        }

        /**
         * 导入指定XML格式的文本和显示元素内容。
         * @param	data 具有指定格式的XML内容。
         */
        public function importXML(data : XML) : void {
            var content : String = "";
            if (data.hasOwnProperty("htmlText")) content += data.htmlText;
            if (data.hasOwnProperty("text")) content += data.text;

            var sprites : Array = [];
            for (var i : int = 0; i < data.sprites.sprite.length(); i++) {
                var node : XML = data.sprites.sprite[i];
                var sprite : Object = {};
                sprite.src = String(node.@src);
                // correct the index if import as html
                if (html) sprite.index = int(node.@index) + 1;
                else sprite.index = int(node.@index);
                sprites.push(sprite);
            }
            append(content, sprites);
        }

        /**
         * 为RichTextField增加插件。
         * @param	plugin 要增加的插件。
         */
        public function addPlugin(plugin : IRTFPlugin) : void {
            plugin.setup(this);
            if (_plugins == null) _plugins = [];
            _plugins.push(plugin);
        }

        public function spriteOffsetY(value : Number) : void {
            _spriteRenderer.spriteOffsetY = value;
        }
    }
}