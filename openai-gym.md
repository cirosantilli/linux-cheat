# OpenAI Gym

<https://github.com/openai/gym/issues>, tested at `77568accd7f698ae67937da0099fa58a037a96fd`.

True getting started:

    python examples/agents/random.py

Minimal example: <https://github.com/cirosantilli/gym/tree/random-agent-minimize-print>

Shows GUI, and videos of runs dumped to `tmp`.

Human controlled agent:

    python examples/agents/keyboard_agent.py

but it does not have frame rate limiting, so it is useless.

Your first intelligent player:

    python examples/agents/cem.py

but the interface is dedicated for the pole game.

TODO: make a minimal interface that adapts to any game. This seems to be the case: <https://github.com/openai/universe-starter-agent/blob/master/README.md>
