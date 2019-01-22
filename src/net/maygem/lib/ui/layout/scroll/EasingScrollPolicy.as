/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 01.08.12
 */
package net.maygem.lib.ui.layout.scroll
{
import net.maygem.lib.utils.UMath;

public class EasingScrollPolicy implements IScrollPolicy
{
	private var _speedScale:Number;

	public function EasingScrollPolicy(speedScale:Number)
	{
		_speedScale = speedScale;
	}

	public function computeScrollPos(currentPos:Number, desiredPos:Number):Number
	{
		var speed:Number = Math.abs(desiredPos - currentPos) * _speedScale;
		if (speed < 1) speed = 1;
		return UMath.move(currentPos, desiredPos, currentPos, speed);
	}
}
}
