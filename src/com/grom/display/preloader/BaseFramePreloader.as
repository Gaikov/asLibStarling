/**
 * Created with IntelliJ IDEA.
 * User: Roman
 * Date: 19.11.12
 * Time: 19:49
 * To change this template use File | Settings | File Templates.
 */
package com.grom.display.preloader
{
import com.grom.display.preloader.events.PreloaderEvent;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Stage;
import flash.events.Event;
import flash.utils.getDefinitionByName;

public class BaseFramePreloader extends MovieClip
{
	private var _view:IPreloaderView;
	private var _startClassName:String;

	public function BaseFramePreloader(startClassName:String)
	{
		_startClassName = startClassName;
		stop();
		addEventListener(Event.ENTER_FRAME, onEnterFrame);

		root.loaderInfo.addEventListener(Event.COMPLETE, function():void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			trace("preloader finished");
			onCompleted();
		});
	}

	private function onCompleted():void
	{
		_view.onCompleted()
	}

	private function startGame():void
	{
		nextFrame();

		var cls:Class = Class(getDefinitionByName(_startClassName));
		var stage:Stage = stage;

		parent.removeChild(this);
		var game:DisplayObject = new cls();
		stage.addChild(game);
	}

	final protected function initView(view:IPreloaderView):void
	{
		if (!_view)
		{
			_view = view;
		}
		else
		{
			throw new ArgumentError("preloader already initialized");
		}
		addChild(_view.asView());
		_view.addEventListener(PreloaderEvent.START_GAME_QUERY, function():void
		{
			startGame();
		});
	}

	private function onEnterFrame(event:Event):void
	{
		_view.percent = loaderInfo.bytesLoaded / loaderInfo.bytesTotal;
	}
}
}
