#!/usr/bin/env bash

# get_players_metadata.sh
#
# Description: get info from each MPRIS client
# Author: demingongo
# Link: https://github.com/demingongo
# Availability: https://github.com/demingongo/awesomewm-dotfiles

# help
Help()
{
   # Display Help
   echo "Add description of the script functions here."
   echo
   echo "Syntax: get_players_metadata.sh [options]"
   echo
   echo "options:"
   echo "	--h			Print help."
   echo "	--i			Name of players to be ignored. Separated by colon."
   echo
}

# read options
while getopts ":hi:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      i) # ignore-player
	 ignore_player=$OPTARG
   esac
done

# build command to list players
list_cmd="playerctl -l"
if [ -n "$ignore_player" ]; then
    list_cmd="${list_cmd} --ignore-player=$ignore_player"
fi
list_cmd="${list_cmd} 2> /dev/null"

# get list of players
players=$(eval "$list_cmd")

result=""

for player in $players
do  # get metadata for each player
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
