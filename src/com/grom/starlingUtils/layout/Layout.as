/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 28.02.13
 */
package com.grom.starlingUtils.layout
{
import com.grom.airLib.utils.UFile;
import com.grom.starlingUtils.display.DisplayUtils;
import com.grom.starlingUtils.layout.builders.ILayoutItemBuilder;
import com.grom.starlingUtils.layout.builders.LayoutRegistry;

import flash.filesystem.File;

import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import starling.display.Sprite;

public class Layout extends Sprite
{
	public function Layout(xml:XML)
	{
		var c:DisplayObject = createView(xml);
		addChild(c);
		createChildren(c, xml);
	}

	private function createChildren(obj:DisplayObject, xml:XML):void
	{
		var c:DisplayObjectContainer = obj as DisplayObjectContainer;

		if (c)
		{
			for each (var childXML:XML in xml.*)
			{
				var child:DisplayObject = createView(childXML);
				if (child)
				{
					c.addChild(child);
					if (child is DisplayObjectContainer)
					{
						createChildren(DisplayObjectContainer(child), childXML);
					}
				}
			}
		}
	}

	private function createView(xml:XML):DisplayObject
	{
		var tagName:String = String(xml.name());
		var builder:ILayoutItemBuilder = LayoutRegistry.instance.getByTag(tagName);
		if (builder)
		{
			return builder.create(xml);
		}
		return null;
	}

	private static var _layoutCached:Object = {};

	static public function createLayout(fileName:String, className:String):Layout
	{
		var layouts:XML = _layoutCached[fileName] as XML;
		if (!layouts)
		{
			layouts = UFile.readXML(File.applicationDirectory.resolvePath(fileName));
			_layoutCached[fileName] = layouts;
		}

		//TODO: need cache for speedup
		for each (var xml:XML in layouts.image)
		{
			if (xml["@class"] == className)
			{
				return new Layout(xml);
			}
		}

		return null;
	}

	public function findChild(name:String):DisplayObject
	{
		return DisplayUtils.findChildInDepth(name, this);
	}

	static public function create(layoutClass:String):Layout
	{
		return createLayout("assets/layouts.xml", layoutClass);
	}


}
}
