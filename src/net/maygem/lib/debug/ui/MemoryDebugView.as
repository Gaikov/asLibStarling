package net.maygem.lib.debug.ui
{
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.system.System;
import flash.text.TextField;

import flash.utils.Timer;

import net.maygem.lib.utils.UDisplay;

internal class MemoryDebugView extends Sprite implements IDebugView
{
	private var _text:TextField = UDisplay.createTextField("Tahoma", 16, 0xffffff, true);
	private var _updateTimer:Timer = new Timer(1000);

	public function MemoryDebugView()
	{
		mouseEnabled = false;
		mouseChildren = false;

		addChild(_text);
		_text.filters = [UDisplay.createBorderFilter(0, 3)];
		_updateTimer.addEventListener(TimerEvent.TIMER, onUpdateTimer);
		_updateTimer.start();
	}

	private function onUpdateTimer(event : TimerEvent) : void
	{
		_text.text = "Current memory: " + System.totalMemory / 1024 + " Kb";
	}

	public function updateLayout(stageWidth : int, stageHeight : int) : void
	{
		x = 10;
		y = stageHeight - height;
	}
}
}