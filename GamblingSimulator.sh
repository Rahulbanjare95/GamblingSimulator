#!/bin/bash -x
#Welcom to Gambling Simulator Problem

	stakeEveryDay=100
	betEveryGame=1

	Decider=$((RANDOM%2))  #generates a random value 1 or 0 
	won=1;
	lost=0;

#if condition decides winner or looser by comparing random values with win or lost variables
	if [ $Decider -eq $lost ]; 
	then
		echo "Lost"
	else
		echo "Won"
	fi
