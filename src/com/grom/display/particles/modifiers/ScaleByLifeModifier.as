/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 04.09.12
 */
package com.grom.display.particles.modifiers
{
import com.grom.display.particles.Particle;

import net.maygem.lib.utils.UMath;

public class ScaleByLifeModifier implements IParticleModifier
{
	public static const NAME:String = "scale_by_life";

	private var _scale:Number;

	public function ScaleByLifeModifier(scale:Number = 0)
	{
		_scale = scale;
	}

	public function parseFromXML(node:XML):void
	{
		_scale = node.@scale;
	}

	public function init(p:Particle):void
	{
	}

	public function move(p:Particle):void
	{
		p.scaleX = p.scaleY = UMath.lerp(1, _scale, (1 - (p._life / p._maxLife)));
	}
}
}
