#!/bin/bash -x
#-------UC 1------

	stakeEveryDay=100
	betEveryGame=1

#-------UC 2-------

	Decider=$((RANDOM%2))  #generates a random value 1 or 0
	won=1;
	lost=0;
#if condition decides winner or looser by comparing random values with win or lost
	if [ $Decider -eq $lost ]
	then
		echo "Lost"
	else
		echo "Won"
	fi

#--------UC 3
	limitPercentage=50
	winningAmountforResign=$(($stakeEveryDay*$limitPercentage/100+$stakeEveryDay));
	echo "	Maximum amount to resign = $winningAmountforResign"
	losingAmountforResign=$(($stakeEveryDay-$stakeEveryDay*$limitPercentage/100));
	echo "	Minimum amount to resign = $losingAmountforResign"

	while [[ $stakeEveryDay -le $winningAmountforResign && $stakeEveryDay -ge $losingAmountforResign ]]
	do

	Decider=$((RANDOM%2))
		if [ $Decider -eq $won ]
		then
			stakeEveryDay=$(( $stakeEveryDay+$betEveryGame ))
		else
			stakeEveryDay=$(( $stakeEveryDay-$betEveryGame ))
		fi
	done
	echo "Limit Reached" $numberOfWinnifBet
