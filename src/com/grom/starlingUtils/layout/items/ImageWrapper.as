/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 04.03.13
 */
package com.grom.starlingUtils.layout.items
{
import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Sprite;

public class ImageWrapper extends Sprite
{
	private var _image:Image;

	public function ImageWrapper(image:Image)
	{
		_image = image;
		addChild(_image);
	}

	override public function set touchable(value:Boolean):void
	{
		_image.touchable = value;
	}

	public function get image():Image
	{
		return _image;
	}

	override public function getChildByName(name:String):DisplayObject
	{
		return super.getChildByName(name);
	}
}
}
