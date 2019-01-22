/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 23.11.12
 */
package net.maygem.lib.sound.stereo
{
import flash.events.Event;
import flash.geom.Point;
import flash.media.SoundChannel;

import net.maygem.lib.sound.IVoice;

internal class SoundVoice implements IVoice
{
	private var _pos:Point = new Point();
	private var _channel:SoundChannel;
	private var _handlers:Array = [];
	private var _removeVoice:Function;

	public function SoundVoice(channel:SoundChannel, removeVoice:Function)
	{
		_channel = channel;
		_removeVoice = removeVoice;
		_channel.addEventListener(Event.SOUND_COMPLETE, onPlayCompleted);
	}

	private function onPlayCompleted(event:Event):void
	{
		_removeVoice(this);
		for each (var handler:Function in _handlers)
		{
			handler();
		}
		stop();
	}

	internal function stop():void
	{
		_channel.stop();
		_channel.removeEventListener(Event.SOUND_COMPLETE, onPlayCompleted);
		_handlers.length = 0;
	}

	public function addCompleteHandler(handler:Function):void
	{
		_handlers.push(handler);
	}

	public function get channel():SoundChannel
	{
		return _channel;
	}

	public function get pos():Point
	{
		return _pos;
	}

}
}
