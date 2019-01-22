/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 18.10.12
 */
package com.grom.tilemap
{
public class TileProperty
{
	private var _name:String;
	private var _value:String;

	public function TileProperty(name:String, value:String)
	{
		_name = name;
		_value = value;
	}

	public function get name():String
	{
		return _name;
	}

	public function get value():String
	{
		return _value;
	}

	public function set value(value:String):void
	{
		_value = value;
	}

	public function clone():TileProperty
	{
		return new TileProperty(name, value);
	}
}
}
