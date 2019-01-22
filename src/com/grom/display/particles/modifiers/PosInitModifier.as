/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 04.09.12
 */
package com.grom.display.particles.modifiers
{
import com.grom.display.particles.Particle;

import flash.geom.Point;

import net.maygem.lib.utils.UMath;

public class PosInitModifier implements IParticleModifier
{
	public static const NAME:String = "pos_init";

	private var _minDist:Number, _maxDist:Number;
	private var _minAngle:Number, _maxAngle:Number;

	public function PosInitModifier()
	{
	}

	public function init(p:Particle):void
	{
		var angle:Number = UMath.deg2rad(UMath.randomRange(_minAngle, _maxAngle));
		var pos:Point = new Point(Math.cos(angle), Math.sin(angle));

		var dist:Number = UMath.randomRange(_minDist, _maxDist);
		p.x = pos.x * dist;
		p.y = pos.y * dist;
	}

	public function move(p:Particle):void
	{
	}

	public function parseFromXML(node:XML):void
	{
		_minDist = node.@min_dist;
		_maxDist = node.@max_dist;

		_minAngle = int(node.@min_angle);
		_maxAngle = int(node.@max_angle);
		if (!_minAngle && !_maxAngle)
		{
			_maxAngle = 360;
		}
	}
}
}
