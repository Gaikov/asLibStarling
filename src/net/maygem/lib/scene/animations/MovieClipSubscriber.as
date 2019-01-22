package net.maygem.lib.scene.animations
{
import flash.display.MovieClip;
import flash.utils.Dictionary;

public class MovieClipSubscriber
{
	private var _clip : MovieClip;
	private var _endClipCallbacks : Dictionary = new Dictionary();
	private var _removeList:Array = [];

	public function MovieClipSubscriber(clip : MovieClip)
	{
		_clip = clip;
		_clip.addFrameScript(_clip.totalFrames - 1, onClipEnd);
	}

	public function get clip() : MovieClip
	{
		return _clip;
	}

	public function addClipEndCallback(func : Function, removeAfterCall:Boolean = false) : void
	{
		_endClipCallbacks[func] = new ClipEndCallback(removeAfterCall, func);
	}

	public function removeClipEndCallback(func : Function) : void
	{
		delete _endClipCallbacks[func];
	}

	private function onClipEnd() : void
	{
		for each (var callback : ClipEndCallback in _endClipCallbacks)
		{
			callback.func();
			if (callback.removeAfterCall)
				_removeList.push(callback);
		}

		for each (callback in _removeList)
			removeClipEndCallback(callback.func);

		_removeList.length = 0;
	}
}
}

class ClipEndCallback
{
	public var removeAfterCall:Boolean = true;
	public var func:Function;

	public function ClipEndCallback(removeAfterCall : Boolean, func : Function)
	{
		this.removeAfterCall = removeAfterCall;
		this.func = func;
	}
}