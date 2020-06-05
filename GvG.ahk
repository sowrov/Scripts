^!0:: ;altGr+7 abort 1
Abort(12)
return

;;test
^!8::
	i=200
	ShowToolTip("Not found", -1000)
return

^!2::
	SelectTwoTankArmy()
return

^!9:: ;law goods quest
M=0
F=0
totalWave=3

While M<1000 {
	i=0

	While i<totalWave {
		Sleep, 1000
		LawGoodsFightButtonClick()

		if FindArmyWindow() = true {
			;MsgBox, Army Window showed
			SelectTwoTankArmy()
			if AutoAttack(1125, 993, 1310, 1018) = true {
				Sleep, 4000
				if AutoAttack(1199, 993, 1378, 1051) = true {
					Sleep, 2000
					FightDone(1199, 993, 1378, 1051)
					F++
					ShowToolTip("Total Fight count "+F)
					if (i<(totalWave-1)) {
						Sleep, 1000
						Abort(13)
					}
				} else {
					MessageWithSound("Breaking Cause No 2nd Wave, Fight "+F)
					return
				}
			} else {
				MessageWithSound("Breaking Cause No 1st Wave, Fight "+F)
				return
			}
			
		}
		else {
			MessageWithSound("Breaking Cause No 1st Wave, Fight "+F)
			return
		}
		i++
	}

	Sleep, 2000
	ClickButtonWithColor(515, 170, 622, 209, 0x537f1d) ;collect button
	
	;some random click
	Sleep, 1000
	Click, 22, 402 
	Sleep, 800
	Click, 22, 402 
	Sleep, 500
	Click, 22, 402 
	
	Sleep, 100
	Abort(12)
	Sleep, 1000
	AbortCord(218, 370, 399, 394, 1) ; abort from top
	Sleep, 1000
	Abort(12)
	
	M++
}
return

^!q:: ;ctrl+alt+q - AA set
Click, 1434,625 
Sleep, 100  ; 1/10 second
Click, 1385,873 ; place

return


^!s::  ;ctrl+alt+s - set attack

Click, 1434,625 
Sleep, 100  ; 1/10 second
Click, 1398,957 ; place

return

^!d::  ;ctrl+alt+d - add DA

Click, 1294,527 ;8th postion
Click, 1059,652 ; place

return


^!o::  ;ctrl+alt+o -- old auto attack
MouseGetPos, xpos, ypos
Click, 1218,1007 ; place
MouseMove, xpos, ypos
return

f2::  ;ctrl+alt+a -- auto attack
	MouseGetPos, xpos, ypos
	if(ClickButtonWithColor(1122, 969, 1305, 1022, 0x945020, 1)=false ) {
		ShowToolTip("Looking for green", -1000)
		if (ClickButtonWithColor(1122, 969, 1305, 1022, 0x4a7219, 1)=false) {
			Click, 1218,1007 ; place
		}
	}
	MouseMove, xpos, ypos
return

f3:: ;click
Click
return

^f1:: ; get mouse postion
	MouseGetPos, xpos, ypos 
	
	
	;CoordMode, mouse, Relative

	WinGetActiveStats, Title, Width, Height, X, Y
	
	rightX := Width - xpos
	botY := Height - ypos
	
	MsgBox, From LeftX:%xpos%, TopY:%ypos%, RightX: %rightX%, BotY: %botY% Window Info: Title: %Title%, Width: %Width%, H: %Height%
return

^!-:: ; Aid from history
	While(true) {
		 While ClickButtonWithColor(1629, 678, 1763, 982, 0x945020, 2) = true { ;- brown color
			Sleep, 1500
			Click, 1760, 1055
			Sleep, 500
		 }
		 ShowToolTip("Looking for next page")
		 
		 Sleep, 1000
		 
		 if (ClickButtonWithColor(1340, 994, 1366, 1021, 0x4d5870, 3) = true ) {
			ShowToolTip("Found next page")
			Sleep, 2000
		 } else {
			ShowToolTip("No next page! Break")
			break
		 }
	}
	 ; 47526a - active next
	 ; 525252 - inactive next
return

!^m:: ;; Watch FE and AA
	WinGetActiveStats, Title, Width, Height, X, Y
	botY := Height-80
	;Click, 189, %botY% ; click on Gv map button
	;Sleep, 5000
	botYA := Height-314
	botYF := Height-763
	While (true) {
		Click, 982, %botYA% ; AA
		Sleep, 10000
		Click, 185, %botY% ; back button
		Sleep, 9000
		
		Click, 1250, %botYF% ; FE
		Sleep, 10000
		Click, 185, %botY% ; back button
		Sleep, 8000
	}
return

^Esc::Reload ;ExitApp


SelectTwoTankArmy() {
	i=0
	While i<8 { ;remove troops
		Click, 987, 644
		sleep, 100
		i++
	}
	
		
	;click on tank 
	Click, 1134, 795
	sleep, 50
		Click, 1351, 852
		sleep, 100
		
		
	;click on range 
	Click, 1271, 796
	sleep, 50
		Click, 1351, 852
		sleep, 100
	
	;i=0
	;take 2 tanks
	;While i<2 {
	;	Click, 1351, 852
	;	sleep, 100
	;	i++
	;}
	
	;click on menu
	Click, 1613, 793
	sleep, 300
	
	;select bronze
	Click, 1570, 843
	sleep, 200
	
	;Click on light unit
	Click 1180, 800
	sleep, 200
	
	i=0
	; take 6 rogues from bronze era
	While i<6 {
		Click, 1058, 852
		sleep, 100
		i++
	}
}


Abort(count) {
	AbortCord(250, 600, 390, 680, count)
}

AbortCord(x1, y1, x2, y2, count) {
	i=0
	While i<count 
	{
		PixelSearch, Px, Py, x1, y1, x2, y2, 0x7b2519, 3, Fast RGB
		if ErrorLevel <=0 
		{
		   ; MsgBox, A color within 3 shades of variation was found at X%Px% Y%Py%.
			sleep, 100
			PixelSearch, Px, Py, x1, y1, x2, y2, 0x7b2519, 3, Fast RGB
			if (ErrorLevel <=0) {
				Click, %Px%, %Py%
				MouseMove, 50, 50
				i++
			}
		} 
		else 
		{
			;MsgBox Not found
		}
		sleepSec := 500
		sleep, %sleepSec%
	}
}

LawGoodsFightButtonClick() {
	i=0
	While i<5 
	{
		PixelSearch, Px, Py, 433, 411, 496, 464, 0x8c4b1d, 3, Fast RGB
		if ErrorLevel <=0 
		{
		   ; MsgBox, A color within 3 shades of variation was found at X%Px% Y%Py%.
			Click, %Px%, %Py%
			return
		} 
		else 
		{
			;MsgBox Not found
			i++
		}
		sleepSec := 500+((i**2)*100)
		sleep, %sleepSec%
	}
	
}

FindArmyWindow() {
	i=0
	While i<5 
	{
		PixelSearch, Px, Py, 1125, 993, 1310, 1018, 0x945020, 3, Fast RGB ;x1, y1, x2, y2 - brown color
		if ErrorLevel <=0 
		{
		   ; MsgBox, A color within 3 shades of variation was found at X%Px% Y%Py%.
			;Click, %Px%, %Py%
			PixelSearch, Px, Py, 1309, 992, 1484, 1015, 0x537f1d, 3, Fast RGB ;x1, y1, x2, y2 - green color
			
			if ErrorLevel <=0
				return true
		} 
		else 
		{
			;MsgBox Not found
			i++
		}
		sleepSec := 500+((i**2)*100)
		sleep, %sleepSec%
	}
	return false
}

ClickButtonWithColor(x1, y1, x2, y2, color, totalTries:=5){
	i=0
	While i<totalTries 
	{
		if(i>0) {
			sleepSec := 500+((i**2)*100)
			sleep, %sleepSec%
		}
		
		PixelSearch, Px, Py, x1, y1, x2, y2, color, 3, Fast RGB ;x1, y1, x2, y2 
		if ErrorLevel <=0 
		{
		   Click, %Px%, %Py%
		   return true
		} 
		else 
		{
			;MsgBox Not found
			i++
		}
	}
	return false
}

AutoAttack(x1, y1, x2, y2) {
	return ClickButtonWithColor(x1, y1, x2, y2, 0x945020) ;- brown color
}

FightDone(x1, y1, x2, y2) {
	return ClickButtonWithColor(x1, y1, x2, y2, 0x537f1d) ;- green color
}


MessageWithSound(message){
	SoundPlay *-1
	MsgBox %message%
}

ShowToolTip(message, timeToStay:=-15000){
	ToolTip, %message%, 50, 100
	SetTimer, RemoveToolTip, %timeToStay%
}
RemoveToolTip:
	ToolTip
return
