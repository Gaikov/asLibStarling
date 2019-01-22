/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 3.3.12
 */
package com.grom.tilemap
{
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;

import net.maygem.lib.graphics.bitmap.MoviesCache;

public class TileMapLayer
{
	private var _tilesInfo:Array = [];
	private var _name:String;
	
	public function TileMapLayer(xml:XML)
	{
		_name = xml.@name;
		for each (var tile:XML in xml.tile)
		{
			_tilesInfo.push(new TileInfo(tile));
		}
	}

	public function get tilesInfo():Array
	{
		return _tilesInfo;
	}

	public function get name():String
	{
		return _name;
	}

	public function createWithCachedTiles(cellSize:int):DisplayObject
	{
		var res:Sprite = new Sprite();
		for each (var info:TileInfo in _tilesInfo)
		{
			var view:DisplayObject = info.createView();
			if (view is MovieClip && MovieClip(view).totalFrames > 1)
			{
				view = MoviesCache.instance.getMovie(info.classView);
			}
			else
			{
				view = MoviesCache.instance.getSprite(info.classView);
			}
			view.x = info.x * cellSize;
			view.y = info.y * cellSize;
			res.addChild(view);
		}
		return res;
	}
}
}
