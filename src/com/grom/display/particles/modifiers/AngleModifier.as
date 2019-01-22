/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 03.10.12
 */
package com.grom.display.particles.modifiers
{
import com.grom.display.particles.Particle;

import net.maygem.lib.utils.UMath;

public class AngleModifier implements IParticleModifier
{
	public static const NAME:String = "angle";

	private var _minVel:Number;
	private var _maxVel:Number;

	public function AngleModifier()
	{
	}

	public function parseFromXML(node:XML):void
	{
		_minVel = node.@min_vel;
		_maxVel = node.@max_vel;
	}

	public function init(p:Particle):void
	{
		p._angleVel = UMath.randomRangeSign(_minVel, _maxVel);
	}

	public function move(p:Particle):void
	{
		p._angle += p._angleVel;
		p.rotation = p._angle;
	}
}
}
