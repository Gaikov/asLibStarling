package net.maygem.lib.ui.layout.controls
{
import flash.display.DisplayObject;

import flash.text.TextField;

import flash.text.TextFieldAutoSize;

import flash.text.TextFormat;

import net.maygem.lib.lang.Lang;
import net.maygem.lib.ui.layout.BaseLayout;
import net.maygem.lib.ui.layout.builder.ILayoutBuilder;
import net.maygem.lib.ui.layout.builder.SkinsRegistry;
import net.maygem.lib.utils.UDisplay;
import net.maygem.lib.utils.UFont;

public class ButtonLayout extends BaseLayout
{
	private var _skin : DisplayObject;
	private var _textField : TextField = new TextField();
	private var _text : String = "";
	private var _format : TextFormat = new TextFormat();
	private var _enabled : Boolean = true;
	private var _color : uint;
	private var _disableColor : uint;

	public function ButtonLayout(source : XML)
	{
		super();
		addChild(_textField);
		_textField.text = "";
		_textField.autoSize = TextFieldAutoSize.LEFT;
		_textField.selectable = false;
		_textField.mouseEnabled = false;

		updateFromXML(source);
	}

	public function get enabled() : Boolean
	{
		return _enabled;
	}

	public function set enabled(value : Boolean) : void
	{
		_enabled = value;
		if (_enabled)
			_format.color = _color;
		else
			_format.color = _disableColor;
		_textField.defaultTextFormat = _format;
		_textField.setTextFormat(_format);
		mouseEnabled = _enabled;
		mouseChildren = _enabled;
	}

	override public function updateFromXML(meta : XML) : void
	{
		super.updateFromXML(meta);
		if (meta.@skin != undefined) skinID = meta.@skin;
		if (meta.@font != undefined) _format.font = meta.@font;
		if (meta.@size != undefined) _format.size = meta.@size;
		if (meta.@color != undefined) _format.color = _color = meta.@color;
		if (meta.@disable_color != undefined) _disableColor = meta.@disable_color;
		if (meta.@text != undefined) _text = String(meta.@text);

		_textField.defaultTextFormat = _format;
		_textField.embedFonts = UFont.isEmbedded(_format.font);
		_textField.defaultTextFormat = _format;
		_textField.setTextFormat(_format);
	}

	public function set skinID(value : String) : void
	{
		skin = value ? SkinsRegistry.instance().createSkin(value) : null;
	}

	public function set skin(value : DisplayObject) : void
	{
		if (_skin)
			removeChild(_skin);
		_skin = value;
		if (_skin)
			addChildAt(_skin, 0);
	}

	override public function updateLayout() : void
	{
		super.updateLayout();
		_textField.text = Lang.getString(_text);

		if (_skin)
		{
			UDisplay.placeAtOrigin(_skin, 0, 0);
			_textField.x = (_skin.width - _textField.width) / 2;
			_textField.y = (_skin.height - _textField.height) / 2;
		}
		else
		{
			_textField.x = 0;
			_textField.y = 0;
		}
	}

	static public function builder() : ILayoutBuilder
	{
		return new ButtonBuilder();
	}

	public function set text(value:String):void
	{
		_text = value;
	}
}
}

import net.maygem.lib.ui.layout.BaseLayout;
import net.maygem.lib.ui.layout.builder.ILayoutBuilder;
import net.maygem.lib.ui.layout.controls.ButtonLayout;

class ButtonBuilder implements ILayoutBuilder
{
	public function createLayout(node : XML) : BaseLayout
	{
		return new ButtonLayout(node);
	}
}