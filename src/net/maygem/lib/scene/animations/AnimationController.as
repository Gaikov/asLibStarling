package net.maygem.lib.scene.animations
{
import flash.display.MovieClip;

import flash.display.Sprite;

import flash.media.SoundChannel;

import net.maygem.lib.resources.ResourceLoader;
import net.maygem.lib.sound.USound;

public class AnimationController extends Sprite
{
	private var _currentMovie:MovieClip;
	private var _currentClassID:String;
	private var _loopSoundsMap:Object = {}; //map[animationClassID] -> SoundClass
	private var _soundsMap:Object = {};     //map[animationClassID] -> SoundClass
	private var _loopChannel:SoundChannel;

	public function AnimationController(loopSoundsMap:Object = null, soundsMap:Object = null)
	{
		if (loopSoundsMap)
			_loopSoundsMap = loopSoundsMap;

		if (soundsMap)
			_soundsMap = soundsMap;
	}

	public function get currentClassID():String
	{
		return _currentClassID;
	}

	public function get currentMovie():MovieClip
	{
		return _currentMovie;
	}

	public function playAnimation(classID:String):void
	{
		if (_currentClassID == classID) return;

		stop();

		if (_soundsMap[classID] is Class)
			USound.play(_soundsMap[classID]);

		if (_loopSoundsMap[classID] is Class)
			_loopChannel = USound.play(_loopSoundsMap[classID], true);

		var cls:Class = ResourceLoader.instance().getDisplayClass(classID);
		if (!cls)
			_currentMovie = new MovieClip();
		else
			_currentMovie = new cls();
		_currentMovie.cacheAsBitmap = true;

		addChild(_currentMovie);
		var endFunc:Function = function(...args):void
		{
			dispatchEvent(new AnimationControllerEvent(AnimationControllerEvent.ANIMATION_COMPLETE));
		};
		_currentMovie.addFrameScript(_currentMovie.totalFrames - 1, endFunc);
		_currentClassID = classID;

		dispatchEvent(new AnimationControllerEvent(AnimationControllerEvent.ANIMATION_CHANGED));
	}

	public function playNextAnimation(classID:String, fromFrame:int = 0):void
	{
		var playNext:Function = function(...args):void
		{
			playAnimation(classID);
		};

		if (!fromFrame)
			fromFrame = _currentMovie.totalFrames - 1;

		_currentMovie.addFrameScript(fromFrame, playNext);
	}

	public function stop():void
	{
		if (_currentMovie)
		{
			removeChild(_currentMovie);
			_currentMovie.stop();

			_currentClassID = null;
			_currentMovie = null;
		}

		if (_loopChannel)
		{
			_loopChannel.stop();
			_loopChannel = null;
		}
	}
}
}