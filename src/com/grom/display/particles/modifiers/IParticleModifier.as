/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 04.09.12
 */
package com.grom.display.particles.modifiers
{
import com.grom.display.particles.Particle;

public interface IParticleModifier
{
	function parseFromXML(node:XML):void;

	function init(p:Particle):void
	function move(p:Particle):void
}
}
