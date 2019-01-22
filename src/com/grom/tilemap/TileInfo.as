/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 3.3.12
 */
package com.grom.tilemap
{
import flash.display.DisplayObject;
import flash.geom.Point;
import flash.utils.getDefinitionByName;

public class TileInfo
{
	private var _x:int;
	private var _y:int;
	private var _className:String;
	private var _properties:TilePropertyList;
	
	public function TileInfo(xml:XML)
	{
		_x = xml.@x;
		_y = xml.@y;
		_className = xml.@class_name;
		if (xml.hasOwnProperty("properties"))
		{
			_properties = new TilePropertyList();
			_properties.fromXML(xml.properties[0]);
		}
	}

	public function get pos():Point
	{
		return new Point(_x, _y);
	}

	public function get properties():TilePropertyList
	{
		return _properties;
	}

	public function get x():int
	{
		return _x;
	}

	public function get y():int
	{
		return _y;
	}

	public function get className():String
	{
		return _className;
	}
	
	public function get classView():Class
	{
		return Class(getDefinitionByName(_className));
	}
	
	public function createView():DisplayObject
	{
		var cls:Class = Class(getDefinitionByName(_className));
		var obj:DisplayObject = new cls();
		return obj;
	}
}
}
