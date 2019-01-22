/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 17.09.12
 */
package com.grom.display.particles.modifiers
{
import com.grom.display.particles.Particle;

import net.maygem.lib.utils.UMath;

public class ScaleGraphModifier implements IParticleModifier
{
	public static const NAME:String = "scale_graph";

	private var _graph:Array = [];
	private var _minSize:Number;
	private var _maxSize:Number;

	public function ScaleGraphModifier()
	{
	}

	public function parseFromXML(source:XML):void
	{
		for each (var node:XML in source.node)
		{
			_graph.push(new ScalePoint(node));
		}
		_minSize = source.@min_size;
		_maxSize = source.@max_size;
	}

	public function init(p:Particle):void
	{
		p._size = UMath.randomRange(_minSize, _maxSize);
		p.width = p.height = p._size * computeScale(0);
	}

	public function move(p:Particle):void
	{
		p.width = p.height = p._size * computeScale(p.lifeStage);
	}

	private function computeScale(time:Number):Number
	{
		for (var i:int = 0; i < _graph.length; i++)
		{
			var curr:ScalePoint = _graph[i];
			if (time <= curr._time)
			{
				if (i == 0)
				{
					return curr._scale;
				}
				else
				{
					var prev:ScalePoint = _graph[i - 1];
					var maxTime:Number = curr._time - prev._time;
					var currTime:Number = time - prev._time;
					return UMath.lerp(prev._scale, curr._scale, currTime / maxTime);
				}
			}
		}

		return 0;
	}
}
}

class ScalePoint
{
	public var _scale:Number;
	public var _time:Number;

	public function ScalePoint(node:XML)
	{
		_scale = node.@scale;
		_time = node.@time;
	}
}
