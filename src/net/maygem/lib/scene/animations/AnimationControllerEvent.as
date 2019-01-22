package net.maygem.lib.scene.animations
{
import flash.events.Event;

public class AnimationControllerEvent extends Event
{
	static public const ANIMATION_CHANGED:String = "animcationChanged";
	static public const ANIMATION_COMPLETE:String = "animationComplete";

	function AnimationControllerEvent(type:String)
	{
		super(type)
	}

	override public function clone():Event
	{
		return new AnimationControllerEvent(type);
	}
}
}