/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 01.03.13
 */
package com.grom.starlingUtils.layout.builders
{
import com.grom.starlingUtils.display.UImage;
import com.grom.starlingUtils.layout.LayoutUtils;
import com.grom.starlingUtils.layout.items.ImageWrapper;

import starling.display.DisplayObject;
import starling.display.Image;

public class ImageBuilder implements ILayoutItemBuilder
{
	public function ImageBuilder()
	{
	}

	public function create(source:XML):DisplayObject
	{
		var img:Image = UImage.create(source["@class"]);
		var sprite:ImageWrapper = new ImageWrapper(img);
		sprite.touchable = false;
		LayoutUtils.copyParams(source, sprite);
		return sprite;
	}
}
}
