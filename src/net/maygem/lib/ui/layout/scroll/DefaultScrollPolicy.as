package net.maygem.lib.ui.layout.scroll
{
import net.maygem.lib.utils.UMath;

public class DefaultScrollPolicy implements IScrollPolicy
{
	public function DefaultScrollPolicy()
	{
	}

	public function computeScrollPos(currentPos:Number, desiredPos:Number):Number
	{
		return UMath.move(currentPos, desiredPos, currentPos, 20);
	}

	public function backwardScrollEnabled(enabled:Boolean):void
	{
	}

	public function forwardScrollEnabled(enabled:Boolean):void
	{
	}
}
}