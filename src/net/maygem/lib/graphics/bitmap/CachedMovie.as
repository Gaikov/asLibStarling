/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 28.2.12
 */
package net.maygem.lib.graphics.bitmap
{
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Point;

import net.maygem.lib.scene.frameListener.FramePolicy;
import net.maygem.lib.scene.frameListener.IFrameListener;

public class CachedMovie extends Sprite implements IFrameListener
{
	private var _currentIndex:int;
	private var _policy:FramePolicy;
	private var _view:Bitmap = new Bitmap();
	private var _frames:CachedMovieFrames;
	private var _scripts:Array = [];

	public function CachedMovie(frames:CachedMovieFrames)
	{
		_frames = frames;
		//_policy = new FramePolicy(this, this);
		gotoAndPlay(1);
		addChild(_view);
	}

	public function gotoAndPlay(frameNumber:int):void
	{
		changeFrame(frameNumber - 1);
		_policy.enabled = true;
	}

	public function gotoAndStop(frameNumber:int):void
	{
		changeFrame(frameNumber - 1);
		_policy.enabled = false;
	}

	public function get totalFrames():int
	{
		return _frames.count;
	}
	
	public function addFrameScript(frameIndex:int, script:Function):void
	{
		if (!_scripts[frameIndex])
		{
			_scripts[frameIndex] = [];
		}

		var frameScripts:Array = _scripts[frameIndex];
		frameScripts.push(script);
	}

	private function changeFrame(index:int):void
	{
		_currentIndex = index;
		var frame:CachedFrame = _frames.getFrame(_currentIndex);
		var offs:Point = frame.offset;
		_view.x = offs.x;
		_view.y = offs.y;
		_view.bitmapData = frame.bitmapData;
		_view.smoothing = true;
	}

	public function onEnterFrame():void
	{
		nextFrame();
	}

	public function nextFrame():void
	{
		var prevFrame:int = _currentIndex;
		changeFrame((_currentIndex + 1) % _frames.count);

		var frameScripts:Array = _scripts[prevFrame] as Array;
		if (frameScripts)
		{
			for each (var script:Function in frameScripts)
			{
				script();
			}
		}
	}

	public function stop():void
	{
		_policy.enabled = false;
	}
}
}
