/**
 * Created by IntelliJ IDEA.
 * User: Roman Gaikov
 * Date: 16.04.12
 */
package com.grom.ui.radioButtons
{
import flash.events.EventDispatcher;
import flash.events.MouseEvent;

public class RadioGroup extends EventDispatcher
{
	private var _buttons:Array = [];
	private var _active:IRadioButton;

	public function RadioGroup()
	{
	}

	public function get active():IRadioButton
	{
		return _active;
	}
	
	public function get activeIndex():int
	{
		for (var i:int = 0; i < _buttons.length; i++)
		{
			if (_active == _buttons[i])
				return i;
		}
		return -1;
	}

	public function get buttons():Array
	{
		return _buttons.concat();
	}

	public function addButton(button:IRadioButton):void
	{
		_buttons.push(button);
		button.asView().addEventListener(MouseEvent.CLICK, onButtonClick);
	}

	public function getByIndex(buttonIndex:int):IRadioButton
	{
		return _buttons[buttonIndex];
	}

	private function onButtonClick(event:MouseEvent):void
	{
		for each (var button:IRadioButton in _buttons)
		{
			if (button.asView() == event.target)
			{
				setActive(button);
				return;
			}
		}
	}

	private function setActive(button:IRadioButton):void
	{
		if (button != _active)
		{
			if (_active)
			{
				_active.active = false;
			}
			_active = button;
			_active.active = true;
			dispatchEvent(new RadioGroupEvent(RadioGroupEvent.CHANGED))
		}
	}

	public function setActiveByIndex(index:int):void
	{
		setActive(getByIndex(index));
	}
}
}
