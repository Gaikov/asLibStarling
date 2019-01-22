package net.maygem.lib.ui.layout.controls
{
import net.maygem.lib.ui.layout.*;

import flash.display.DisplayObject;

import net.maygem.lib.ui.layout.builder.ILayoutBuilder;
import net.maygem.lib.ui.layout.builder.SkinsRegistry;
import net.maygem.lib.utils.UContainer;
import net.maygem.lib.utils.UDisplay;

public class ImageLayout extends BaseLayout
{
	private var _image : DisplayObject;
	private var _width : int = 0;
	private var _height : int = 0;
	private var _rescale : Boolean;
	private var _back : DisplayObject = UDisplay.createAlphaShape(10, 10);

	public function ImageLayout(width : int, height : int)
	{
		super();
		_width = width;
		_height = height;
	}

	override public function set width(value : Number) : void
	{
		_width = value;
	}

	override public function set height(value : Number) : void
	{
		_height = value;
	}

	override public function updateFromXML(meta : XML) : void
	{
		super.updateFromXML(meta);
		_rescale = meta.@rescale == "true";
		var source : String = meta.@source;
		if (source)
			imageClass = SkinsRegistry.instance().getSkinClass(source);
	}

	public function set image(value : DisplayObject) : void
	{
		UContainer.removeAllChildren(this);
		_image = value;
		if (_image)
			addChild(_image);
	}

	public function set imageClass(cls : Class) : void
	{
		image = cls ? new cls() : null;
	}

	override public function updateLayout() : void
	{
		super.updateLayout();

		if (_image)
		{
			if (_width && _height)
			{
				if (!_rescale)
				{
					UDisplay.placeAtOrigin(_image,
							(_width - _image.width) / 2,
							(_height - _image.height) / 2);

					_back.width = _width;
					_back.height = _height;
					updatePresence(_back, true);
				}
				else
				{
					_image.width = _width;
					_image.height = _height;
					UDisplay.placeAtOrigin(_image, 0, 0);
					updatePresence(_back, false);
				}
			}
			else
			{
				UDisplay.placeAtOrigin(_image, 0, 0);
			}
		}
	}

	static public function builder() : ILayoutBuilder
	{
		return new ImageBuilder();
	}
}
}

import net.maygem.lib.ui.layout.BaseLayout;
import net.maygem.lib.ui.layout.controls.ImageLayout;
import net.maygem.lib.ui.layout.builder.ILayoutBuilder;

class ImageBuilder implements ILayoutBuilder
{
	public function createLayout(node : XML) : BaseLayout
	{
		var res : BaseLayout = new ImageLayout(node.@width, node.@height);
		res.updateFromXML(node);
		return res;
	}
}