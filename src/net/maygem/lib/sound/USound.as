package net.maygem.lib.sound
{
import flash.events.Event;
import flash.media.SoundTransform;

import starling.display.DisplayObject;
import starling.events.Event;
import flash.geom.Point;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.utils.Dictionary;

import net.maygem.lib.utils.UArray;

public class USound
{
	private static var _soundLimitMap:Dictionary = new Dictionary();

	public function USound():void
	{
		_soundLimitMap = new Dictionary();
	}
	
	static public function attachStateListener(obj:DisplayObject, l:ISoundStateListener):void
	{
		obj.addEventListener(starling.events.Event.ADDED_TO_STAGE, function():void
		{
			SoundManager.instance.addListener(l);
		});
		
		obj.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, function():void
		{
			SoundManager.instance.removeListener(l);
		});
	}

	static private var _st:SoundTransform = new SoundTransform();

	static public function play(cls:Class, loop:Boolean = false, playCompleted:Function = null, volume:Number = 1):SoundChannel
	{
		var c:SoundChannel;
		if (!SoundManager.instance.isEffectsEnabled())
		{
			c = null;
		}
		else
		{
			var sound:Sound = new cls();
			c = sound.play(0, loop ? int.MAX_VALUE : 0);
			if (volume != 1 && c)
			{
				_st.volume = volume;
				c.soundTransform = _st;
			}
		}

		if (playCompleted != null)
		{
			if (c)
			{
				c.addEventListener(flash.events.Event.SOUND_COMPLETE, function():void
				{
					playCompleted();
				});
			}
			else
			{
				playCompleted();
			}
		}

		return c;
	}

	public static function playStereo(cls:Class, pos:Point, loop:Boolean = false):IVoice
	{
		return SoundManager.instance.playStereo(cls, pos.x, pos.y, loop);
	}

	public static function setPos(v:IVoice, pos:Point):void
	{
		if (v)
		{
			SoundManager.instance.setPosition(v, pos.x, pos.y);
		}
	}

	public static function stop(v:IVoice):void
	{
		if (v)
		{
			SoundManager.instance.stopStereo(v);
		}
	}

	static public function playRandom(list:Array, loop:Boolean = false):SoundChannel
	{
		return play(UArray.getRandom(list), loop);
	}



	/*
	 Запускаем звуки с лимитером.
	 */
	static public function playLimitSound(cls:Class, loop:Boolean = false, limitCount:int = 0):void
	{
		//Log.info("Проигрываем звук: " + soundType);
		var sound:Sound = new cls() as Sound;
		var limitObject:LimitObject;

		if (!_soundLimitMap[cls])
		{
			limitObject = new LimitObject();
			limitObject.count = 1;
			limitObject.limit = limitCount;
			limitObject.sounds.push(sound.play(0, loop ? 100000 : 0));

			_soundLimitMap[cls] = limitObject;
		}
		else
		{
			limitObject = _soundLimitMap[cls] as LimitObject;

			limitObject.count++;

			if (limitObject.limit > 0)
			{
				if (limitObject.count <= limitObject.limit)
				{
					limitObject.sounds.push(sound.play(0, loop ? 100000 : 0));
				}
			}
			else
			{
				limitObject.sounds.push(sound.play(0, loop ? 100000 : 0));
			}

			//Log.info("Общее количество звуков " + soundType + ": " + limitObject.limitCount);
		}
	}

	/*
	 Останавливаем звуки, которые были запущены с лиметером.
	 */
	static public function stopLimitSound(cls:Class):void
	{
		if (!_soundLimitMap[cls])
			return;

		var limitObject:LimitObject = _soundLimitMap[cls] as LimitObject;
		var soundChannel:SoundChannel;

		limitObject.count--;

		if (limitObject.limit > 0)
		{
			if (limitObject.count < limitObject.limit && limitObject.count >= 0)
			{
				soundChannel = limitObject.sounds[limitObject.sounds.length - 1] as SoundChannel;
				soundChannel.stop();
				limitObject.sounds.pop();
			}
		}
		else
		{
			soundChannel = limitObject.sounds[limitObject.sounds.length - 1] as SoundChannel;
			soundChannel.stop();
			limitObject.sounds.pop();
		}
	}

	public static function playStereoRandom(classList:Array, pos:Point):void
	{
		var cls:Class = UArray.getRandom(classList);
		USound.playStereo(cls, pos);
	}
}
}

class LimitObject
{

	public var count:int;
	public var sounds:Array;
	public var limit:int;

	public function LimitObject():void
	{
		sounds = [];
	}

}