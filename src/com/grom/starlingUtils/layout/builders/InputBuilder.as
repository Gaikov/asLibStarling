/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 06.03.13
 */
package com.grom.starlingUtils.layout.builders
{
import com.grom.starlingUtils.layout.LayoutUtils;

import feathers.controls.text.TextFieldTextEditor;

import flash.text.TextFormat;

import starling.display.DisplayObject;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class InputBuilder implements ILayoutItemBuilder
{
	public function InputBuilder()
	{
	}

	public function create(source:XML):DisplayObject
	{
		var field:TextFieldTextEditor = new TextFieldTextEditor();
		field.text = source.@label;

		var fmt:TextFormat = new TextFormat();
		fmt.align = source.@align;
		fmt.font = source.@font;
		fmt.size = source.@fontSize;
		fmt.color = uint("0x" + source.@color);
		field.textFormat = fmt;

		field.width = source.@width;
		field.height = source.@height;

		LayoutUtils.copyParams(source, field);


		field.addEventListener(TouchEvent.TOUCH, function(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(field);
			if (touch && touch.phase == TouchPhase.ENDED)
			{
				field.setFocus();
			}
		});

		return field;
	}
}
}

/*
private function onTouchField(event:TouchEvent):void
{
	Log.info("touch name");
	var touch:Touch = event.getTouch(_inputField);
	if (touch && touch.phase == TouchPhase.ENDED)
	{
		_inputField.setFocus();
	}
}
*/
