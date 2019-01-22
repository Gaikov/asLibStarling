package net.maygem.lib.ui.layout
{
import flash.display.DisplayObject;

public class FormLayoutPair
{
	private var _label:DisplayObject;
	private var _control:DisplayObject;

	public function FormLayoutPair(label:DisplayObject, control:DisplayObject)
	{
		_label = label;
		_control = control;
	}

	public function get label():DisplayObject
	{
		return _label;
	}

	public function get control():DisplayObject
	{
		return _control;
	}
}
}