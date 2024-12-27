########################## SHOWS VN STATS ON IRC CHANNEL ##############################
# original script started by: "slv-vnstat.tcl by silver 20061124"
# modified and updated by:  " terra-vnstat.tcl by TeRRaDude 12242024"
#
# SETUP:
# 1): apt install vnstat eg. Debian
# 2): check ../etc/vnstat.conf to change output setting to fit your needs.
# 3): ...
# 4): Add sources scripts/terra-vnstat.tcl to your eggdrop.conf. 
# 5): Change #channelname
# 6): .rehash / trigger = !vnstat
#
set staffchanvnstat "#channel"
#
# End of config ###############################
# optional you can change below the: [exec $vnstat -m] 
# 
# -d 	--days [limit] 	show days
# -m 	--months [limit] 	show months
# -y 	--years [limit] 	show years
#
##############################################
## DONT EDIT BLOW UNLESS YOU KNOW WAT TO DO ##
##############################################
set vnstat {/usr/bin/vnstat}
bind pub -|- !vnstat pub:slv-vnstat

proc pub:slv-vnstat {nick uhost handle chan arg} {
        global vnstat slvvnstat staffchanvnstat
        if {$chan == $staffchanvnstat} {
                if {$arg == ""} {
		        foreach line [split [exec $vnstat -m] "\n" ] {
				if {$line != ""} {
				        putquick "PRIVMSG $chan :\0037vnstat\0039 $line"
				}
			}
		}
                if {$arg != ""} {
                        if {$arg == "--help"} {
			        foreach line [split [exec $vnstat --help] "\n" ] {
					if {$line != ""} {
					        putquick "PRIVMSG $nick :\037vnstat\037 $line"
					}
				}
			} else {
		        	foreach line [split [eval [concat exec $vnstat $arg]] "\n" ] {
					if {$line != ""} {
				        	putquick "PRIVMSG $chan :\0037vnstat\0039 $line"
					}
				}
			}
		}
	}
	putquick "PRIVMSG $chan :\0037vnstat\0030     +----------------------------------------------------------------------+"
	putquick "PRIVMSG $chan :\n"
}

putlog "terra-vnstat.tcl updated by terradude 20241224"
