#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Local $form = GUICreate("Animation", 300, 300)
Local $lbl_prompt = GUICtrlCreateLabel("Entrez un chiffre entre 1 et 5 :", 10, 10, 200, 20)
Local $input_number = GUICtrlCreateInput("", 10, 40, 50, 20)
Local $btn_go = GUICtrlCreateButton("Go", 70, 40, 50, 20)

Local $squares[5]
For $i = 0 To 4
    $squares[$i] = GUICtrlCreateLabel("", 50 + ($i * 50), 80, 30, 30)
    GUICtrlSetBkColor($squares[$i], 0xFF0000 + ($i * 0x002020))
Next

GUISetState(@SW_SHOW)

While True
    Local $msg = GUIGetMsg()
    If $msg = $GUI_EVENT_CLOSE Then ExitLoop

    If $msg = $btn_go Then
        Local $number = GUICtrlRead($input_number)

        If StringIsInt($number) And $number >= 1 And $number <= 5 Then
            Local $square = $squares[$number - 1]
            MoveSquareDown($square)
        Else
            MsgBox($MB_ICONERROR, "Erreur", "Veuillez entrer un chiffre valide entre 1 et 5.")
        EndIf
    EndIf
WEnd

GUIDelete($form)

Func MoveSquareDown($square)
    Local $pos = $square.x ;Je veuc le x de $square, mais je ne sais pas comment faire.
    If @error Then
        MsgBox($MB_ICONERROR, "Erreur", "Le contrôle du carré est invalide.")
        Return
    EndIf

    For $i = $pos[1] To 250 Step 5
        GUICtrlSetPos($square, $pos[0], $i)
        Sleep(50)
    Next
EndFunc