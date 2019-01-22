/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 01.03.13
 */
package com.grom.starlingUtils.layout.builders
{
import com.grom.starlingUtils.assets.AssetLoader;
import com.grom.starlingUtils.layout.LayoutUtils;

import starling.display.Button;
import starling.display.DisplayObject;
import starling.textures.Texture;

public class ButtonBuilder implements ILayoutItemBuilder
{
	public function ButtonBuilder()
	{
	}

	public function create(source:XML):DisplayObject
	{
		var className:String = source["@class"];
		var frames:Vector.<Texture> = AssetLoader.instance.getFrames(className);
		var upState:Texture = frames[0];
		var downState:Texture = frames.length >= 3 ? frames[2] : frames[1];

		var button:Button = new Button(upState, "", downState);
		LayoutUtils.copyParams(source, button);
		return button;
	}
}
}
