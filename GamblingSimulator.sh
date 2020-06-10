	read -p "Enter the Stake " STAKE
	read -p "Enter the bet for everygame" BET_EVERY_GAME
	WON=1;
	read -p "Enter the % limt of win or loss" LIMIT_PERCENTAGE
	read -p "Enter the number of days you want to play" TOTAL_DAYS
   LIMIT_VALUE=$(($LIMIT_PERCENTAGE*$STAKE/100))
   winningAmountforResign=$(($STAKE*$LIMIT_PERCENTAGE/100+$STAKE));
   echo "   Maximum amount to resign = $winningAmountforResign"
   losingAmountforResign=$(($STAKE-$STAKE*$LIMIT_PERCENTAGE/100));
   echo "   Minimum amount to resign = $losingAmountforResign"

	function stakecalculator(){
	stakeEveryDay=$STAKE
	while [[ $stakeEveryDay -lt $winningAmountforResign && $stakeEveryDay -gt $losingAmountforResign ]]
	do
	Decider=$((RANDOM%2))
		if [ $Decider -eq $WON ]
		then
			stakeEveryDay=$(( $stakeEveryDay+$BET_EVERY_GAME ))
		else
			stakeEveryDay=$(( $stakeEveryDay-$BET_EVERY_GAME ))
		fi
	done
	}

	declare -A resultsDayWise


	TOTAL_AMOUNT=0
	WINS=0
	LOSSES=0
	function monthlyCalculator(){
	for (( day=0; day<$TOTAL_DAYS; day++ ))
	do
	stakecalculator
		if [ $stakeEveryDay -eq $winningAmountforResign ]
		then
			TOTAL_AMOUNT=$(( TOTAL_AMOUNT+LIMIT_VALUE ))
			resultsDayWise["Day $day"]=$TOTAL_AMOUNT
			(( WINS++ ))
		else
			TOTAL_AMOUNT=$(( TOTAL_AMOUNT-LIMIT_VALUE ))
			resultsDayWise["Day $day"]=$TOTAL_AMOUNT
			(( LOSSES++ ))
		fi
	echo "Day "$day " = $TOTAL_AMOUNT"
	done


	echo "No of days won = $WINS  by $((WINS*LIMIT_VALUE)) "
	echo "No of days lost are $LOSSES by  $((LOSSES*LIMIT_VALUE))"


	luckyDayValue=$( printf "%s\n" ${resultsDayWise[@]} | sort -nr | head -1 )
	luckyDayKey=$( printf "%s\n" ${!resultsDayWise[@]} | sort -nr | head -1 )

	unluckyDayValue=$(  printf "%s\n" ${resultsDayWise[@]} | sort -nr | tail -1 )
	unluckyDayKey=$(  printf "%s\n" ${!resultsDayWise[@]} | sort -nr | tail -1 )

	echo "Lucky Day is $luckyDayKey $luckyDayValue "
	echo "UnLucky Day is $unluckyDayKey $unluckyDayValue "
	}
	monthlyCalculator
	monthsPlayed=1
	while [ $TOTAL_AMOUNT -gt 0 ]
	do
	echo "Yes You Can Play For Next month"
	monthlyCalculator
	(( monthsPlayed++ ))
	done
	echo "Total months played $monthsPlayed"
