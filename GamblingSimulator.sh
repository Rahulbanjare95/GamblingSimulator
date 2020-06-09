#!/bin/bash
#-------UC 1------

	stake=100
	betEveryGame=1

#-------UC 2-------

	Decider=$((RANDOM%2))  #generates a random value 1 or 0
	won=1;
	lost=0;


#--------UC 3
	limitPercentage=50
   limitValue=$(($limitPercentage*$stake/100))

   winningAmountforResign=$(($stake*$limitPercentage/100+$stake));
   echo "   Maximum amount to resign = $winningAmountforResign"
   losingAmountforResign=$(($stake-$stake*$limitPercentage/100));
   echo "   Minimum amount to resign = $losingAmountforResign"



function stakecalculator(){
	stakeEveryDay=$stake
	while [[ $stakeEveryDay -lt $winningAmountforResign && $stakeEveryDay -gt $losingAmountforResign ]]
	do
	Decider=$((RANDOM%2))
		if [ $Decider -eq $won ]
		then
			stakeEveryDay=$(( $stakeEveryDay+$betEveryGame ))
		else
			stakeEveryDay=$(( $stakeEveryDay-$betEveryGame ))
		fi
	done
}

	declare -A resultsDayWise
	totalamount=0
	totalDays=20
	wins=0
	losses=0
	for (( day=0; day<$totalDays; day++ ))
	do
	stakecalculator
		if [ $stakeEveryDay -eq $winningAmountforResign ]
		then
			totalamount=$(( totalamount+limitValue ))
			resultsDayWise["Day $day"]=$totalamount
			(( wins++ ))
		else
			totalamount=$(( totalamount-limitValue))
			resultsDayWise["Day $day"]=$totalamount
			(( losses++ ))
		fi
	done
	echo "No of days won = $wins  by $((wins*limitValue)) "
	echo "No of days lost are $losses by  $((losses*limitValue))"


	luckyDayValue=$( printf "%s\n" ${resultsDayWise[@]} | sort -nr | head -1 )
	luckyDayKey=$( printf "%s\n" ${!resultsDayWise[@]} | sort -nr | head -1 )

	unluckyDayValue=$(  printf "%s\n" ${resultsDayWise[@]} | sort -nr | tail -1 )
	unluckyDayKey=$(  printf "%s\n" ${!resultsDayWise[@]} | sort -nr | tail -1 )

	echo "Lucky Day is $luckyDayKey $luckyDayValue "
	echo "UnLucky Day is $unluckyDayKey $unluckyDayValue "

