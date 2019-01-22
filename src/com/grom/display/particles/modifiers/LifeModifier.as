/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 04.09.12
 */
package com.grom.display.particles.modifiers
{
import com.grom.display.particles.Particle;

import net.maygem.lib.utils.UMath;

public class LifeModifier implements IParticleModifier
{
	public static const NAME:String = "life";

	private var _minLife:int;
	private var _maxLife:int;

	public function LifeModifier(minLife:int = 0, maxLife:int = 0)
	{
		_minLife = minLife;
		_maxLife = maxLife;
	}

	public function parseFromXML(node:XML):void
	{
		_minLife = node.@min;
		_maxLife = node.@max;
	}

	public function init(p:Particle):void
	{
		p._maxLife = UMath.randomRange(_minLife, _maxLife);
		p._life = p._maxLife;
	}

	public function move(p:Particle):void
	{
		p._life --;
		if (p._life <= 0)
		{
			p._dead = true;
		}
	}
}
}
