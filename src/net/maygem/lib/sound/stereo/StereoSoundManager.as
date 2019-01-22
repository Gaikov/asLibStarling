/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 23.11.12
 */
package net.maygem.lib.sound.stereo
{
import flash.geom.Point;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.utils.Dictionary;

import net.maygem.lib.sound.ISoundStateListener;
import net.maygem.lib.sound.IVoice;
import net.maygem.lib.utils.UMath;
import net.maygem.lib.utils.UPoint;

public class StereoSoundManager implements ISoundStateListener
{
	private var _listenerPos:Point = new Point(0, 0);
	private var _maxDistance:Number = 200;

	private var _sounds:Dictionary = new Dictionary();
	private var _soundTransform:SoundTransform = new SoundTransform();
	private var _allVoices:Dictionary = new Dictionary();
	private var _soundEnabled:Boolean = true;

	public function StereoSoundManager()
	{
	}

	public function setListener(x:Number, y:Number):void
	{
		_listenerPos.x = x;
		_listenerPos.y = y;
		updateAllVoices();
	}

	public function onEffectsState(enabled:Boolean):void
	{
		_soundEnabled = enabled;
		//Log.info("sound enabled: ", _soundEnabled);
		updateAllVoices();
	}

	public function onMusicState(enabled:Boolean):void
	{
	}

	private function updateAllVoices():void
	{
		for each (var v:SoundVoice in _allVoices)
		{
			updateChannelPos(v.channel, v.pos);
		}
	}

	public function set maxDistance(value:Number):void
	{
		_maxDistance = value;
		updateAllVoices();
	}

	public function playStereo(cls:Class, x:Number, y:Number, loop:Boolean):IVoice
	{
		var c:SoundChannel = getSound(cls).play(0, loop ? int.MAX_VALUE : 0);
		if (!c) return null;

		var v:SoundVoice = new SoundVoice(c, removeVoice);
		UPoint.set(v.pos, x, y);
		updateChannelPos(c, v.pos);

		_allVoices[v] = v;
		return v;
	}

	public function setPosition(voice:IVoice, x:Number, y:Number):void
	{
		var v:SoundVoice = SoundVoice(voice);
		UPoint.set(v.pos, x, y);
		updateChannelPos(v.channel, v.pos);
	}

	private function removeVoice(v:SoundVoice):void
	{
		delete _allVoices[v];
	}

	private function updateChannelPos(c:SoundChannel, pos:Point):void
	{
		if (_soundEnabled)
		{
			_soundTransform.volume = 1 - Math.min(1, Point.distance(_listenerPos, pos) / _maxDistance);
			var relPos:Point = pos.subtract(_listenerPos);
			_soundTransform.pan = UMath.clamp(relPos.x / _maxDistance, -1, 1);
		}
		else
		{
			_soundTransform.volume = 0;
		}
		c.soundTransform = _soundTransform;
	}

	private function getSound(cls:Class):Sound
	{
		var s:Sound = _sounds[cls] as Sound;
		if (!s)
		{
			s = new cls();
			_sounds[cls] = s;
		}
		return s;
	}

	public function stop(v:IVoice):void
	{
		var voice:SoundVoice = SoundVoice(v);
		voice.stop();
		removeVoice(voice);
	}

	public function stopSounds():void
	{
		for each (var v:SoundVoice in _allVoices)
		{
			v.stop();
		}
		_allVoices = new Dictionary();
	}
}
}
