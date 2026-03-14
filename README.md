# Multiplayer Template

## Quick Startup Guide

You will need `git` for this.

Run this command in a terminal:
	`git clone git@github.com:255-Ping/multiplayer-template.git`
	
Then `import` the project in godot.

## Useful Information

###Scripts

`network_manager.gd` or `Network` handles hosting the server and client
`server_data_management.gd` or `SDM` is useful for making data persist between `get_tree().current_scene` changes.

###Functions

- `host(port)`: Starts and hosts a server, default port is `7777`. Also spawns host player.
- `join(ip, port)`: Joins a server with the given ip and port.
