/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 25.2.12
 */
package net.maygem.lib.sound
{
import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.utils.Dictionary;

import net.maygem.lib.settings.UserSettingsManager;
import net.maygem.lib.sound.stereo.StereoSoundManager;

public class SoundManager
{
	private static var _instance:SoundManager;

	private var _listeners:Dictionary = new Dictionary();
	private var _settings:UserSettingsManager = UserSettingsManager.instance();
	private var _musicChannel:SoundChannel;
	private var _musicSound:Sound;
	private var _musicVolume:Number = 1;
	private var _stereo:StereoSoundManager;
	private var _position:Number = 0;

	public function SoundManager()
	{
		_settings.addParam("sound_state", true);
		_settings.addParam("music_state", true);
		_stereo = new StereoSoundManager();
		addListener(_stereo);
	}

	public static function get instance():SoundManager
	{
		if (!_instance)
			_instance = new SoundManager();
		return _instance;
	}

	public function playStereo(cls:Class, x:Number, y:Number, loop:Boolean = false):IVoice
	{
		return _stereo.playStereo(cls, x, y, loop);
	}

	public function setPosition(v:IVoice, x:Number, y:Number):void
	{
		_stereo.setPosition(v, x, y);
	}

	public function setListener(x:Number, y:Number):void
	{
		_stereo.setListener(x, y);
	}

	public function playMusic(cls:Class):void
	{
		if (_musicSound && Object(_musicSound).constructor == cls)
		{
			return;
		}
		_musicSound = new cls();
		if (isMusicEnabled())
			startTrack()
	}

	public function set musicVolume(value:Number):void
	{
		_musicVolume = value;
		updateMusicVolume();
	}

	public function stopMusic():void
	{
		stopTrack();
		_musicSound = null;
		_position = 0;
	}

	private function startTrack():void
	{
		stopTrack();
		if (_musicSound)
		{
			_musicChannel = _musicSound.play(_position);
			_musicChannel.addEventListener(Event.SOUND_COMPLETE, loopMusic);
			updateMusicVolume();
		}
	}

	private function loopMusic(event:Event):void
	{
		_musicChannel.removeEventListener(Event.SOUND_COMPLETE, loopMusic);
		_musicChannel.stop();
		_musicChannel = _musicSound.play();
		updateMusicVolume();
		_musicChannel.addEventListener(Event.SOUND_COMPLETE, loopMusic);
	}

	private function stopTrack():void
	{
		if (_musicChannel)
		{
			_position = _musicChannel.position;
			_musicChannel.removeEventListener(Event.SOUND_COMPLETE, loopMusic);
			_musicChannel.stop();
			_musicChannel = null;
		}
	}

	public function setEffectsState(enabled:Boolean):void
	{
		if (_settings.setParam("sound_state", enabled))
		{
			for each (var l:ISoundStateListener in _listeners)
				l.onEffectsState(enabled);
		}
	}

	public function isEffectsEnabled():Boolean
	{
		return _settings.getParam("sound_state");
	}

	public function setMusicState(enabled:Boolean):void
	{
		if (_settings.setParam("music_state", enabled))
		{
			for each(var l:ISoundStateListener in _listeners)
				l.onMusicState(enabled);

			if (enabled)
				startTrack();
			else
				stopTrack();
		}
	}

	public function pauseMusic():void
	{
		stopTrack();
	}

	public function resumeMusic():void
	{
		if (isMusicEnabled())
		{
			startTrack();
		}
	}

	public function isMusicEnabled():Boolean
	{
		return _settings.getParam("music_state");
	}

	public function addListener(l:ISoundStateListener):void
	{
		_listeners[l] = l;
		l.onEffectsState(isEffectsEnabled());
		l.onMusicState(isMusicEnabled());
	}

	public function removeListener(l:ISoundStateListener):void
	{
		delete _listeners[l];
	}

	public function get isPlaying():Boolean
	{
		return _musicChannel != null;
	}

	private function updateMusicVolume():void
	{
		if (_musicChannel)
		{
			var st:SoundTransform = _musicChannel.soundTransform;
			st.volume = _musicVolume;
			_musicChannel.soundTransform = st;
		}
	}

	public function stopStereo(v:IVoice):void
	{
		_stereo.stop(v);
	}

	public function set listenerDistance(value:Number):void
	{
		_stereo.maxDistance = value;
	}

	public function stopSounds():void
	{
		_stereo.stopSounds();
	}
}
}
