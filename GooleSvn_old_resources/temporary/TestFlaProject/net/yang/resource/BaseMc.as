package net.yang.resource
{
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class BaseMc extends MovieClip
	{
		protected var _markID:int = 0;
		protected var _txtf:TextField;
		
		private var _rowV:int;
		private var _rowH:int;
		private var _moveRowV:int;
		private var _moveRowH:int;
		private var _rowStartV:int;
		private var _rowStartH:int;

		public function BaseMc()
		{
			this.mouseChildren = false;
			this.buttonMode = true;
		}
		/**
		* id号，用于识别的唯一的
		*/
		public function get markID():int
		{
			return _markID;
		}
		
		/**
		* 行数  行序号
		*/
		public function get rowV():int
		{
			return _rowV;
		}
		
		/**
		* @private
		*/
		public function set rowV(value:int):void
		{
			_rowV = value;
		}
		
		/**
		* 列数 列序号
		*/
		public function get rowH():int
		{
			return _rowH;
		}
		
		/**
		* @private
		*/
		public function set rowH(value:int):void
		{
			_rowH = value;
		}
		
		/**
		* 移动的行数
		*/
		public function get moveRowV():int
		{
			return _moveRowV;
		}
		
		/**
		* @private
		*/
		public function set moveRowV(value:int):void
		{
			_moveRowV = value;
		}
		
		/**
		* 移动的列数
		*/
		public function get moveRowH():int
		{
			return _moveRowH;
		}
		
		/**
		* @private
		*/
		public function set moveRowH(value:int):void
		{
			_moveRowH = value;
		}
		
		/**
		* 起始 所在的行数
		*/
		private function get rowStartV():int
		{
			return _rowStartV;
		}
		
		/**
		* @private
		*/
		public function set rowStartV(value:int):void
		{
			_rowStartV = value;
		}
		
		/**
		* 起始 所在的列数
		*/
		private function get rowStartH():int
		{
			return _rowStartH;
		}
		
		/**
		* @private
		*/
		public function set rowStartH(value:int):void
		{
			_rowStartH = value;
		}
		
		public function setRow(rowV:int, rowH:int):void
		{
			_rowV = rowV;
			_rowH = rowH;
		}
		
		public function get txt():TextField
		{
			return _txtf;
		}

	}

}