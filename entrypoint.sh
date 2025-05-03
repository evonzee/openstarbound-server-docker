#!/bin/bash

if [ ! -f /starbound/assets/packed.pak ]; then
	echo "No /starbound/assets/packed.pak found!  Make sure you mount this from a licensed Starbound installation!"
	exit 1;
fi

cd /starbound/linux
/starbound/linux/starbound_server "$@"