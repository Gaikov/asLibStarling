package net.maygem.lib.ui.scroll
{
import flash.display.DisplayObject;
import flash.display.Sprite;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

import net.maygem.lib.utils.UDisplay;

public class ScrollBar extends Sprite
{
	private static const EVENT_POSITION_CHANGED : String = "scrollPositionChanged";

	private var _scrollStep : Number;
	private var _maxScrollRange : Number;
	private var _maxScrollPosition : Number;
	private var _style : ScrollBarStyle;

	private var _scrollBg : DisplayObject;
	private var _scrollUpButton : IScrollButton;
	private var _scrollDownButton : IScrollButton;
	private var _dragger : Sprite;

	private var _dragging : Boolean = false;

	private var _scrollingPercents : Number = 0;

	private var _buttonBuilder : IButtonBuilder;

	public function ScrollBar(style : ScrollBarStyle, buttonBuilder : IButtonBuilder)
	{
		_style = style;
		_buttonBuilder = buttonBuilder;

		createBg();
		createButtons();
		createDragger();

		this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		rearrangeLayout();
	}

	private function onAddedToStage(event : Event) : void
	{
		stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}

	public function enableScrollUp(value : Boolean) : void
	{
		_scrollUpButton.enabled = value;
		_dragger.visible = _scrollUpButton.enabled || _scrollDownButton.enabled;
	}

	public function enableScrollDown(value : Boolean) : void
	{
		_scrollDownButton.enabled = value;
		_dragger.visible = _scrollUpButton.enabled || _scrollDownButton.enabled;
	}

	private function createBg() : void
	{
		_scrollBg = new _style.backgroundClass() as DisplayObject;
		this.addChild(_scrollBg);
	}

	protected function createButtons() : void
	{
		_scrollUpButton = _buttonBuilder.createButton();
		_scrollUpButton.enabled = false;
		_scrollUpButton.addEventListener(MouseEvent.CLICK, onScrollUpButtonClick);
		this.addChild(_scrollUpButton as DisplayObject);

		_scrollDownButton = _buttonBuilder.createButton();
		(_scrollDownButton as DisplayObject).scaleY = -1;
		_scrollDownButton.enabled = false;
		_scrollDownButton.addEventListener(MouseEvent.CLICK, onScrollDownButtonClick);
		this.addChild(_scrollDownButton as DisplayObject);
	}

	private function onScrollUpButtonClick(event : MouseEvent) : void
	{
		event.stopImmediatePropagation();

		var length : Number = _maxScrollPosition;
		var partLength : Number = length / (_maxScrollRange / _scrollStep);

		if (_dragger.y - partLength < _style.padding)
		{
			_dragger.y = _style.padding;
		} else
		{
			_dragger.y -= partLength;
		}

		invalidate();
	}

	private function onScrollDownButtonClick(event : MouseEvent) : void
	{
		event.stopImmediatePropagation();

		var length : Number = _maxScrollPosition;
		var partLength : Number = length / (_maxScrollRange / _scrollStep);

		if (_dragger.y + partLength > _maxScrollPosition)
		{
			_dragger.y = _maxScrollPosition + _style.padding;
		} else
		{
			_dragger.y += partLength
		}

		invalidate();
	}

	private function createDragger() : void
	{
		_dragger = new _style.draggerClass() as Sprite;
		_dragger.buttonMode = true;
		_dragger.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		UDisplay.placeAtOrigin(_dragger, 0, 0);
		this.addChild(_dragger);

		_dragger.visible = false;
	}

	private function onMouseUp(event : MouseEvent) : void
	{
		if (_dragging)
		{
			_dragger.stopDrag();
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		_dragging = false;
	}

	private function onMouseDown(event : MouseEvent) : void
	{
		event.stopImmediatePropagation();
		_dragging = true;
		_dragger.startDrag(false, new Rectangle((_scrollBg.width - _dragger.width) / 2, _style.padding, 0, _maxScrollPosition));
		this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	private function onEnterFrame(event : Event) : void
	{
		this.invalidate();
	}

	private function invalidate() : void
	{
		_scrollingPercents = (_dragger.y - _style.padding) / _maxScrollPosition;
		dispatchEvent(new Event(EVENT_POSITION_CHANGED, true));
	}

	public function set maxScrollRange(value : Number) : void
	{
		_maxScrollRange = value;
	}

	public function get scrollingPercents() : Number
	{
		return _scrollingPercents;
	}

	override public function set height(value : Number) : void
	{
		_scrollBg.height = value;
		_maxScrollPosition = _scrollBg.height - _style.padding * 2 - _dragger.height;

		this.rearrangeLayout();
	}

	private function rearrangeLayout() : void
	{
		_dragger.x = 3;
		_dragger.y = 29;

		UDisplay.placeAtOrigin((_scrollDownButton as DisplayObject), (_scrollUpButton as DisplayObject).width / 2, (_scrollUpButton as DisplayObject).height / 2);
		(_scrollUpButton as DisplayObject).x = this.width / 2;
		(_scrollUpButton as DisplayObject).y = _style.padding / 2;

		UDisplay.placeAtOrigin((_scrollDownButton as DisplayObject), (_scrollDownButton as DisplayObject).width / 2, (_scrollDownButton as DisplayObject).height / 2);
		(_scrollDownButton as DisplayObject).x = this.width / 2;
		(_scrollDownButton as DisplayObject).y = _scrollBg.height - _style.padding / 2;
	}

	public function set scrollStep(scrollStep : Number) : void
	{
		_scrollStep = scrollStep;
	}
}
}