package com.newbye.utils
{
	import com.newbye.interfaces.IDisposable;

	/**
	 * @param object Object that would be disposed
	 * @return if the Object can be disposed, return true,or flase
	 */	
	public function dispose(object:Object):Boolean
	{
		var rb:Boolean = false;
		var disposable:IDisposable = object as IDisposable;
		
		if(disposable)
		{
			disposable.dispose();
			rb = true;
		}
		
		return rb;
	}
}