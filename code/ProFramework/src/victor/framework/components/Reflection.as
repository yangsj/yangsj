package victor.framework.components
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-27
	 */
	public class Reflection
	{

		public static function reflection( target:Object, skin:DisplayObject ):void
		{
			var skinContainer:DisplayObjectContainer = skin as DisplayObjectContainer;
			if ( skinContainer == null )
			{
				return;
			}
			var xml:XML = describeType( target );
			var variables:XMLList = xml.child( "variable" );
			var name:String;
			var tmp:DisplayObject;
			for each ( var item:XML in variables )
			{
				name = item.@name.toString();
				try
				{
					tmp = skinContainer.getChildByName( name );
					if ( tmp )
					{
						target[ name ] = tmp;
					}
				}
				catch ( e:Error )
				{
					trace( "[Reflection.reflection]" + name + ":" + e );
					continue;
				}
			}
		}
	}
}
