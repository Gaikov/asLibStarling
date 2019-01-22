package net.maygem.lib.ui.layout.scroll
{
import flash.display.Sprite;
import flash.events.Event;

import net.maygem.lib.ui.layout.*;

import flash.display.DisplayObject;

import net.maygem.lib.utils.UDisplay;

public class HorizontalScrollLayout extends BaseLayout implements IScrollLayout
{
	private var _content:DisplayObject;

	protected var _desiredScroll : Number = 0;

	private var _width:int = 100;
	private var _height:int = 100;
	private var _mask:DisplayObject;
	private var _scrollStep:Number = 100;
	private var _currentScroll:Number = 0;
	private var _scrollPolicy:IScrollPolicy;
	private var _clipContent : Boolean;

	public function HorizontalScrollLayout(scrollStep:Number, scrollPolicy:IScrollPolicy = null)
	{
		super();

		_scrollStep = scrollStep;

		if (scrollPolicy)
			_scrollPolicy = scrollPolicy;
		else
			_scrollPolicy = new DefaultScrollPolicy();

		clipContent = true;
		updateClippingMask();
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		content = new Sprite();
	}

	public function set scrollStep(value : Number) : void
	{
		_scrollStep = value;
	}

	public function set content(value:DisplayObject):void
	{
		if (_content) removeChild(_content);
		_content = value;
		if (_content) addChild(_content);
	}

	public function set scrollingPercents(scrollingPercents : Number) : void
	{
		if (!_content) return;

		_desiredScroll = -(_content.width - _width) * scrollingPercents;
		checkScroll();
	}

	public function get content() : DisplayObject
	{
		return _content;
	}

	override public function set width(value:Number):void
	{
		_width = value;
		updateClippingMask();
	}

	override public function get width():Number
	{
		return _width;
	}

	override public function set height(value:Number):void
	{
		_height = value;
		updateClippingMask();
	}

	override public function get height():Number
	{
		return _height;
	}


    public function updateScrollState():void
    {
        checkScroll();
    }

    public function scrollForward() : void
	{
		_desiredScroll -= _scrollStep;
		checkScroll();
	}

	public function scrollBackward() : void
	{
		_desiredScroll += _scrollStep;
		checkScroll();
	}

	override public function updateLayout():void
	{
		super.updateLayout();
		checkScroll();
	}

	public function get scrollPolicy() : IScrollPolicy
	{
		return _scrollPolicy;
	}

	public function set scrollPolicy(value : IScrollPolicy) : void
	{
		if (!value)
			_scrollPolicy = new DefaultScrollPolicy();
		else
			_scrollPolicy = value;
	}

	protected function checkScroll() : void
	{
		if (!_content) return;
		var scrollEnabled:Boolean = _width < _content.width;
		if (!scrollEnabled)
		{
			_desiredScroll = 0;
			dispatchEvent(new ScrollStateEvent(false, false));
			return;
		}

		var forwardEnabled : Boolean = scrollEnabled;
		var backwardEnabled : Boolean = scrollEnabled;

		if (_desiredScroll <= -(_content.width - _width))
		{
			_desiredScroll = -(_content.width - _width);
			forwardEnabled = false;
		}

		if (_desiredScroll >= 0)
		{
			_desiredScroll = 0;
			backwardEnabled = false;
		}

		dispatchEvent(new ScrollStateEvent(forwardEnabled, backwardEnabled));
	}

	private function onEnterFrame(event:Event):void
	{
		if (_currentScroll != _desiredScroll)
		{
			_currentScroll = _scrollPolicy.computeScrollPos(_currentScroll, _desiredScroll);
			updateContentPosition(_currentScroll);
		}
	}

	protected function updateContentPosition(value : Number) : void
	{
		_content.x = value;
	}

	private function updateClippingMask():void
	{
		if (_mask)
			removeChild(_mask);

		if (_clipContent)
		{
		_mask = UDisplay.createFilledShape(_width, _height);
		addChild(_mask);
		mask = _mask;
	}
}

	public function set clipContent(value : Boolean) : void
	{
		_clipContent = value;
		updateClippingMask();
	}

	public function get maxScrollRange() : Number
	{
		if (!content) return 0;
		var range : Number = content.width - width;
		return range > 0 ? range : 0;
	}
}
}