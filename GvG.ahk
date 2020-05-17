MessageWithSound(message){
	SoundPlay *-1
	MsgBox %message%
}


^!-:: ;altGr+7 abort 1
Abort(13)
return

;;test
^!8::
	i=200
	MessageWithSound("Testing "+i)
return

ShowToolTip(message){
	ToolTip, %message%, 50, 100
	SetTimer, RemoveToolTip, -15000
}

RemoveToolTip:
	ToolTip
return

^!2::
	SelectTwoTankArmy()
return

^!9:: ;law goods quest
M=0
F=0
totalWave=4

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
						Abort(14)
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
	Abort(13)
	Sleep, 1000
	AbortCord(218, 370, 399, 394, 1) ; abort from top
	Sleep, 1000
	Abort(13)
	
	M++
}
return


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

ClickButtonWithColor(x1, y1, x2, y2, color){
	i=0
	While i<5 
	{
		PixelSearch, Px, Py, x1, y1, x2, y2, color, 3, Fast RGB ;x1, y1, x2, y2 - brown color
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
		sleepSec := 500+((i**2)*100)
		sleep, %sleepSec%
	}
	return false
}

AutoAttack(x1, y1, x2, y2) {
	return ClickButtonWithColor(x1, y1, x2, y2, 0x945020)
}

FightDone(x1, y1, x2, y2) {
	return ClickButtonWithColor(x1, y1, x2, y2, 0x537f1d)
}

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


^!a::  ;ctrl+alt+a -- auto attack
MouseGetPos, xpos, ypos
Click, 1218,1007 ; place
MouseMove, xpos, ypos
return

f3:: ;click
Click
return

^f1:: ; get mouse postion
	MouseGetPos, xpos, ypos 
	MsgBox, The cursor is at X:%xpos% Y:%ypos%.
return


^!0:: ; Aid
j=0
x=315
While j<5 {
	XP:=x+(j*115)
	YP=1395
	Click, %XP%, %YP%
	Sleep, 1000
	Click, %XP%, %YP%
	Sleep, 1000
	j++
}
Click, 924, 1342

return

^Esc::Reload ;ExitApp
