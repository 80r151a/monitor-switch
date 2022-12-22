#!/bin/bash


## Declaring video port names
# Internal display
intern=eDP-1
# HDMI connection port
externHdmi1=HDMI-1
# Type-C connection port
externDp1=DP-1


## Function to update the wallpaper after switching the display mode (behavior)
function updates_wallpaper () {

	# Image path for feh
	pathToPic=/home/borisla/Pictures/.system/firewatch-1658000311845-5700.jpg
	# Setting wallpaper with feh
	feh --bg-fill "$pathToPic"

}


## Function to update i3 configuration after switching display mode (behavior)
function updates_i3_config () {
	
	# Restarting i3 in place (saves the layout/session used to update i3) via keystroke emulation
        xdotool key Super+Shift+r

}


## Function enables behavior based on port connection status
function enabled_behavior () {

	## First behavior
	# Turning on the internal monitor if Type-C and HDMI are not connected
	if [ "$connectionHdmi1" == 0 ] && [ "$connectionDp1" == 0 ]
	then
		# Protection against repeated execution of a block of instructions (the condition checks whether a block of instructions of this state has been executed using the indicator behaviorState)
		if [ "$behaviorState" != "first" ]
		then
			# Disabling "externDp1"(Type-C aka DP-1) and "externHdmi1"(HDMI aka HDMI-1) ports and enabling internal display "intern"(eDP-1) as primary display
			xrandr --output "$externDp1" --off --output "$externHdmi1" --off --output "$intern" --auto --primary

			# Function to update the wallpaper after switching the display mode (behavior)
			updates_wallpaper
			
			# Delay between wallpaper update and i3 update (delay removes polybar duplication effect)
			sleep 1

			# Function to update i3 configuration after switching display mode (behavior)
			updates_i3_config


			# Status indicator (indicates which status is active so as not to re-execute the instruction)
			behaviorState="first"
        		
			# Trace result
        		echo "first behavior on"
		fi
	fi


	## Second behavior
	# Disabling Type-C and internal display when connecting HDMI
	if [ "$connectionHdmi1" == 1 ] && [ "$connectionDp1" == 0 ]
	then
		# Protection against repeated execution of a block of instructions (the condition checks whether a block of instructions of this state has been executed using the indicator behaviorState)
		if [ "$behaviorState" != "second" ]
		then
			# Disable "externDp1"(Type-C aka DP-1), enable "externHdmi1"(HDMI aka HDMI-1) as primary display to the left of internal display "intern" (eDP-1), disable internal display "$intern"
			xrandr --output "$externDp1" --off  --output "$externHdmi1" --auto --primary --left-of "$intern" --output "$intern" --off

			# Function to update the wallpaper after switching the display mode (behavior)
			updates_wallpaper
			
			# Delay between wallpaper update and i3 update (delay removes polybar duplication effect)
			sleep 1

			# Function to update i3 configuration after switching display mode (behavior)
			updates_i3_config

			# Status indicator (indicates which status is active so as not to re-execute the instruction)
			behaviorState="second"

        		# Trace result
        		echo "second behavior on"
		fi
	fi


	## Third behavior
	# When turning off the HDMI display, leave the Type-C display on (if it is on and rotate it to the right) and turn on the internal display
	if [ "$connectionHdmi1" == 0 ] && [ "$connectionDp1" == 1 ]
	then
		# Protection against repeated execution of a block of instructions (the condition checks whether a block of instructions of this state has been executed using the indicator behaviorState)
		if [ "$behaviorState" != "third" ]
		then
			# Enabling "intern" of the internal display(eDP-1) and setting it as the main display, enabling "externDp1"(Type-C aka DP-1) setting it to the left of the internal display and turning it to the right, and positioning from pixel 0, disabling "externHdmi1"(HDMI aka HDMI-1)
			xrandr --output "$intern" --auto --primary --output "$externDp1" --auto --left-of "$intern" --rotate right --pos 0x0 --output "$externHdmi1" --off
			
			# Function to update the wallpaper after switching the display mode (behavior)
			updates_wallpaper
			
			# Delay between wallpaper update and i3 update (delay removes polybar duplication effect)
			sleep 1

			# Function to update i3 configuration after switching display mode (behavior)
			updates_i3_config

			# Status indicator (indicates which status is active so as not to re-execute the instruction)
			behaviorState="third"

        		# Trace result
        		echo "third behavior on"
		fi
	fi


	## Fourth behavior
	# Disable internal display when HDMI and Type-C displays are connected
	if [ "$connectionHdmi1" == 1 ] && [ "$connectionDp1" == 1 ]
	then
		# Protection against repeated execution of a block of instructions (the condition checks whether a block of instructions of this state has been executed using the indicator behaviorState)
		if [ "$behaviorState" != "fourth" ]
		then
			# Enabling "externDp1"(Type-C aka DP-1) setting it to the left of the internal display and turning it to the right, and positioning from pixel 0, enable "externHdmi1"(HDMI aka HDMI-1) as primary display to the left of "externDp1"(Type-C aka DP-1) , disable internal display "intern"(eDP-1)
			xrandr --output "$externDp1" --auto --left-of "$intern" --rotate right --pos 0x0 --output "$externHdmi1" --auto --primary --left-of "$externDp1" --output "$intern" --off

			# Function to update the wallpaper after switching the display mode (behavior)
			updates_wallpaper
			
			# Delay between wallpaper update and i3 update (delay removes polybar duplication effect)
			sleep 1

			# Function to update i3 configuration after switching display mode (behavior)
			updates_i3_config

			# Status indicator (indicates which status is active so as not to re-execute the instruction)
			behaviorState="fourth"

			# Trace result
        		echo "fourth behavior on"
		fi
	fi


	## Fifth behavior
	# Enable internal monitor when internal display and external displays (HDMI and Type-C) are disabled
	if [ "$connectionHdmi1" == 0 ] && [ "$connectionDp1" == 0 ] && [ "$connectionEdp1" = 0 ]
	then
		# Protection against repeated execution of a block of instructions (the condition checks whether a block of instructions of this state has been executed using the indicator behaviorState)
		if [ "$behaviorState" != "fifth" ]
		then
			# Enable "$intern" internal display (eDP-1) and set it as primary, disable "externDp1" (Type-C aka DP-1), disable "externHdmi1" (HDMI aka HDMI-1)
			xrandr --output "$intern" --auto --primary "$externDp1" --off --output "$externHdmi1" --off
			
			# Function to update the wallpaper after switching the display mode (behavior)
			updates_wallpaper
			
			# Delay between wallpaper update and i3 update (delay removes polybar duplication effect)
			sleep 1

			# Function to update i3 configuration after switching display mode (behavior)
			updates_i3_config

			# Status indicator (indicates which status is active so as not to re-execute the instruction)
			behaviorState="fifth"

        		# Trace result
        		echo "fifth behavior on"
		fi
	fi
}


## Loop determining which ports are connected
while :
do
	# Xrandr output about connected ports
	xrandrOutput=$(xrandr | grep -w connected)


	# HDMI port status definitions ( 1 = connected; 0 = disconnected )
	if echo "$xrandrOutput" | grep -w "$externHdmi1"
	then
        	connectionHdmi1=1
	else
		connectionHdmi1=0
	fi

	# Value trace
	#echo "$connectionHdmi1"
	

	# Type-C port status definitions ( 1 = connected; 0 = disconnected )
	if echo "$xrandrOutput" | grep -w "$externDp1"
	then
       		connectionDp1=1
	else
		connectionDp1=0
	fi

	# Value trace
	#echo "$connectionDp1"


	# External port status definitions (1 = connected; 0 = disconnected )
	if echo "$xrandrOutput" | grep -w "$intern"
	then
        	connectionEdp1=1
	else
		connectionEdp1=0
	fi
	
	# Value trace
	#echo "$connectionEdp1"
	
	
	# Calling a function with arguments (connection statuses to ports)
	enabled_behavior  $connectionEdp1  $connectionDp1  $connectionHdmi1 
	
	# Delay to increase performance
	sleep 5

done
