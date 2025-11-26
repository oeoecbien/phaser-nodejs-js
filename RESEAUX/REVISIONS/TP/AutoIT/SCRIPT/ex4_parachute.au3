#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------


#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>

$hGUI = GUICreate("TP", 600, 400)
GUISetBkColor(0xFFFFFF)
GUISetState(@SW_SHOW)

Global $score = 0
Global $gameOver = False
Global $vitesseParachute = 2

$bateauX = 250
$bateauY = 320
$bateauLargeur = 100
$bateauHauteur = 60

$parachuteX = Random(0, 500)
$parachuteY = 0
$parachuteLargeur = 60
$parachuteHauteur = 80

$labelScore = GUICtrlCreateLabel("Score : " & $score, 500, 10, 100, 20)
GUICtrlSetFont($labelScore, 12, 800)

$bateauImage = GUICtrlCreatePic("bateau.jpg", $bateauX, $bateauY, $bateauLargeur, $bateauHauteur)
$parachuteImage = GUICtrlCreatePic("parachute.jpg", $parachuteX, $parachuteY, $parachuteLargeur, $parachuteHauteur)

While Not $gameOver
    If _IsPressed("25") And $bateauX > 0 Then
        $bateauX -= 5
        GUICtrlSetPos($bateauImage, $bateauX, $bateauY)
    EndIf
    If _IsPressed("27") And $bateauX < 500 Then
        $bateauX += 5
        GUICtrlSetPos($bateauImage, $bateauX, $bateauY)
    EndIf
    
    $parachuteY += $vitesseParachute
    GUICtrlSetPos($parachuteImage, $parachuteX, $parachuteY)
    
    If $parachuteY + $parachuteHauteur >= $bateauY Then
        If $parachuteX >= $bateauX - $parachuteLargeur And $parachuteX <= $bateauX + $bateauLargeur Then
            $score += 1
            GUICtrlSetData($labelScore, "Score : " & $score)
            $parachuteY = 0
            $parachuteX = Random(0, 500)
            $vitesseParachute += 0.2
        ElseIf $parachuteY >= 340 Then 
            $gameOver = True
        EndIf
    EndIf
    
    Sleep(10)
    
    If GUIGetMsg() = $GUI_EVENT_CLOSE Then
        Exit
    EndIf
WEnd

MsgBox(0, "Game Over", "Partie terminée ! Score final : " & $score)

Func _IsPressed($hexKey)
    Local $aResult = DllCall("user32.dll", "short", "GetAsyncKeyState", "int", "0x" & $hexKey)
    If @error Then Return False
    Return BitAND($aResult[0], 0x8000) <> 0
EndFunc