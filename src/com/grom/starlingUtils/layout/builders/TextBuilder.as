/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 01.03.13
 */
package com.grom.starlingUtils.layout.builders
{
import com.grom.starlingUtils.layout.LayoutUtils;

import starling.display.DisplayObject;
import starling.text.TextField;
import starling.utils.VAlign;

public class TextBuilder implements ILayoutItemBuilder
{
	public function TextBuilder()
	{
	}

	public function create(source:XML):DisplayObject
	{
		var fontName:String = source.@font + "_" + source.@fontSize + "_" + source.@color;
		var field:TextField = new TextField(source.@width, source.@height, "", fontName, source.@fontSize, 0xffffff);
		field.text = source.@label;
		field.vAlign = VAlign.CENTER;
		field.hAlign = source.@align;
		//field.border = true;
		field.touchable = false;
		LayoutUtils.copyParams(source, field);
		return field;
	}
}
}
