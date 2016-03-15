package com.newbye.framework.interfaces
{
	import com.newbye.interfaces.IDisposable;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	
	public interface IView extends IDisposable, IEventDispatcher
	{
		/**
		 * 指示指定对象的 Alpha 透明度值。有效值为 0（完全透明）到 1（完全不透明）。默认值为 1。alpha 设置为 0 的显示对象是活动的，即使它们不可见。 
		 * @return 
		 * 
		 */		
		function get alpha():Number;
		function set alpha(value:Number):void;

		/**
		 *BlendMode 类中的一个值，用于指定要使用的混合模式。内部绘制位图的方法有两种。如果启用了混合模式或外部剪辑遮罩，则将通过向矢量渲染器添加有位图填充的正方形来绘制位图。如果尝试将此属性设置为无效值，则 Flash Player 或 Adobe AIR 会将该值设置为 BlendMode.NORMAL。 

			blendMode 属性影响显示对象的每个像素。每个像素都由三种原色（红色、绿色和蓝色）组成，每种原色的值介于 0x00 和 0xFF 之间。Flash Player 或 Adobe AIR 将影片剪辑中一个像素的每种原色与背景中像素的对应颜色进行比较。例如，如果 blendMode 设置为 BlendMode.LIGHTEN，则 Flash Player 或 Adobe AIR 会将显示对象的红色值与背景的红色值进行比较，然后使用两者中较亮的一种颜色作为显示颜色的红色成分的值。 
		 * @return 
		 * 
		 */		
		function get blendMode():String;
		function set blendMode(value:String):void;

		/**
		 *如果设置为 true，则 Flash Player 或 Adobe AIR 将缓存显示对象的内部位图表示形式。此缓存可以提高包含复杂矢量内容的显示对象的性能。 

		具有已缓存位图的显示对象的所有矢量数据都将被绘制到位图而不是主显示。然后，将位图作为贴紧到最接近像素边界的未拉伸、未旋转的像素复制到主显示。像素按一对一与父对象进行映射。如果位图的边界发生更改，则将重新创建位图而不会拉伸它。
		
		除非将 cacheAsBitmap 属性设置为 true，否则不会创建内部位图。
		
		将 cacheAsBitmap 属性设置为 true 后，呈现并不更改，但是，显示对象将自动执行像素贴紧。动画速度可能会大大加快，具体取决于矢量内容的复杂性。 
		
		只要对显示对象（当其 filter 数组不为空时）应用滤镜，cacheAsBitmap 属性就自动设置为 true，而且如果对显示对象应用了滤镜，即使将该属性设置为 false，也会将该显示对象的 cacheAsBitmap 报告为 true。如果清除显示对象的所有滤镜，则 cacheAsBitmap 设置将更改为它上次的设置。
		
		在下面的情况下，即使将 cacheAsBitmap 属性设置为 true，显示对象也不使用位图，而是从矢量数据呈现：
		
		位图过大：在任一方向上大于 2880 像素。 
		位图无法分配（内存不足错误）。 
		最好将 cacheAsBitmap 属性与主要具有静态内容且不频繁缩放和旋转的影片剪辑一起使用。对于这样的影片剪辑，在转换影片剪辑时（更改其 x 和 y 位置时），cacheAsBitmap 可以提高性能。
		 
		 * 
		 */			
		function get cacheAsBitmap():Boolean;
		function set cacheAsBitmap(value:Boolean):void;
		
		/**
		 *包含当前与显示对象关联的每个滤镜对象的索引数组。flash.filters 包中的多个类定义了可使用的特定滤镜。 

		在设计时可以在 Flash 创作工具中应用滤镜，而在运行时则可以使用 ActionScript 代码应用滤镜。若要通过使用 ActionScript 应用滤镜，您必须制作整个 filters 数组的临时副本，修改临时数组，然后将临时数组的值分配回 filters 数组。无法直接将新滤镜对象添加到 filters 数组。
		
		要通过使用 ActionScript 添加滤镜，请执行以下步骤（假定目标显示对象名为 myDisplayObject）：
		
		使用所选滤镜类的构造函数方法创建一个新的滤镜对象。
		将 myDisplayObject.filters 数组的值分配给临时数组，例如一个名为 myFilters 的数组。
		将新的滤镜对象添加到临时数组 myFilters。
		将临时数组的值分配给 myDisplayObject.filters 数组。
		如果 filters 数组未定义，则无需使用临时数组。相反，您可以直接赋值包含一个或多个已创建的滤镜对象的一个数组文本值。“示例”部分的第一个示例通过使用处理已定义和未定义的 filters 数组的代码来添加投影滤镜。
		
		要修改现有的滤镜对象，必须使用修改 filters 数组的副本的技术：
		
		将 filters 数组的值分配给临时数组，例如一个名为 myFilters 的数组。
		使用临时数组 myFilters 修改属性。例如，如果要设置数组中第一个滤镜的品质属性，可以使用以下代码：myFilters[0].quality = 1;
		将临时数组的值分配给 filters 数组。
		在加载时，如果显示对象具有关联的滤镜，则将它标记为像透明位图那样缓存自身。从此时起，只要显示对象具有有效的滤镜列表，播放器就会将显示对象缓存为位图。此源位图用作滤镜效果的源图像。每个显示对象通常有两个位图：一个包含原始未过滤的源显示对象，另一个是过滤后的最终图像。呈现时使用最终图像。只要显示对象不发生更改，最终图像就不需要更新。

		 * 
		 */		
		function get filters():Array;
		function set filters(value:Array):void;

		/**
		 *指示显示对象的高度，以像素为单位。高度是根据显示对象内容的范围来计算的。如果您设置了 height 属性，则 scaleY 属性会相应调整，如以下代码所示： 

		 var rect:Shape = new Shape();
		 rect.graphics.beginFill(0xFF0000);
		 rect.graphics.drawRect(0, 0, 100, 100);
		 trace(rect.scaleY) // 1;
		 rect.height = 200;
		 trace(rect.scaleY) // 2;除 TextField 和 Video 对象以外，没有内容的显示对象（如一个空的 Sprite）的高度为 0，即使您尝试将 height 设置为其它值，也是这样。
		 * 
		 */		
		function get height():Number;
		function set height(value:Number):void;

		/**
		 *返回一个 LoaderInfo 对象，其中包含加载此显示对象所属的文件的相关信息。loaderInfo 属性仅为 SWF 文件的根显示对象或已加载的位图（而不是使用 ActionScript 绘制的位图）定义。要查找与包含名为 myDisplayObject 的显示对象的 SWF 文件相关的 loaderInfo 对象，请使用 myDisplayObject.root.loaderInfo。 

			大的 SWF 文件可以通过调用 this.root.loaderInfo.addEventListener(Event.COMPLETE, func) 来监控其下载。
		 * 
		 */		
		function get loaderInfo():LoaderInfo;

		/**
		 *调用显示对象被指定的 mask 对象遮罩。要确保当舞台缩放时蒙版仍然有效，mask 显示对象必须处于显示列表的活动部分。但不绘制 mask 对象本身。将 mask 设置为 null 可删除蒙版。 
		
		要能够缩放遮罩对象，它必须在显示列表中。要能够拖动蒙版 Sprite 对象（通过调用其 startDrag() 方法），它必须在显示列表中。要为基于 sprite 正在调度的 mouseDown 事件调用 startDrag() 方法，请将 sprite 的 buttonMode 属性设置为 true。
		 * 
		 */		
		function get mask():DisplayObject;
		function set mask(value:DisplayObject):void;

		/**
		 *指示鼠标位置的 x 坐标，以像素为单位。  
		 * 
		 */		
		function get mouseX():Number;
		
		/**
		 *指示鼠标位置的 y 坐标，以像素为单位。 
		 * 
		 */		
		function get mouseY():Number;

		/**
		 *指示 DisplayObject 的实例名称。通过调用父显示对象容器的 getChildByName() 方法，可以在父显示对象容器的子列表中标识该对象。  
		 */		
		function get name():String;
		function set name(value:String):void;

		/**
		 *指定显示对象是否由于具有某种背景颜色而不透明。透明的位图包含 Alpha 通道数据，并以透明的方式进行绘制。不透明位图没有 Alpha 通道（呈现速度比透明位图快）。如果位图是不透明的，则您可以指定要使用的其自己的背景颜色。 

		如果设置为某个数值，则表面是不透明的，并且带有该数值指定的 RGB 背景颜色。如果设置为 null（默认值），则显示对象将有透明背景。
		
		opaqueBackground 属性主要与 cacheAsBitmap 属性一起使用，以优化呈现。对于 cacheAsBitmap 属性设置为 true 的显示对象，设置 opaqueBackground 可以提高呈现性能。
		
		如果在 shapeFlag 参数设置为 true 时调用 hitTestPoint() 方法，则不透明的背景区域不 匹配。
		 * 
		 */		
		function get opaqueBackground():Object;
		function set opaqueBackground(value:Object):void;

		/**
		 *指示包含此显示对象的 DisplayObjectContainer 对象。使用 parent 属性可以指定高于显示列表层次结构中当前显示对象的显示对象的相对路径。 

		可以使用 parent 在显示列表中上移多个级别，如下所示：
		
		     this.parent.parent.alpha = 20;
		 */		
		function get parent():DisplayObjectContainer;

		/**
		 *对于加载的 SWF 文件中的显示对象，root 属性是此 SWF 文件所表示的显示列表树结构部分中的顶级显示对象。对于代表已加载图像文件的位图对象，root 属性就是位图对象本身。对于第一个加载的 SWF 文件的主类的实例，root 属性就是显示对象本身。Stage 对象的 root 属性是 Stage 对象本身。对于任何未添加到显示列表的显示对象，root 属性设置为 null，除非它已添加到符合以下条件的显示对象容器：不在显示列表中，但属于已加载 SWF 文件中顶级显示对象的子级。 

		例如，如果您通过调用 Sprite() 构造函数方法创建新的 Sprite 对象，则其 root 属性将为 null，除非您将其添加到显示列表中（或添加到不在显示列表中但属于 SWF 文件中顶级显示对象的子级的显示对象容器中）。
		
		对于加载的 SWF 文件，即使用于加载文件的 Loader 对象未在显示列表中，SWF 文件中的顶级显示对象也会为其本身设置 root 属性。在 Loader 对象添加为对其设置 root 属性的显示对象的子级前，它不会设置自己的 root 属性。
		 * 
		 */		
		function get root():DisplayObject;

		/**
		 *指示 DisplayObject 实例距其原始方向的旋转程度，以度为单位。从 0 到 180 的值表示顺时针方向旋转；从 0 到 -180 的值表示逆时针方向旋转。对于此范围之外的值，可以通过加上或减去 360 获得该范围内的值。例如，my_video.rotation = 450语句与 my_video.rotation = 90 是相同的。 
		 * 
		 */		
		function get rotation():Number;
		function set rotation(value:Number):void;

		function get scale9Grid():Rectangle;
		function set scale9Grid(value:Rectangle):void;

		function get scaleX():Number;
		function set scaleX(value:Number):void;

		function get scaleY():Number;
		function set scaleY(value:Number):void;

		function get scrollRect():Rectangle;
		function set scrollRect(value:Rectangle):void;

		function get stage():Stage;
		
		function get transform():Transform;
		function set transform(value:Transform):void;

		function get visible():Boolean;
		function set visible(value:Boolean):void;
		
		function get width():Number;
		function set width(value:Number):void;

		function get x():Number;
		function set x(value:Number):void;
		
		function get y():Number;
		function set y(value:Number):void;

		function getBounds(targetCoordinateSpace:DisplayObject):Rectangle;
		function getRect(targetCoordinateSpace:DisplayObject):Rectangle;
		
		function globalToLocal(point:Point):Point;
		function hitTestObject(obj:DisplayObject):Boolean;
		
		function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false):Boolean;
		
		function localToGlobal(point:Point):Point;

	}
}