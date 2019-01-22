package net.maygem.lib.ui.tabs
{
import flash.display.DisplayObject;

import flash.display.Sprite;

import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import flash.text.TextFormat;

import net.maygem.lib.utils.UDisplay;
import net.maygem.lib.utils.UFont;

internal class TabView extends Sprite
{
	private var _label:TextField = new TextField();
	private var _format:TextFormat;
	private var _skinUp:DisplayObject;
	private var _skinSelectedUp:DisplayObject;
	private var _selected:Boolean;
	private var _onClickCallback:Function;

	private var _width:int;
	private var _textPaddings:int;

	private var _style:TabsNavigatorStyle;

	private var _enabled:Boolean = true;

	public function TabView(style:TabsNavigatorStyle, onClickCallback:Function):void
	{
		super();
		buttonMode = true;
		mouseChildren = false;
		_style = style;
		_textPaddings = style.tabTextPaddings;
		_format = new TextFormat();
		_format.font = style.fontFamily;
		_format.size = style.fontSize;
		_format.bold = style.fontBold;
		_label.embedFonts = UFont.isEmbedded(style.fontFamily);
		_label.defaultTextFormat = _format;
		_label.autoSize = TextFieldAutoSize.LEFT;
		_label.mouseEnabled = false;
		_label.selectable = false;
		_onClickCallback = onClickCallback;

		_skinUp = new style.tabPassive();
		addChild(_skinUp);
		_width = _skinUp.width;
		_skinSelectedUp = new style.tabActive();
		addChild(_skinSelectedUp);
		addChild(_label);

		addEventListener(MouseEvent.CLICK, onClick);

		updateLayout();
	}

	public function get enabled():Boolean
	{
		return _enabled;
	}

	public function set enabled(value:Boolean):void
	{
		_enabled = value;
	}

	override public function get width():Number
	{
		return _width;
	}

	public function set actualWidth(value:Number):void
	{
		setActualWidth(value);
		updateLayout();
	}

	private function setActualWidth(value:int):void
	{
		_skinUp.width = value;
		_skinSelectedUp.width = value;
	}

	public function get actualWidth():Number
	{
		return _skinUp.width;
	}

	public function set selected(value:Boolean):void
	{
		_selected = value;
		updateLayout();
	}

	public function get selected():Boolean
	{
		return _selected;
	}

	public function set label(label:String):void
	{
		if (label)
			_label.text = label;
		updateLayout();
	}

	private function updateLayout():void
	{
		if (_skinUp) _skinUp.visible = !_selected;
		if (_skinSelectedUp) _skinSelectedUp.visible = _selected;

		if (actualWidth < int(_label.textWidth + _textPaddings * 2))
			setActualWidth(_label.textWidth + _textPaddings * 2);

		_label.x = (actualWidth - _label.width) / 2;
		_label.y = _style.tabTextVerticalOffset;

		_label.textColor = _selected ? _style.textActiveColor : _style.textPassiveColor;

		UDisplay.placeAtOrigin(_skinUp, 0, 0);
		UDisplay.placeAtOrigin(_skinSelectedUp, 0, 0);
	}

	private function onClick(e:MouseEvent):void
	{
		if (_enabled)
			_onClickCallback(this);
	}
}
}