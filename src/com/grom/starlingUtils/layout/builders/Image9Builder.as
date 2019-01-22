/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 04.03.13
 */
package com.grom.starlingUtils.layout.builders
{
import com.grom.starlingUtils.assets.AssetLoader;
import com.grom.starlingUtils.layout.LayoutUtils;

import feathers.display.Scale9Image;
import feathers.textures.Scale9Textures;

import flash.geom.Rectangle;

import starling.display.DisplayObject;

public class Image9Builder implements ILayoutItemBuilder
{
	public function Image9Builder()
	{
	}

	public function create(source:XML):DisplayObject
	{
		var rect:Rectangle = new Rectangle(source.@gridLeft, source.@gridTop, source.@gridWidth, source.@gridHeight);
		var tex:Scale9Textures = new Scale9Textures(AssetLoader.instance.getSubTexture(source["@class"]), rect);
		
		var image:Scale9Image = new Scale9Image(tex);
		LayoutUtils.copyParamsNoScale(source, image);

		image.width = image.width * source.@sx;
		image.height = image.height * source.@sy;

		return image;
	}
}
}
