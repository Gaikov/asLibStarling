package net.maygem.lib.ui.buttons
{
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;

public class SimpleCheckButton extends Sprite
{
	private var _back:DisplayObject;
	private var _check:DisplayObject;

	public function SimpleCheckButton(backClass:Class, checkClass:Class)
	{
		super();
		mouseChildren = false;

		_back = new backClass();
		addChild(_back);

		_check = new checkClass();
		_check.visible = false;
		addChild(_check);

		addEventListener(MouseEvent.CLICK, onClick);
	}

	public function get selected():Boolean
	{
		return _check.visible;
	}

	public function set selected(value:Boolean):void
	{
		_check.visible = value;
	}

	private function onClick(event:MouseEvent):void
	{
		selected = !selected;
	}
}
}