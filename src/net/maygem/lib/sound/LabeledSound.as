package net.maygem.lib.sound
{
import flash.display.MovieClip;
import flash.events.Event;
import flash.media.SoundChannel;

public class LabeledSound
{
	private var _mc:MovieClip;
	private var _soundsMap:Object;
	private var _channelsMap:Object = {};

	public function LabeledSound(mc:MovieClip, soundsMap:Object)
	{
		_mc = mc;
		_soundsMap = soundsMap;
		this.run();
	}

	private function run():void
	{
		if (!_mc) return;
		_mc.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	private function onEnterFrame(event:Event):void
	{
		playSoundIfNeeded();
	}

	public function playSoundIfNeeded():void
	{
		var label:String = _mc.currentLabel;
		if (label && label.indexOf("sound_") == 0 && _soundsMap[label])
			_channelsMap[label] = USound.play(_soundsMap[label]);
	}

	public function destroy():void
	{
		if (!_mc) return;
		
		_mc.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		_mc = null;
		for each (var ch:SoundChannel in _channelsMap)
			ch.stop();
		_channelsMap = {};
	}

}
}