/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 3.3.12
 */
package com.grom.tilemap
{
public class TileMapRoomData
{
	private var _layers:Array = [];
	private var _width:int;
	private var _height:int;
	
	public function TileMapRoomData(xml:XML)
	{
		_width = xml.@width;
		_height = xml.@height;
		
		for each (var layer:XML in xml.layer)
		{
			_layers.push(new TileMapLayer(layer));
		}
	}

	public function get layers():Array
	{
		return _layers;
	}

	public function get width():int
	{
		return _width;
	}

	public function get height():int
	{
		return _height;
	}

	public function getLayerByName(name:String):TileMapLayer
	{
		for each (var layer:TileMapLayer in layers)
		{
			if (layer.name == name)
				return layer;
		}
		return null;
	}
}
}
