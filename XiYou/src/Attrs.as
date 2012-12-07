package
{
	import character.PawnAttr;


	/**
	 * 人物属性的资源类，用Attrs.instance.getAttrById获取特定ID的人物属性
	 * @author Chenzhe
	 */
	public class Attrs
	{

		[Embed(source = "../asset/attr.xml", mimeType = "application/octet-stream")]
		/**
		 *
		 * @default
		 */
		public var attrs : Class;
		private var xml : XML = XML(new attrs);

		/**
		 *
		 * @default
		 */
		public static const instance : Attrs = new Attrs();

		/**
		 * 获取特定ID的人物属性
		 * @param id 人物ID
		 * @return 人物属性
		 */
		public function getAttrById(id : String) : PawnAttr
		{
			var attrXML : XMLList = xml..attr.(@id == id);
			var attr : PawnAttr = new PawnAttr();
			attr.id = id;
			for each (var i : XML in attrXML.*)
			{
				attr[i.name()] = format(i);
			}
			return attr;
		}

		private function format(s : String) : *
		{
			if (s.charAt(s.length - 1) == '%')
			{
				var num : Number = Number(s.substring(0, s.length - 1));
				return num / 100;
			}
			return s;
		}
	}
}
