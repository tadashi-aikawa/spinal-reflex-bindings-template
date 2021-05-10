; 変数名解決時に環境変数を見ない (パフォーマンス改善による押しっぱなし対策)
#NoEnv
; キーボードフックを使用する (押しっぱなし防止対策)
#InstallKeybdHook

#include %A_ScriptDir%\lib\IME.ahk
#include %A_ScriptDir%\AppUtils.ahk
#include %A_ScriptDir%\ModeController.ahk
#include %A_ScriptDir%\MouseGesture.ahk
#include %A_ScriptDir%\MouseUtils.ahk
#include %A_ScriptDir%\Command.ahk

; 入力モードで割り込みを禁止する (押しっぱなし防止対策)
SendMode Play
; 10msのコマンド間スリープを0にする (パフォーマンス改善による押しっぱなし対策)
SetBatchLines, -1
BlockInput, Send
SetWinDelay, 10
SetMouseDelay, 10

#include %A_ScriptDir%\keybindings\Alphabets.ahk
#include %A_ScriptDir%\keybindings\Numbers.ahk
#include %A_ScriptDir%\keybindings\Symbols.ahk
#include %A_ScriptDir%\keybindings\Others.ahk

