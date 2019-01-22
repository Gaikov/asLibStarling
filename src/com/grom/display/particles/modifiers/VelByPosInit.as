/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 06.09.12
 */
package com.grom.display.particles.modifiers
{
import com.grom.display.particles.Particle;

import flash.geom.Point;

import flash.geom.Point;

import net.maygem.lib.utils.UMath;

import net.maygem.lib.utils.UPoint;

public class VelByPosInit implements IParticleModifier
{
	public static const NAME:String = "vel_by_pos_init";

	private var _minVel:Number;
	private var _maxVel:Number;

	public function VelByPosInit()
	{
	}

	public function parseFromXML(node:XML):void
	{
		_minVel = node.@min;
		_maxVel = node.@max;
	}

	public function init(p:Particle):void
	{
		var pos:Point = new Point(p.x, p.y);
		if (pos.length)
		{
			pos.normalize(1);
			UPoint.scale(pos, UMath.randomRange(_minVel, _maxVel));
			p._velX = pos.x;
			p._velY = pos.y;
		}
		else
		{
			p._velX = 0;
			p._velY = 0;
		}
	}

	public function move(p:Particle):void
	{
	}
}
}
