/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 5.3.12
 */
package com.grom.tilemap
{
import flash.display.DisplayObject;
import flash.display.Sprite;

import net.maygem.lib.graphics.bitmap.CachedFrame;

public class TilesLayerView extends Sprite
{
	public function TilesLayerView(model:TileMapLayer, cellSize:int)
	{
		mouseChildren = false;
		mouseEnabled = false;

		for each (var info:TileInfo in model.tilesInfo)
		{
			var tile:DisplayObject = info.createView();
			tile.x = cellSize * info.x;
			tile.y = cellSize * info.y;
			addChild(tile);
		}
	}

	static public function createCached(model:TileMapLayer, cellSize:int):Sprite
	{
		var view:TilesLayerView = new TilesLayerView(model, cellSize);
		return CachedFrame.renderObject(view).createSprite();
	}
}
}
