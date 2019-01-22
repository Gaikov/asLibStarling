/**
 * Created by IntelliJ IDEA.
 * User: Roman Gaikov
 * Date: 04.02.12
 */
package com.ns.menu.displayPolicy
{
import com.grom.starlingUtils.display.DisplayUtils;

import flash.geom.Point;

import net.maygem.lib.ui.layout.alignment.Alignments;
import net.maygem.lib.ui.layout.alignment.IAlignment;
import net.maygem.lib.utils.UArray;

import starling.animation.IAnimatable;
import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.Sprite;

public class DisplayHorizontalPopupPolicy implements IDisplayPopupPolicy, IClosePopupPolicy, IAnimatable
{
	private var _movingPopups:Array = [];
	private var _screenWidth:int;
	private var _screenHeight:int;

	public function DisplayHorizontalPopupPolicy(screenWidth:int, screenHeight:int)
	{
		_screenWidth = screenWidth;
		_screenHeight = screenHeight;
		Starling.juggler.add(this);
	}

	public function onPopupCloseQuery(popup:Sprite, remover:IPopupRemover, back:DisplayObject):void
	{
		var endPos:Point = new Point(popup.x + _screenWidth, popup.y);
		_movingPopups.push(new FadeOutPopup(popup, endPos, remover));
		playCloseSound();
	}

	public function advanceTime(time:Number):void
	{
		for each(var fade:FadeInPopup in _movingPopups)
		{
			if (!fade.move(time))
				UArray.removeItem(_movingPopups, fade);
		}
	}

	public function onPopupDisplayed(popup:Sprite):void
	{
		var policy:IAlignment = Alignments.policy(Alignments.CENTER);

		var endPos:Point = DisplayUtils.convertToOriginPos(popup,
			policy.align(popup.width, _screenWidth),
			policy.align(popup.height, _screenHeight));

		popup.x = endPos.x - _screenWidth;
		popup.y = endPos.y;

		_movingPopups.push(new FadeInPopup(popup, endPos));
		playOpenSound();
	}

	protected function playOpenSound():void
	{

	}

	protected function playCloseSound():void
	{

	}
}
}

import com.ns.menu.displayPolicy.IPopupRemover;
import com.ns.menu.events.PopupEvent;

import flash.geom.Point;

import net.maygem.lib.utils.UPoint;

import starling.display.Sprite;

class FadeInPopup
{
	private var _popup:Sprite;
	private var _endPos:Point;

	public function FadeInPopup(popup:Sprite, endPos:Point)
	{
		_popup = popup;
		_endPos = endPos;
		popup.touchable = false;
	}

	protected function get speed():Number
	{
		var prevPos:Point = new Point(_popup.x, _popup.y);
		var speed:Number = UPoint.distance(prevPos, _endPos);
		if (speed <= 0.1)
			speed = 0.1;
		return speed * 10;
	}

	public function move(time:Number):Boolean
	{
		var prevPos:Point = new Point(_popup.x, _popup.y);

		var pos:Point = UPoint.move(prevPos, _endPos, speed * time);
		if (!pos)
		{
			_popup.x = _endPos.x;
			_popup.y = _endPos.y;
			_popup.touchable = true;
			onEndAction();
			return false;
		}

		_popup.x = pos.x;
		_popup.y = pos.y;
		return true;
	}

	protected function onEndAction():void
	{
		_popup.dispatchEvent(new PopupEvent(PopupEvent.DISPLAYED));
	}
}

class FadeOutPopup extends FadeInPopup
{
	static private const SPEED:Number = 2000;

	private var _remover:IPopupRemover;

	public function FadeOutPopup(popup:Sprite, endPos:Point, remover:IPopupRemover)
	{
		super(popup, endPos);
		_remover = remover;
	}

	override protected function get speed():Number
	{
		return SPEED;
	}

	override public function move(time:Number):Boolean
	{
		if (!super.move(time))
		{
			_remover.removeFromStage();
			return false;
		}

		return true;
	}

	override protected function onEndAction():void
	{
	}
}


