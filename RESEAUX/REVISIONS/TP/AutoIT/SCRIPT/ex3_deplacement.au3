#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>

$hGUI = GUICreate("Jeu", 400, 400)
GUISetState(@SW_SHOW)

$carreSize = 20
$posX = 190 
$posY = 190

$zoneX = 100
$zoneY = 100
$zoneWidth = 200
$zoneHeight = 200

$btnHaut = GUICtrlCreateButton("Haut", ($zoneX + $zoneWidth/2 - 30), 40, 60, 25)
$btnBas = GUICtrlCreateButton("Bas", ($zoneX + $zoneWidth/2 - 30), 335, 60, 25)
$btnGauche = GUICtrlCreateButton("Gauche", 20, ($zoneY + $zoneHeight/2 - 12), 60, 25)
$btnDroite = GUICtrlCreateButton("Droite", 320, ($zoneY + $zoneHeight/2 - 12), 60, 25)

While 1
    $hZone = GUICtrlCreateGraphic($zoneX, $zoneY, $zoneWidth, $zoneHeight)
    GUICtrlSetBkColor($hZone, 0xFFFF00)    ; Jaune
    
    $hGraphic = GUICtrlCreateGraphic($posX, $posY, $carreSize, $carreSize)
    GUICtrlSetBkColor($hGraphic, 0x000000)    ; Noir
    
    $msg = GUIGetMsg()
    
    Switch $msg
        Case $GUI_EVENT_CLOSE
            Exit
            
        Case $btnHaut
            $newPosY = $posY - 10
            If $newPosY >= $zoneY Then
                $posY = $newPosY
            Else
                MsgBox(0, "Attention", "Bord haut atteint!")
            EndIf
            
        Case $btnBas
            $newPosY = $posY + 10
            If $newPosY <= ($zoneY + $zoneHeight - $carreSize) Then
                $posY = $newPosY
            Else
                MsgBox(0, "Attention", "Bord bas atteint!")
            EndIf
            
        Case $btnGauche
            $newPosX = $posX - 10
            If $newPosX >= $zoneX Then
                $posX = $newPosX
            Else
                MsgBox(0, "Attention", "Bord gauche atteint!")
            EndIf
            
        Case $btnDroite
            $newPosX = $posX + 10
            If $newPosX <= ($zoneX + $zoneWidth - $carreSize) Then
                $posX = $newPosX
            Else
                MsgBox(0, "Attention", "Bord droit atteint!")
            EndIf
            
    EndSwitch
    
    GUICtrlDelete($hGraphic)
    GUICtrlDelete($hZone)
WEnd