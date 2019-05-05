#!/bin/bash

# A cli tool to search and view the Void Linux wiki
# Joe Standring <jstandring@pm.me>
# Forked from Dylan Schacht <deadhead3492@gmail.com>
# GNU GPLv3

if [ "--help" == "$1" ] || [ "-h" == "$1" ]; then
	this=${0##*/}
	echo
	echo "Usage: $this Void Wiki page name"
	echo
	echo "  where Void Wiki page name is title of page on wiki.voidlinux.org"
	echo
	echo "Examples:"
	echo "  $this vim"
	echo "  $this installation"
	echo "  $this musl"
	echo
	exit 0
fi

if [ -n "$BROWSER" ]; then run_browser=$BROWSER
else BROWSER=w3m int=1
	until [ -n "$run_browser" ]
	 do
		if (which $BROWSER &>/dev/null); then run_browser=$BROWSER
		elif [ "$int" -eq "1" ]; then BROWSER=elinks
		elif [ "$int" -eq "2" ]; then BROWSER=links
        elif [ "$int" -eq "2" ]; then BROWSER=lynx
		else
			echo "Please install one of the following packages to use this script: w3m elinks links lynx"
			exit 1
		fi
		int=$((int+1))
	 done
fi

query="$*"  # get all params into single query string
query=${query// /_}  # substitute spaces with underscores in the query string

exec "$run_browser" "https://wiki.voidlinux.org/index.php/Special:Search/${query}"
