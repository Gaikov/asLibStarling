/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 18.10.12
 */
package com.grom.tilemap
{
public class TilePropertyList
{
	private var _list:Array = [];

	public function TilePropertyList()
	{
	}

	public function add(name:String, value:String):void
	{
		_list.push(new TileProperty(name, value));
	}

	public function getValue(name:String):String
	{
		for each (var p:TileProperty in _list)
		{
			if (p.name == name)
			{
				return p.value;
			}
		}
		return null;
	}

	public function clone():TilePropertyList
	{
		var out:TilePropertyList = new TilePropertyList();
		for each (var p:TileProperty in _list)
		{
			out._list.push(p.clone());
		}
		return out;
	}

	public function toXML():XML
	{
		var xml:XML = <properties/>;
		for each (var p:TileProperty in _list)
		{
			xml.appendChild(<property name={p.name} value={p.value}/>);
		}
		return xml;
	}

	public function toArray():Array
	{
		return _list;
	}

	public function fromXML(xml:XML):void
	{
		for each (var p:XML in xml.property)
		{
			_list.push(new TileProperty(p.@name, p.@value));
		}
	}
}
}
