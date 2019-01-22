/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 06.09.12
 */
package com.grom.display.particles.modifiers
{
import com.grom.display.particles.Particle;

import net.maygem.lib.utils.UMath;

public class ScaleModifier implements IParticleModifier
{
	public static const NAME:String = "scale_range";

	private var _minStart:Number;
	private var _maxStart:Number;
	private var _minEnd:Number;
	private var _maxEnd:Number;

	public function ScaleModifier()
	{
	}

	public function parseFromXML(node:XML):void
	{
		_minStart = node.@min_start;
		_maxStart = node.@max_start;
		_minEnd = node.@min_end;
		_maxEnd = node.@max_end;
	}

	public function init(p:Particle):void
	{
		p._scaleStart = UMath.randomRange(_minStart, _maxStart);
		p._scaleEnd = UMath.randomRange(_minEnd, _maxEnd);
		move(p);
	}

	public function move(p:Particle):void
	{
		p.scaleX = p.scaleY = UMath.lerp(p._scaleStart, p._scaleEnd, p.lifeStage);
	}
}
}
