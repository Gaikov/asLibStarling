/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 3.3.12
 */
package com.grom.tilemap
{
public class TileMapData
{
	private var _rooms:Array = [];
	private var _backColor:uint;
	
	public function TileMapData(xml:XML)
	{
		_backColor = xml.@back_color;
		for each (var room:XML in xml.room)
		{
			_rooms.push(new TileMapRoomData(room));
		}
	}

	public function get backColor():uint
	{
		return _backColor;
	}

	public function get rooms():Array
	{
		return _rooms;
	}
}
}
