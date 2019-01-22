/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 01.03.13
 */
package com.grom.starlingUtils.popups
{
import com.grom.starlingUtils.display.DisplayUtils;
import com.grom.starlingUtils.layout.Layout;
import com.grom.starlingUtils.layout.items.ImageWrapper;
import com.grom.starlingUtils.layout.movie.MovieWrapper;

import feathers.controls.text.TextFieldTextEditor;

import starling.display.Button;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Sprite;
import starling.text.TextField;

public class LayoutDecorator extends Sprite
{
	private var _layout:Layout;

	public function LayoutDecorator(layoutClass:String)
	{
		_layout = Layout.createLayout("assets/layouts.xml", layoutClass);
		addChild(_layout);
	}

	final public function button(name:String):Button
	{
		return Button(findChild(name));
	}

	final public function textField(name:String):TextField
	{
		return TextField(findChild(name));
	}

	final public function inputField(name:String):TextFieldTextEditor
	{
		return TextFieldTextEditor(findChild(name));
	}

	final public function image(name:String):Image
	{
		return ImageWrapper(findChild(name)).image;
	}

	final public function movieWrapper(name:String):MovieWrapper
	{
		return MovieWrapper(findChild(name));
	}

	final public function findChild(name:String):DisplayObject
	{
		return DisplayUtils.findChildInDepth(name, _layout);
	}


}
}
