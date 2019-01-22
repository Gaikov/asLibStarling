package net.maygem.lib.scene
{
import flash.display.DisplayObject;
import flash.display.Sprite;

import net.maygem.lib.utils.UDisplay;

public class ImageWrapper extends Sprite
{
	public function ImageWrapper(classOrImage:Object, scale:Number = 1)
	{
		super();
		var img:DisplayObject = classOrImage as DisplayObject;
		if (!img)
		{
			var cls:Class = Class(classOrImage);
			img = new cls();
		}

		img.scaleX = img.scaleY = scale;
		addChild(img);
		UDisplay.placeAtOrigin(img, 0, 0);
	}
}
}