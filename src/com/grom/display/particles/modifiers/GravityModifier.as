/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 06.09.12
 */
package com.grom.display.particles.modifiers
{
import com.grom.display.particles.Particle;

import net.maygem.lib.utils.UMath;

public class GravityModifier implements IParticleModifier
{
	private var _min:Number;
	private var _max:Number;
	public static const NAME:String = "gravity";

	public function GravityModifier()
	{
	}

	public function parseFromXML(node:XML):void
	{
		_min = node.@min;
		_max = node.@max;
	}

	public function init(p:Particle):void
	{
		p._gravity = UMath.randomRange(_min, _max);
	}

	public function move(p:Particle):void
	{
		p._velY += p._gravity;
	}
}
}
