#InstallKeybdHook

#include %A_ScriptDir%\lib\IME.ahk
#include %A_ScriptDir%\AppUtils.ahk
#include %A_ScriptDir%\ModeController.ahk
#include %A_ScriptDir%\MouseGesture.ahk
#include %A_ScriptDir%\MouseUtils.ahk
#include %A_ScriptDir%\Command.ahk

;入力モードで割り込みを禁止する
SendMode Play

SetWinDelay, 10
SetMouseDelay, 10

#include %A_ScriptDir%\keybindings\Alphabets.ahk
#include %A_ScriptDir%\keybindings\Numbers.ahk
#include %A_ScriptDir%\keybindings\Symbols.ahk
#include %A_ScriptDir%\keybindings\Others.ahk

