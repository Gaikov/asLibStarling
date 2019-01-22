package net.maygem.lib.ui.toolTips
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Timer;

import net.maygem.lib.fx.ITransformEffect;
import net.maygem.lib.fx.events.TransformEvent;
import net.maygem.lib.ui.CursorManager;
import net.maygem.lib.ui.toolTips.permissions.DefaultTooltipPermission;
import net.maygem.lib.ui.toolTips.permissions.ITooltipPermission;

public class BaseToolTip extends Sprite
{
	private var _parentObj:DisplayObject;

	private var _fx:ITransformEffect;
	private var _displayed:Boolean;
	private var _showDelay:Number;
	private var _showTimer:Timer;
	private var _userCursorBoundings:Boolean;
	private var _view:ToolTipView;
	private var _content:DisplayObject;
	private var _xDirection:Number;
	private var _yDirection:Number;
	private var _enabled:Boolean = true;
	private var _permission:ITooltipPermission;

	public function BaseToolTip(parentObj:DisplayObject,
	                            skinClass:Class,
	                            leftMargin:Number,
	                            rightMargin:Number,
	                            topMargin:Number,
	                            bottomMargin:Number,
	                            xDirection:Number,
	                            yDirection:Number,
	                            fx:ITransformEffect = null,
	                            showDelay:Number = 0,
	                            useCursorBoundings:Boolean = false)
	{
		super();

		permission = null;

		_view = new ToolTipView(skinClass, leftMargin, rightMargin, topMargin, bottomMargin, xDirection, yDirection);
		_xDirection = xDirection;
		_yDirection = yDirection;
		addChild(_view);

		mouseEnabled = false;
		mouseChildren = false;

		_fx = fx;
		_showDelay = showDelay;
		_userCursorBoundings = useCursorBoundings;

		if (_fx)
		{
			_fx.addEventListener(TransformEvent.VALUE_CHANGED, onTransformChanged);
			_fx.addEventListener(TransformEvent.TRANSFORM_COMPLETE, onTransformComplete);
		}

		_parentObj = parentObj;
		_parentObj.addEventListener(MouseEvent.MOUSE_OVER, parentObj_mouseOverHandler);
		_parentObj.addEventListener(MouseEvent.MOUSE_OUT, parentObj_mouseOutHandler);
		_parentObj.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);

		_showTimer = new Timer(_showDelay * 1000, 0);
		_showTimer.addEventListener(TimerEvent.TIMER, onTimerComplete);
	}

	public function set permission(value:ITooltipPermission):void
	{
		if (value)
			_permission = value;
		else
			_permission = new DefaultTooltipPermission();
	}

	public function get enabled():Boolean
	{
		return _enabled;
	}

	public function set enabled(value:Boolean):void
	{
		if (_enabled != value)
		{
			_enabled = value;
			if (!displayAllowed())
				parentObj_mouseOutHandler();
		}
	}

	public function set content(value:DisplayObject):void
	{
		_content = value;
		_view.content = value;
		updateLayout();
	}

	protected function get skin():DisplayObject
	{
		return _view.skin;
	}

	protected function invalidateContent():void
	{
		_view.content = _content;
	}

	private function displayAllowed():Boolean
	{
		return _enabled && _permission.canDisplay();
	}

	private function addToScene():void
	{
		var layer:ToolTipLayer = ToolTipLayer.getInstance();
		if (DisplayObjectContainer(layer) != this.parent)
			layer.addChild(this);
	}

	private function removeFromScene():void
	{
		var layer:ToolTipLayer = ToolTipLayer.getInstance();
		if (DisplayObjectContainer(layer) == this.parent)
			layer.removeChild(this);
	}

	public function showToolTip():void
	{
		addToScene();
		_displayed = true;
		if (_fx) _fx.forward();
		updateLayout();
	}

	public function hideToolTip():void
	{
		parentObj_mouseOutHandler();
	}

	private function onTimerComplete(event:TimerEvent):void
	{
		showToolTip();
		_showTimer.stop();
	}

	private function parentObj_mouseOverHandler(event:MouseEvent):void
	{
		if (displayAllowed())
		{
			if (_showDelay != 0)
				_showTimer.start();
			else
				showToolTip();
		}
	}

	private function parentObj_mouseOutHandler(event:MouseEvent = null):void
	{
		if (_fx)
			_fx.backward();
		else
			removeFromScene();
		_displayed = false;
		_showTimer.stop();
	}

	private function mouseMoveHandler(event:MouseEvent):void
	{
		if (_displayed)
			updateLayout();
	}

	private function updateLayout():void
	{
		if (!stage) return;

		_view.scaleX = _view.scaleY = 1;
		var pos:Point = localToGlobal(new Point(mouseX, mouseY));
		var distance:Point = new Point(0, 0);
		if (_userCursorBoundings)
		{
			var cursorRect:Rectangle = CursorManager.instance().getCursorBounds();
			distance.x = cursorRect.width / 2;
			distance.y = cursorRect.height / 2;
			pos.x += cursorRect.x + distance.x;
			pos.y += cursorRect.y + distance.y;
		}

		_view.xDirection = _xDirection;
		if (pos.x - (_view.width + distance.x) < 0)
			_view.xDirection = ToolTipView.DIRECTION_RIGTH;
		else if (pos.x + _view.width + distance.x > stage.stageWidth)
			_view.xDirection = ToolTipView.DIRECTION_LEFT;

		_view.yDirection = _yDirection;		
		if (pos.y + _view.height + distance.y > stage.stageHeight)
			_view.yDirection = ToolTipView.DIRECTION_TOP;
		else if (pos.y - (_view.height + distance.y) < 0)
			_view.yDirection = ToolTipView.DIRECTION_BOTTOM;

		x = pos.x + distance.x * _view.xDirection;
		y = pos.y + distance.y * _view.yDirection;

		if (_fx)
			scaleX = scaleY = _fx.value;
	}

	private function onTransformComplete(e:Event):void
	{
		if (_fx.value == 0)
			removeFromScene();
	}

	private function onTransformChanged(e:Event):void
	{
		scaleX = scaleY = _fx.value;
	}
}
}