/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 06.09.12
 */
package com.grom.display.particles.modifiers
{
import com.grom.display.particles.Particle;

import flash.geom.Point;

import net.maygem.lib.utils.UMath;
import net.maygem.lib.utils.UPoint;

public class AccelModifier implements IParticleModifier
{
	public static const NAME:String = "accel";

	private var _minAccel:Number;
	private var _maxAccel:Number;

	public function AccelModifier()
	{
	}

	public function parseFromXML(node:XML):void
	{
		_minAccel = node.@min;
		_maxAccel = node.@max;
	}

	public function init(p:Particle):void
	{
		p._accel = UMath.randomRange(_minAccel, _maxAccel);
	}

	public function move(p:Particle):void
	{
		var dir:Point = new Point(p._velX, p._velY);
		if (dir.length)
		{
			dir.normalize(1);
			UPoint.scale(dir, p._accel);

			var prev:Point = new Point(p._velX, p._velY);
			p._velX += dir.x;
			p._velY += dir.y;

			var curr:Point = new Point(p._velX, p._velY);
			if (UPoint.dotProduct(prev, curr) <= 0)
			{
				p._velX = p._velY = 0;
			}
		}
	}
}
}
