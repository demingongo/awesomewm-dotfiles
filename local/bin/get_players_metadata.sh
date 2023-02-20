#!/usr/bin/env bash

# get_players_metadata.sh
#
# Description: get info from each MPRIS client
# Author: demingongo
# Link: https://github.com/demingongo
# Availability: https://github.com/demingongo/awesomewm-dotfiles


players=$(playerctl -l 2> /dev/null)

result=""

for player in $players
do
    player_metadata=$(playerctl -f '{{status}} ;{{xesam:artist}} ;{{xesam:title}} ;{{mpris:artUrl}} ;{{xesam:album}} ;{{xesam:albumArtist}} ;{{playerName}}' metadata --player="$player" 2> /dev/null)
    
    if [ -n "$player_metadata" ]; then
	if [ -n "$result" ]; then
		result="""$result
"""
    	fi
	result="$result$player_metadata"
    fi
done

echo "$result"
