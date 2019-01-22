/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 13.09.12
 */
package com.grom.display.particles.modifiers
{
import com.grom.display.particles.Particle;

import net.maygem.lib.utils.UMath;

public class RotateToVelModifier implements IParticleModifier
{
	public static const NAME:String = "rotate_to_vel";

	public function RotateToVelModifier()
	{
	}

	public function parseFromXML(node:XML):void
	{
	}

	public function init(p:Particle):void
	{
	}

	public function move(p:Particle):void
	{
		p.rotation = UMath.rad2deg(Math.atan2(p._velY, p._velX));
	}
}
}
