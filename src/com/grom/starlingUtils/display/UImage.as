/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 28.02.13
 */
package com.grom.starlingUtils.display
{
import com.grom.starlingUtils.assets.AssetLoader;
import com.grom.starlingUtils.layout.items.ImageFixed;

import starling.display.Image;

public class UImage
{
	static public function create(subtextureName:String):Image
	{
		return new ImageFixed(AssetLoader.instance.getSubTexture(subtextureName));
	}

}
}
