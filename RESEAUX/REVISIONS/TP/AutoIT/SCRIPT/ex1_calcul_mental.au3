#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Func GenererCalcul()
    Local $operateurs[3] = ["+", "-", "*"]
    Local $nb1 = Random(1, 10, 1)
    Local $nb2 = Random(1, 10, 1)
    Local $operateur = $operateurs[Random(0, 2, 1)]

    Local $question = $nb1 & " " & $operateur & " " & $nb2
    Local $resultat

    Switch $operateur
        Case "+"
            $resultat = $nb1 + $nb2
        Case "-"
            $resultat = $nb1 - $nb2
        Case "*"
            $resultat = $nb1 * $nb2
    EndSwitch

    Local $calcul[2] = [$question, $resultat]
    Return $calcul
EndFunc

Local $form = GUICreate("Calcul Mental", 300, 150)
Local $lbl_question = GUICtrlCreateLabel("", 10, 10, 280, 30)
Local $input_reponse = GUICtrlCreateInput("", 10, 50, 280, 30)
Local $btn_valider = GUICtrlCreateButton("Valider", 100, 100, 100, 30)

GUISetState(@SW_SHOW)

Local $calcul = GenererCalcul()
GUICtrlSetData($lbl_question, "Résolvez : " & $calcul[0])
Local $resultat_attendu = $calcul[1]

While 1
    Local $msg = GUIGetMsg()
    If $msg = $GUI_EVENT_CLOSE Then ExitLoop

    If $msg = $btn_valider Then
        Local $reponse = GUICtrlRead($input_reponse)
        If Number($reponse) = $resultat_attendu Then
            MsgBox($MB_ICONINFORMATION, "Bravo", "Bonne réponse !")
        Else
            MsgBox($MB_ICONERROR, "Erreur", "Mauvaise réponse, le résultat était : " & $resultat_attendu)
        EndIf

        $calcul = GenererCalcul()
        GUICtrlSetData($lbl_question, "Résolvez : " & $calcul[0])
        $resultat_attendu = $calcul[1]
        GUICtrlSetData($input_reponse, "")
    EndIf
WEnd

GUIDelete($form)