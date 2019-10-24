#!/bin/bash

checksums=( "01112" "23824" "40805" "xxxxx" "65646" )
words=("cod" "inventor" "journey" "xxxxx" "forest")
mark=0

function loadPython {

	curl -s -o rememberme.zip http://doc.gold.ac.uk/www/277/rememberme > /dev/null && unzip rememberme.zip > /dev/null
	chmod 777 rememberme/baseutils.py
}

function checkScript {

	filename=$1

	loadPython

	mark=$( rememberme/baseutils.py $filename "mark")
	username=$( rememberme/baseutils.py $filename "getusername")

}

function checkWord {


	isMemoryValid=false
	isPrevMemoryValid=false
	local crc="00000"

	old_IFS=$IFS
	IFS=$'\n'
	lines=($(cat memories.txt)) # array
	IFS=$old_IFS

	for p in "${lines[@]}"; do
		crc=$( rememberme/baseutils.py "x" "addcrc" ${p:0:4} $crc)
		#echo $p
		#echo $crc
	done

	# echo $crc
	# echo "$1"

	local prevIndex=$(( $1 -  1 ))

	if [ "$crc" = "${checksums[$1]}" ] ; then
		isMemoryValid=true
		local level=$((200 + $1))
		rememberme/baseutils.py $filename "score" $level ${words[$1]}
		echo "success"${words[$1]}
	elif [ "$crc" = "${checksums[$prevIndex]}" ]; then
		isPrevMemoryValid=true
	fi

	rm -r rememberme
	rm rememberme.zip

}

function pause {
	local count=0
	while [ $count -lt $1 ]; do
		echo ...
		sleep 2
		let count=count+1
	done
}

function task1 {
	clear
	pause 1
	echo "Hi"
	pause 1
	echo "It’s so nice of canary.bird to have brought you here. Let me introduce myself. "
	pause 1
	echo "I am the famous mock turtle."
	pause 1
	echo "What do you mean you’ve never heard of a mock turtle !"
	pause 1
	echo "I’m the thing that Mock Turtle Soup is made from."
	pause 1
	clear
	echo "I’m very sad. Can you help me ?"
	pause 1
	echo "Great I knew you would."
	pause 1
	clear
	echo "I am very old and I used to have so many memories"
	pause 1
	echo "but now they have all slipped away."
	pause 1
	echo "Check the memories.txt in this directory and you will see that it’s totally blank"
	pause 1
	echo "It wasn’t always this way."
	pause 1
	clear
	echo "My mind used to be full of rich and delicious memories."
	pause 1
	echo "Now I need you to find them"
	pause 1
	echo "I hear that you have just learnt how to use a strange tool called git which can help you recover things when you’ve lost them."
	pause 1
	echo "Let’s start by recovering my very first memory."
	pause 1
	echo "Use 'git log --oneline' to find out its name and then cut and paste this into the first line of my memories."
	pause 1
	echo "Be sure to use a proper code editor like atom or sublime. Don't use textedit or notepad !"
	pause 1
	echo "Once you have done this RUNME again"
	pause 1
}

function task2 {
	clear
	echo "Ah yes school that was my first memory."
	pause 1
	echo "I went to school in the sea."
	pause 1
	echo "Most of my classmates were fish."
	pause 1
	echo "Tuna mostly but also some cod"
	pause 1
	echo "Nobody understood me there."
	pause 1
	echo "It was a sad and lonely time."
	pause 1
	echo "Perhaps you can help me find a happier memory ?"
	pause 1
	clear
	echo "I think my second year of school was a little happier"
	pause 1
	echo "Find the commit using 'git log --oneline' and travel back in time by using 'git checkout' "
	pause 1
	pause 1
	echo "When you go back in time my memories will be different"
	pause 1
	echo "Don't be alarmed. This is totally natural."
	pause 1
	echo "However, make sure you use git 'commit -am' to store these memories first or they will be lost again."
	pause 1
	echo "Once you have travelled back in time, RUNME and I will tell you my memories from that time."
	pause 1
	echo "Return to this time (the master branch) with the happy memory and add it to a new line in memories.txt"
}


function task3 {
	clear
	echo "Ah Tortoise yes I remember her."
	pause 1
	echo "Thankyou I feel much better about my school days now."
	pause 1
	echo "Ah I remember so much more now"
	pause 1
	echo "After I left school I became an inventor"
	pause 1
	echo "I would have been a great success but for one problem"
	pause 1
	echo "With each new invention I forgot the last"
	pause 3
	clear
	echo "Use 'git tag -l' to view all the tags for my inventions"
	pause 1
	echo "Each tagged commit has an invention in it in a file called inventions.txt"
	pause 1
	echo "Now use the form 'git checkout tagName -- inventions.txt' to bring each invention to the present"
	pause 1
	echo "Notice that each inventions.txt replaces the old inventions.txt"
	pause 1
	echo "Luckily you are here so that you can help me to not forget them"
	pause 1
	echo "Each time open inventions.txt and cut and paste the invention to a new line of memories.txt"
	pause 1
	echo "When you have found all of my inventions RUNME again"
}

function task4 {
	clear
	echo "Everything is becoming clearer to me now"
	pause 1
	echo "Something is coming out the fog of my memory"
	pause 1
	echo "I seem to remember something about a long journey"
	pause 1
	echo "Use 'git branch -r' to find a remote branch for this"
	pause 1
	echo "Then use 'git checkout' to explore the branch and RUNME"
	pause 1
	echo "When you go back in time, all of the current memories will disappear"
	pause 1
	echo "Don't be alarmed. This is totally natural as they won't have happened yet."
	pause 1
	echo "However you must commit the current memories here first using 'git commit -am'"
	pause 1
	echo "I wouldn't want to lose those wonderful memories again."
}

function task5 {
	clear
	echo "Thankyou so much."
	pause 1
	echo "I can remember everything now !"
	pause 1
	echo "I've just remembered something very important that Rabbit told me"
	pause 1
	echo "Your name is $username right ? "
	pause 1
	echo "Well then you need to go see Caterpillar in the forest"
	pause 1
	echo "You'll find him by the magic toadstool"
	pause 1
	echo "http://gitlab.doc.gold.ac.uk/underland/magicToadstool.git"
	pause 1
	echo "Don't forget to keep you score file safe (you know the one thats starts with 'aiw_'). "
	pause 1
	echo "Maybe you could store it in a repo of your own ?"
}

function badMemory {
	#clear
	echo "It looks like something is wrong in your memories"
	pause 1
	echo "Perhaps you tried to take a short cut ?"
	pause 1
	echo "Remember that there are no short cuts in underland"
	pause 1
	echo "Remove any extra memories that you just added and try again"
}

filename=$1

if [ ${#filename} = 0 ] ;then
	pause 1
	echo "To run me you must pass a valid path to your score file as an argument."
	pause 1
	echo "For example ~/Desktop/aiw_skata001"
	pause 1
	echo "Have another go".
	exit
elif [ ! -f $filename ] ;then
	pause 1
	echo "The scorefile cannot be found in that location"
	pause 1
	echo "Have another go".
	exit
else
	checkScript $1
	echo "mark: " $mark
	if [ $mark -eq 1 ]; then
		checkWord 0
		if [ "$isMemoryValid" = true ]; then
			task2
		else
			task1
		fi
	elif [ $mark -eq 4 ]; then
		checkWord 1
		if [ "$isMemoryValid" = true ]; then
			task3
		elif [ "$isPrevMemoryValid" = true ]; then
			task2
		else
			badMemory
		fi
	elif [ $mark -eq 6 ]; then
		checkWord 2

		if [ "$isMemoryValid" = true ]; then
			task4
		elif [ "$isPrevMemoryValid" = true ]; then
			task3
		else
			badMemory
		fi
	elif [ $mark -eq 8 ]; then
		task4
		rm -r rememberme
		rm rememberme.zip
	elif [ $mark -eq 10 ]; then
		checkWord 4
		if [ "$isMemoryValid" = true ]; then
			task5
		else
			pause 1
			echo "Something is wrong with your memories."
			pause 1
			echo "Have you resolved your conflicts ?"
			pause 1
		fi
	elif [ $mark -eq 11 ]; then
		task5
		rm -r rememberme
		rm rememberme.zip
	else
		echo $mark
		#badMemory
		rm -r rememberme
		rm rememberme.zip
	fi
fi
