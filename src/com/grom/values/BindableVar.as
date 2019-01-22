/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 04.07.12
 */
package com.grom.values
{
public class BindableVar
{
	private var _value:*;
	private var _handlers:Array = [];

	public function BindableVar(defValue:*)
	{
		_value = defValue;
	}

	public function addHandler(handler:Function):void
	{
		_handlers.push(handler);
	}

	public function get value():*
	{
		return _value;
	}

	public function set value(value:*):void
	{
		if (_value != value)
		{
			_value = value;
			for each (var h:Function in _handlers)
			{
				h(_value);
			}
		}
	}
}
}
