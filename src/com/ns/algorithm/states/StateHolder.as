/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 30.06.12
 */
package com.ns.algorithm.states
{
public class StateHolder
{
	private var _state:IState;

	public function StateHolder()
	{
	}

	public function get state():IState
	{
		return _state;
	}

	public function set state(value:IState):void
	{
		if (_state)
		{
			_state.exit();
			_state = null;
		}

		_state = value;

		if (_state)
		{
			_state.enter();
		}
	}
}
}
