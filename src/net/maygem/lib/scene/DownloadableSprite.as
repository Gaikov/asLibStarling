package net.maygem.lib.scene
{
import flash.display.DisplayObject;
import flash.display.Sprite;

import net.maygem.lib.resources.ResourceLoader;
import net.maygem.lib.utils.UDisplay;

public class DownloadableSprite extends Sprite
{
	public function DownloadableSprite(swfUrl:String, className:String)
	{
		super();

		var classID:String = swfUrl + "_DownloadableSprite";
		if (!createView(ResourceLoader.instance().getDisplayClass(classID)))
			ResourceLoader.instance().loadDisplayClass(swfUrl, className, classID, onLoadComplete);
	}

	private function onLoadComplete(data:*):void
	{
		createView(data);
	}

	public function createView(data:*):Boolean
	{
		var cls:Class = data as Class;
		if (cls)
		{
			var obj:DisplayObject = new cls();
			addChild(obj);
			UDisplay.placeAtOrigin(obj, -obj.width / 2, -obj.height / 2);
			return true;
		}
		return false;
	}
}
}