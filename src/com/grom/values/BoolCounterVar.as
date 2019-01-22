/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 26.06.12
 */
package com.grom.values
{
public class BoolCounterVar
{
	private var _counter:int = 0;
	
	public function BoolCounterVar()
	{
	}

	public function clear():void
	{
		_counter = 0;
	}

	public function set value(v:Boolean):void
	{
		if (v)
		{
			_counter ++;
		}
		else
		{
			_counter --;
			if (_counter < 0)
				throw new Error("invalid MultiBool set");
		}
	}

	public function get value():Boolean
	{
		return _counter > 0;
	}
}
}
