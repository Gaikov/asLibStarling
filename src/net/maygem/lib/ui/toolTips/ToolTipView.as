package net.maygem.lib.ui.toolTips
{
import flash.display.DisplayObject;
import flash.display.Sprite;

public class ToolTipView extends Sprite
{
	public static const DIRECTION_RIGTH:Number = 1;
	public static const DIRECTION_LEFT:Number = -1;
	public static const DIRECTION_BOTTOM:Number = 1;
	public static const DIRECTION_TOP:Number = -1;

	private var _skin:DisplayObject;
	private var _skinContainer:Sprite;
	private var _content:DisplayObject;
	private var _skinOffsetX:Number;
	private var _skinOffsetY:Number;

	private var _leftMargin:Number;
	private var _rightMargin:Number;
	private var _topMargin:Number;
	private var _bottomMargin:Number;
	private var _xDirection:Number;
	private var _yDirection:Number;

	public function ToolTipView(
			skinClass:Class,
			leftMargin:Number,
			rigthMargin:Number,
			topMargin:Number,
			bottomMargin:Number,
			xDirection:Number,
			yDirection:Number)
	{
		super();

		_rightMargin = rigthMargin;
		_leftMargin = leftMargin;
		_topMargin = topMargin;
		_bottomMargin = bottomMargin;
		_xDirection = xDirection;
		_yDirection = yDirection;

		_skinContainer = new Sprite();
		addChild(_skinContainer);

		_skin = new skinClass();
		_skinOffsetX = _skin.getBounds(_skin).x;
		_skinOffsetY = _skin.getBounds(_skin).y;

		_skinContainer.addChild(_skin);
		content = new Sprite();
	}

	public function get skin():DisplayObject
	{
		return _skin;
	}

	public function set content(value:DisplayObject):void
	{
		if (_content)
			removeChild(_content);
		_content = value;
		addChild(value);

		updateLayout();
	}

	override public function get width():Number
	{
		return _content.width + _leftMargin + _rightMargin;
	}

	override public function get height():Number
	{
		return _content.height + _topMargin + _bottomMargin;
	}

	private function updateLayout():void
	{
		_skin.width = width;
		_skin.height = height;

		_skin.x = - _skinOffsetX * _skin.scaleX;
		_skin.y = - _skinOffsetY * _skin.scaleY;

		_skinContainer.scaleX = _xDirection;
		_skinContainer.scaleY = _yDirection;

		if (_xDirection < 0)
			_content.x = -width + _rightMargin;
		else
			_content.x = _leftMargin;

		if (_yDirection < 0)
			_content.y = -height + _bottomMargin;
		else
			_content.y = _topMargin;
	}

	public function get xDirection():Number
	{
		return _xDirection;
	}

	public function set xDirection(value:Number):void
	{
		if (_xDirection != value)
		{
			_xDirection = value;
			updateLayout();
		}
	}

	public function get yDirection():Number
	{
		return _yDirection;
	}

	public function set yDirection(value:Number):void
	{
		if (_yDirection != value)
		{
			_yDirection = value;
			updateLayout();
		}
	}
}
}