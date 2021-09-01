gColorBx:=0
gColorBy:=0
f7:: ;altGr+7 abort 1
Abort(12)
return

;;test
^!8::
	while(true) {
		ShowToolTip("Going to activate DWR", -1000)
		WinGet, activeWinId ,, A ; <-- need to identify window A = acitive
		MouseGetPos, xpos, ypos
		if WinExist("DWR-Next") {
			WinActivate  ; Automatically uses the window found above.
			Sleep, 10
			Click, 200, 50 
			Sleep, 100
			WinActivate ahk_id %activeWinId%
			MouseMove, xpos, ypos
		} else {
			ShowToolTip("Not found")
		}
		Sleep, 300000 ;5min
	}
return

^!7::
	SelectArmy()
return

^!2::
	i=0
	MouseGetPos, xpos, ypos
	
	while i<20 {
		Click, %xpos%, %ypos%
		Sleep, 2000
		Click, %xpos%, %ypos%
		Sleep, 1000
		i++
	}
return

^!9:: ;law goods quest
M=0
F=0
totalWave=3

While M<1800 {
	i=0

	;While i<totalWave {
		Sleep, 500
		while (LawGoodsFightButtonClick()=false){
			ShowToolTip("Could not find the fight button, abort 1")
			Abort(1)
			M++
		}

		if FindArmyWindow() = true { 
			;MsgBox, Army Window showed
			SelectArmy()
			if AutoAttack(811, 809, 987, 843) = true {
				Random, rand1, 1500, 2500
				Sleep, %rand1%
				if AutoAttack(811, 809, 987, 843) = true {
					Sleep, %rand1%
					FightDone(875, 785, 1056, 847)
					F++
					ShowToolTip("Total Fight count "+F)
				} else {
					if (ClickButtonWithColor(700, 810, 760, 840, 0x7b2519)=true) {  ;retreat
						if ClickButtonWithColor(1005, 640, 1150, 670, 0x7b2519) = true { ;surrender ;)
							i-- ;go back one step
						}
					} else {
						MessageWithSound("Breaking Cause No 2nd Wave, Fight "+F)
						return
					}
				}
			} else {
				MessageWithSound("Breaking Cause No 1st Wave, Fight "+F)
				return
			}
			
		}
		;else {
		;	MessageWithSound("Breaking Cause No 1st Wave, Fight "+F)
		;	return
		;}
		i++
	;}
	
}
return

f4:: ;ctrl+alt+q - AA set
	MouseGetPos, xpos, ypos
	topX:=1397 ; 1459
	topY:=612
	botX:=1459
	botY:=741
	i:=0
	while (i<4) {
		ShowToolTip("Looking for brown", -1000)
		if(ClickButtonWithColor(topX+(i*62), topY, botX+(i*62), botY, 0x945020, 1)=true ) {
			Str:="Clicked:"+gColorBx
			Str .=" - "
			Str .=gColorBy
			ShowToolTip(Str)		
			if(gColorBx>topX and gColorBy>topY and gColorBx<1452 and gColorBy<671) {
				ShowToolTip("Set")
				Sleep, 200  ; 1/10 second
				Click, 1385,873 ; place, green button
			}
			break
		}
		i++
	}
	MouseMove, xpos, ypos
return


f5::  ;ctrl+alt+s - set attack

Click, 1434,625 
Sleep, 200  ; 1/10 second
Click, 1398,957 ; place

return

f6::  ;delete reset attack
click 983, 959 ; delete head button
Click, 1433,643 ; troop button 
Sleep, 100 ; wait 100ms
Click 1388, 858 ; confirm delete
Sleep, 500 ; wait 500ms
Click, 1433,643 ; troop button 
Sleep, 200  ; wait 100ms
Click, 1370, 870 ; AA place button
Click, 1398, 957 ; other era place button
return

;1184, 808
f2::  ;ctrl+alt+a -- auto attack
	MouseGetPos, xpos, ypos
	if(ClickButtonWithColor(1200, 822, 1217, 860, 0xf0d29c, 1)=false) { ; 1168, 793, 1195, 809
		ShowToolTip("Looking for brown", -1000)
		if(ClickButtonWithColor(1122, 969, 1305, 1022, 0x945020, 1)=false ) {
			ShowToolTip("Looking for green", -1000)
			if (ClickButtonWithColor(1122, 969, 1305, 1022, 0x4a7219, 1)=false) {
				Click, 1218,1007 ; place
			}
		}
	}
	MouseMove, xpos, ypos
return

f3:: ;click
	fkey:=true
	while(fkey=true) {
		Click
		Sleep, 10
		i++
		fkey := GetKeyState(F3, P)
	}
return

^f1:: ; get mouse position
	MouseGetPos, xpos, ypos 
	
	
	;CoordMode, mouse, Relative

	WinGetActiveStats, Title, Width, Height, X, Y
	
	rightX := Width - xpos
	botY := Height - ypos
	
	MsgBox, From LeftX:%xpos%, TopY:%ypos%, RightX: %rightX%, BotY: %botY% Window Info: Title: %Title%, Width: %Width%, H: %Height%
return

^!-:: ; Aid from history
	WinGetActiveStats, Title, Width, Height, X, Y
	halfW:= Width//2
	halfH:=Height//2
	
	topX := halfW + 343
	topY := halfH - 21
	
	botX := halfW + 476
	botY := halfH + 271
	
	randPoX := halfW + 472
	randPoY := halfH + 347
	
	nextTopX := halfW + 52
	nextTopY := halfH + 286
	nextBotX := halfW + 78
	nextBotY := halfH + 313
	While(true) {
		 ;While ClickButtonWithColor(1629, 678, 1763, 982, 0x945020, 2) = true { ;- brown color
		 
		 While ClickButtonWithColor(topX, topY, botX, botY, 0x945020, 2) = true { ;- brown color
			Sleep, 1500
			Click, %randPoX%, %randPoY% ; Click on random postion to remove GB print window
			Sleep, 500
		 }
		 ShowToolTip("Looking for next page")
		 
		 Sleep, 1000
		 
		 if (ClickButtonWithColor(nextTopX, nextTopY, nextBotX, nextBotY, 0x4d5870, 3) = true ) {
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

!^=:: ;; Find Snipe GB
	WinGetActiveStats, Title, Width, Height, X, Y
	botY := Height-71
	LeftXArr := [359, 466, 574, 682, 788] ; 108 every next
	nextBtnX:=924
	halfW:= Width//2
	halfH:=Height//2
	OkX := halfW
	OkY := halfH+275
	tX := halfW+275
	tY := halfH - 145
	total :=1
	While (total < 20) {
		For index, leftX in LeftXArr {
			ShowToolTip("Clicking..."+leftX)
			Click, %leftX%, %botY%
			
			if (FindWindowWithButtonAndTitleBar(OkX, OkY, 0x945020, tX, tY, 0x5f2216)) {
				ShowToolTip("found gb list")
				i:=0
				While (i<3) {
					bX := halfW+263
					bY := halfH-45+(i*30)
					Click, %bX%, %bY%
					if(FindWindowWithButtonAndTitleBar(halfW, halfH+320, 0x945020, tX, halfH-245, 0x5f2216)) { ;;950 850 - 1190 284
						Click, 750, 95 ; click on top mid to close window
						Sleep, 500
					} else {
						ShowToolTip("Gb window not found")
						break
					}
					i++
				}
			} else {
				ShowToolTip("not found...")
			}
			
			Click, 750, 95 ; click on top mid to close window
			Sleep, 500
		}
		Click %nextBtnX%, %botY%
		sleep, 100
		total++
	}
return

^Esc::Reload ;ExitApp

FindWindowWithButtonAndTitleBar(bx, by, bC, tx, ty, tC) {
	bx0 := bx-50
	by0 := by-10
	bx1 := bx+50
	by1 := by+10
	
	tx0 := tx-10
	ty0 := ty-10
	tx1 := tx+10
	ty1 := ty+10
	i :=0
	While(i<3) {
		str := Format("{1}{2},{3} - {4},{5}", "Searching: ",bx0, by0, bx1, by1)
		ShowToolTip(str)
		PixelSearch, Px, Py, %bx0%, %by0%, %bx1%, %by1%, %bC%, 3, Fast RGB ;x1, y1, x2, y2 - brown color 0x945020
		if ErrorLevel <=0 
		{
			ShowToolTip("Searching title")
			PixelSearch, Px, Py, %tx0%, %ty0%, %tx1%, %ty1%, %tC% , 3, Fast RGB ;maroon 0x5f2216
			
			if ErrorLevel <=0
				return true
		} else {
			;MsgBox Not found
			i++
		}
		sleepSec := 500+((i**2)*100)
		sleep, %sleepSec%
	}
	return false
}


SelectArmy() {
	i=0
	While i<8 { ;remove troops
		Click, 672, 461
		sleep, 100
		i++
	}
	Random, rand, 0, 1
	
	;click on menu
	Click, 1332, 617
	sleep, 300
	
	;select All age
	Click, 1214, 639
	sleep, 200
		
	;click on tank 
	;Click, 817, 617
	;sleep, 50
	;	Click, 1023, 676
	;	sleep, 100
		
		
	;click on range 
	;Click, 949, 617
	;sleep, 50
	;	Click, 1023, 676
	
	;Artillery
	Click, 906, 617
	sleep, 50
		Click, 1023, 676
	; --------	
	sleep, 50
		Click, 1023, 676
		
	if (rand==1) { ;random, if 1 then add one more normal troop
	sleep, 50
		Click, 1023, 676
	}
		sleep, 100
	
	;i=0
	;take 2 tanks
	;While i<2 {
	;	Click, 1351, 852
	;	sleep, 100
	;	i++
	;}
	
	;click on menu
	Click, 1332, 617
	sleep, 300
	
	;select bronze
	Click, 1254, 662
	sleep, 200
	
	;Click on light unit
	Click 861, 617
	sleep, 200
	
	rogueCount := (7-rand)
	i=0
	; take rogues from bronze era
	While i< rogueCount {
		Click, 751, 678
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
				MouseMove, 50, 70
				ShowToolTip("Abort "+i, -900)
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
	While i<2 
	{
		PixelSearch, Px, Py, 457, 434, 491, 445, 0xecf2ef, 3, Fast RGB ; 472 437 484 443 ; 460 436 484 443 ;;433, 411, 496, 464, 0x8c4b1d
		if ErrorLevel <=0 
		{
		   ; MsgBox, A color within 3 shades of variation was found at X%Px% Y%Py%.
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
;;;;;

FindArmyWindow() {
	i=0
	While i<5 
	{
		PixelSearch, Px, Py, 932, 443, 946, 445, 0x9b7d47, 3, Fast RGB ;x1, y1, x2, y2 - brown helmet color
		if ErrorLevel <=0 
		{
		   ; MsgBox, A color within 3 shades of variation was found at X%Px% Y%Py%.
			;Click, %Px%, %Py%
			PixelSearch, Px, Py, 1036, 441, 1054, 447, 0xa42c2c, 3, Fast RGB ;x1, y1, x2, y2 - red helmet color
			
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
		   global gColorBx:=Px
		   global gColorBy:=Py

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
