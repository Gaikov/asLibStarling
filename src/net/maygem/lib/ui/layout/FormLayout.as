package net.maygem.lib.ui.layout
{
import flash.display.DisplayObject;
import flash.display.Sprite;

public class FormLayout extends Sprite implements ILayout
{
	private var _form:Array = [];
	private var _horizontalGap:int;
	private var _verticalGap:int;

	public function FormLayout(horizontalGap:int, verticalGap:int)
	{
		super();
		_horizontalGap = horizontalGap;
		_verticalGap = verticalGap;
	}

	public function addPair(label:DisplayObject, control:DisplayObject, id:String):void
	{
		_form.push(new FormLayoutPair(label, control));
		addChild(label);
		addChild(control);
	}

	public function updateLayout():void
	{
		LayoutUtils.layoutForm(_form, _horizontalGap, _verticalGap);
	}
}
}