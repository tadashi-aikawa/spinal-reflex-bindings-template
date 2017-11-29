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

;******************************************************************
; 特殊キー
;******************************************************************

;----- モード切替 -----
; 無変換キー
$vk1C::
    if (mode(_MODE.NORMAL)) {
        ;ここでsetIME(false)にしないのは 変換中のカーソル操作ができなくなってしまうため
        setMode(_MODE.EDIT)
    } else {
        setMode(_MODE.NORMAL)
        setIME(false)
    }
    return

;----- マウスカーソル配下のウィンドウをアクティブにする -----
$Ctrl::
    MouseGetPos, , , hWindow
    WinActivate, ahk_id %hWindow%
    return


;******************************************************************
; 数字キー
;******************************************************************

;[NORMAL ]: 1キー
;[EDIT   ]: URLをエクスプローラーまたはブラウザで開く
;[RANGE  ]: URLをエクスプローラーまたはブラウザで開く
;[MOUSE  ]: URLをエクスプローラーまたはブラウザで開く
;[SPECIAL]: URLをエクスプローラーまたはブラウザで開く
$1::
    if (!mode(_MODE.NORMAL)) {
        openUri()
    } else {
        send 1
    }
    return


;[NORMAL ]: F2キー
;[EDIT   ]: F2キー
;[RANGE  ]: F2キー
;[MOUSE  ]: F2キー
;[SPECIAL]: F2キー
$^2::
    send {f2}
    return


;[NORMAL ]: 3キー
;[EDIT   ]: ウィンドウ切り替え(Win + Tab)
;[RANGE  ]: ウィンドウ切り替え(Win + Tab)
;[MOUSE  ]: ウィンドウ切り替え(Win + Tab)
;[SPECIAL]: ウィンドウ切り替え(Win + Tab)
$3::
    if (!mode(_MODE.NORMAL)) {
        send #{tab}
    } else {
        send 3
    }
    return


;[NORMAL ]: F3キー
;[EDIT   ]: F3キー
;[RANGE  ]: F3キー
;[MOUSE  ]: F3キー
;[SPECIAL]: F3キー
$^3::
    send {F3}
    return


;[NORMAL ]: { (中カッコ開始）
;[EDIT   ]: { (中カッコ開始）
;[RANGE  ]: { (中カッコ開始）
;[MOUSE  ]: { (中カッコ開始）
;[SPECIAL]: { (中カッコ開始）
$^8::
    send {{}
    return


;[NORMAL ]: } (中カッコ終了）
;[EDIT   ]: } (中カッコ終了）
;[RANGE  ]: } (中カッコ終了）
;[MOUSE  ]: } (中カッコ終了）
;[SPECIAL]: } (中カッコ終了）
$^9::
    send {}}
    return


;******************************************************************
; 記号キー
;******************************************************************

;[NORMAL ]: ;キー
;[EDIT   ]: 行末へ移動
;[RANGE  ]: 行末に選択範囲を移動
;[MOUSE  ]: ポインタを１画面分左に移動
;[SPECIAL]: - (ハイフン)
$;::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send {end}
        } else if (mode(_MODE.RANGE)) {
            send +{end}
        } else if (mode(_MODE.MOUSE)) {
            moveMouseRightScreen()
        } else if (mode(_MODE.SPECIAL)) {
            send -
        }
    } else {
        send `;
    }
    return


;[NORMAL ]: Shift + ;キー
;[EDIT   ]: 15つ右に移動
;[RANGE  ]: 選択範囲を15つ右に移動
;[MOUSE  ]: Shift + ;キー
;[SPECIAL]: Shift + ;キー
$+;::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            sendInput {right 15}
        } else if (mode(_MODE.RANGE)) {
            sendInput +{right 15}
        } else if (mode(_MODE.MOUSE)) {
            send +`;
        } else if (mode(_MODE.SPECIAL)) {
            send +`;
        }
    } else {
        send +`;
    }
    return


;[NORMAL ]: 本日の日付を入力(YYYY/MM/DD)
;[EDIT   ]: 行末へ移動
;[RANGE  ]: 行末へ移動
;[MOUSE  ]: 行末へ移動
;[SPECIAL]: 行末へ移動
$^;::
    if (mode(_MODE.NORMAL)) {
        if (isActive("excel") || isActive("powerpoint-full")) {
            send ^;
        } else {
            Clipboard = %A_Year%/%A_Mon%/%A_MDay%
            Send, ^v
        }
    } else {
        ; Copy => 行末移動の操作でCtrlのupが間に合わず予期せぬ挙動になるのを防ぐため
        send {end}
    }
    return


;[NORMAL ]: 本日の日付を入力(YYYYMMDD)
;[EDIT   ]: 本日の日付を入力(YYYYMMDD)
;[RANGE  ]: 本日の日付を入力(YYYYMMDD)
;[MOUSE  ]: 本日の日付を入力(YYYYMMDD)
;[SPECIAL]: 本日の日付を入力(YYYYMMDD)
$^+;::
    if(isActive("excel")) {
        send ^+;
    } else {
        Clipboard = %A_Year%%A_Mon%%A_MDay%
        Send, ^v
    }
    return


;[NORMAL ]: @キ
;[EDIT   ]: Ctrl + Shift + aキー => NORMALモード
;[RANGE  ]: @キー
;[MOUSE  ]: @キー
;[SPECIAL]: @キー
;[SNIPPET]: GitHub形式のコードブロック
$@::
    if (mode(_MODE.EDIT)) {
        send ^+a
        setMode(_MODE.NORMAL)
    } else if (mode(_MODE.SNIPPET)) {
        send ``````{ENTER}{ENTER}``````{UP}
        setMode(_MODE.NORMAL)
    } else {
        send @
    }
    return


;[NORMAL ]: 現在の時刻を入力(hh:mm:ss)
;[EDIT   ]: 現在の時刻を入力(hh:mm:ss)
;[RANGE  ]: 現在の時刻を入力(hh:mm:ss)
;[MOUSE  ]: 現在の時刻を入力(hh:mm:ss)
;[SPECIAL]: 現在の時刻を入力(hh:mm:ss)
;※ Ctrl + :
$^vkBAsc028::
    Clipboard = %A_Hour%:%A_Min%:%A_Sec%
    Send, ^v
    return


;[NORMAL ]: 現在の時刻を入力(hhmmss)
;[EDIT   ]: 現在の時刻を入力(hhmmss)
;[RANGE  ]: 現在の時刻を入力(hhmmss)
;[MOUSE  ]: 現在の時刻を入力(hhmmss)
;[SPECIAL]: 現在の時刻を入力(hhmmss)
;※ Ctrl + Shift + :
$^+vkBAsc028::
    Clipboard = %A_Hour%%A_Min%%A_Sec%
    Send, ^v
    return


;[NORMAL ]: :キー
;[EDIT   ]: 日本語入力ON + モードをNORMALに変更
;[RANGE  ]: 日本語入力ON + モードをNORMALに変更
;[MOUSE  ]: 日本語入力ON + モードをNORMALに変更
;[SPECIAL]: 日本語入力ON + モードをNORMALに変更
;※ :
$vkBAsc028::
    if (!mode(_MODE.NORMAL)) {
        setIME(true)
        setMode(_MODE.NORMAL)
    } else {
        send :
    }
    return


;[NORMAL ]: .キー
;[EDIT   ]: =キー
;[RANGE  ]: =キー
;[MOUSE  ]: コンビネーションの1キー目
;[SPECIAL]: 3キー
$.::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send `=
            setMode(_MODE.NORMAL)
        } else if (mode(_MODE.RANGE)) {
            send `=
            setMode(_MODE.NORMAL)
        } else if (mode(_MODE.MOUSE)) {
            ; DO NOTHING
        } else if (mode(_MODE.SPECIAL)) {
            if (isActive("mintty") || isActive("ubuntu")) {
                send 3
            } else {
                send {Numpad3}
            }
        }
    } else {
        send .
    }
    return


;[NORMAL ]: 右クリックメニュー
;[EDIT   ]: 右クリックメニュー
;[RANGE  ]: 右クリックメニュー
;[MOUSE  ]: 右クリックメニュー
;[SPECIAL]: 右クリックメニュー
$^.::
    send {appsKey}
    return


;[NORMAL ]: shift + .キー
;[EDIT   ]: スペースキー × 10
;[RANGE  ]: shift + .キー
;[MOUSE  ]: shift + .キー
;[SPECIAL]: shift + .キー
$+.::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send {space 10}
        } else if (mode(_MODE.RANGE)) {
            send +.
        } else if (mode(_MODE.MOUSE)) {
            send +.
        } else if (mode(_MODE.SPECIAL)) {
            send +.
        }
    } else {
        send +.
    }
    return


;[NORMAL ]: ,キー
;[EDIT   ]: DEBUGモードに変更
;[RANGE  ]: DEBUGモードに変更
;[MOUSE  ]: DEBUGモードに変更
;[SPECIAL]: 2キー
;[SNIPPET]: DEBUGモードに変更
;[DEBUG  ]: EDITモードに変更
$,::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            setMode(_MODE.DEBUG)
        } else if (mode(_MODE.RANGE)) {
            setMode(_MODE.DEBUG)
        } else if (mode(_MODE.MOUSE)) {
            setMode(_MODE.DEBUG)
        } else if (mode(_MODE.SPECIAL)) {
            if (isActive("mintty") || isActive("ubuntu")) {
                send 2
            } else {
                send {Numpad2}
            }
        } else if (mode(_MODE.SPECIAL)) {
            setMode(_MODE.EDIT)
        }
    } else {
        send `,
    }
    return


;[NORMAL ]: Ctrl + , キー
;[EDIT   ]: Ctrl + , キー
;[RANGE  ]: Ctrl + , キー
;[MOUSE  ]: Ctrl + , キー
;[SPECIAL]: 2キー
$^,::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send ^,
        } else if (mode(_MODE.RANGE)) {
            send ^,
        } else if (mode(_MODE.MOUSE)) {
            send ^,
        } else if (mode(_MODE.SPECIAL)) {
            send {Numpad2}{Enter}
        }
    } else {
        send ^,
    }
    return


;[NORMAL ]: shift + ,キー
;[EDIT   ]: スペースキー × 5
;[RANGE  ]: shift + ,キー
;[MOUSE  ]: shift + ,キー
;[SPECIAL]: shift + ,キー
$+,::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send {space 5}
        } else if (mode(_MODE.RANGE)) {
            send +,
        } else if (mode(_MODE.MOUSE)) {
            send +,
        } else if (mode(_MODE.SPECIAL)) {
            send +,
        }
    } else {
        send +,
    }
    return


;******************************************************************
; 特殊キー
;******************************************************************

;[NORMAL ]: Enterキー
;[EDIT   ]: Enterキー
;[RANGE  ]: Enterキー
;[MOUSE  ]: 左クリック
;[SPECIAL]: 0キー
$Enter::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.MOUSE)) {
            MouseGetPos nowX, nowY
            Click nowX, nowY
        } else if (mode(_MODE.SPECIAL)) {
            if (isActive("mintty") || isActive("ubuntu")) {
                send 0
            } else {
                send {Numpad0}
            }
        } else {
            send {Enter}
        }
    } else {
        send {Enter}
    }
    return


;[NORMAL ]: Ctrl+Enterキー
;[EDIT   ]: Ctrl+Enterキー
;[RANGE  ]: Ctrl+Enterキー
;[MOUSE  ]: Ctrl+左クリック
;[SPECIAL]: Enterキー
$^Enter::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.MOUSE)) {
            MouseGetPos nowX, nowY
            send ^{Click nowX, nowY}
        } else if (mode(_MODE.SPECIAL)) {
            if (isActive("mintty") || isActive("ubuntu")) {
                send 0
            } else {
                send {Numpad0}
            }
            send {Enter}
        } else {
            send ^{Enter}
        }
    } else {
        send ^{Enter}
    }
    return


;[NORMAL ]: Shift+Enterキー
;[EDIT   ]: Shift+Enterキー
;[RANGE  ]: Shift+Enterキー
;[MOUSE  ]: Shift+左クリック
;[SPECIAL]: Enterキー
$+Enter::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.MOUSE)) {
            MouseGetPos nowX, nowY
            send +{Click nowX, nowY}
        } else if (mode(_MODE.SPECIAL)) {
            send {Enter}
        } else {
            send +{Enter}
        }
    } else {
        send +{Enter}
    }
    return


;[NORMAL ]: TABキー
;[EDIT   ]: TABキー
;[RANGE  ]: TABキー + モードをNORMALに変更
;[MOUSE  ]: TABキー
;[SPECIAL]: TABキー
$TAB::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.RANGE)) {
            setMode(_MODE.EDIT)
        }
        send {TAB}
    } else {
        send {TAB}
    }
    return


;[NORMAL ]: /キー
;[EDIT   ]: Win + Tab
;[RANGE  ]: /キー
;[MOUSE  ]: /キー
;[SPECIAL]: .キー
$/::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send #{TAB}
        } else if (mode(_MODE.SPECIAL)) {
            if (isActive("mintty") || isActive("ubuntu")) {
                send .
            } else {
                send {NumpadDot}
            }
        } else {
            send /
        }
    } else {
        send /
    }
    return

;[NORMAL ]: BS
;[EDIT   ]: BS
;[RANGE  ]: BS
;[MOUSE  ]: BS
;[SPECIAL]: BS
$PgUp::
    send {BS}
    return

;[NORMAL ]: Enter
;[EDIT   ]: Enter
;[RANGE  ]: Enter
;[MOUSE  ]: Enter
;[SPECIAL]: Enter
$PgDn::
    send {Enter}
    return


;******************************************************************
; アルファベット（50音順)
;******************************************************************

;[NORMAL ]: aキー(;からのコンビネーションの場合は()を入力して、フォーカスを()内に移動させる）
;[EDIT   ]: 行頭へ移動
;[RANGE  ]: 行頭に選択範囲を移動
;[MOUSE  ]: ポインタを１画面分左に移動
;[SPECIAL]: アクティブウィンドウを左下に最大化して移動する
$a::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send {home}
        } else if (mode(_MODE.RANGE)) {
            send +{home}
        } else if (mode(_MODE.MOUSE)) {
            if (isConbinationKey("$;")) {
                moveMousePointerScreen("LeftDown")
            } else {
                moveMouseLeftScreen()
            }
        } else if (mode(_MODE.SPECIAL)) {
            MoveWindow("LeftDown")
        }
    } else {
        if (isConbinationKey("$;")) {
            send {BS}
            sendMultiByte("(")
            sendMultiByte(")")
            send {left}
            setMode(_MODE.NORMAL)
        } else {
            send a
        }
    }
    return


;[NORMAL ]: アクティブウィンドウを常時最前面表示にする
;[EDIT   ]: アクティブウィンドウを常時最前面表示にする
;[RANGE  ]: アクティブウィンドウを常時最前面表示にする
;[MOUSE  ]: アクティブウィンドウを常時最前面表示にする
;[SPECIAL]: アクティブウィンドウを常時最前面表示にする
$#a::
    WinSet, Topmost, Toggle, A
    return


;[NORMAL ]: SNIPPETモードに変更
;[EDIT   ]: SNIPPETモードに変更
;[RANGE  ]: SNIPPETモードに変更
;[MOUSE  ]: SNIPPETモードに変更
;[SPECIAL]: SNIPPETモードに変更
;[SNIPPET]: EDITモードに変更
$b::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.SNIPPET)) {
            setMode(_MODE.EDIT)
        } else {
            setMode(_MODE.SNIPPET)
        }
    } else {
        send b
    }
    return


;[NORMAL ]: cキー (;からのコンビネーションの場合はコードブロック)
;[EDIT   ]: コピーしてモードをVirtual->NORMALに変更
;[RANGE  ]: コピーしてモードをVirtual->NORMALに変更
;[MOUSE  ]: ポインタを画面中央下に移動 (cからのコンビネーションの場合は ポインタを画面中央下隅に移動）
;[SPECIAL]: コピーしてモードをVirtual->NORMALに変更
;[SNIPPET]: :calendar:
$c::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.MOUSE)) {
            if (isConbinationKey("$c")) {
                moveMousePointerEdge(2, 3)
            } else {
                moveMousePointer(2, 3)
            }
        } else if (mode(_MODE.SNIPPET)) {
            send :calendar:
        } else {
            setMode(_MODE.EDIT)
            if (isActive("mintty") || isActive("ubuntu")) {
                send ^{Ins}
            } else {
                send ^c
            }
        }
    } else {
        if (isConbinationKey("$;")) {
            send {BS}{`` 6}{left 3}
        } else {
            send c
        }
    }
    return


;[NORMAL ]: dキー (dからのコンビネーションの場合は 【】を入力してカーソルを間に移動)
;[EDIT   ]: BSキー
;[RANGE  ]: BSキー
;[MOUSE  ]: ポインタを画面中央に移動
;[SPECIAL]: アクティブウィンドウを右下に最大化して移動する
$d::
    if (mode(_MODE.NORMAL)) {
        if (isConbinationKey("$;")) {
            send, {BS}
            sendMultiByte("【")
            sendMultiByte("】")
            send {left}
            setMode(_MODE.NORMAL)
        } else {
            send d
        }
    } else if (mode(_MODE.EDIT)) {
        send {BS}
    } else if (mode(_MODE.RANGE)) {
        send {BS}
    } else if (mode(_MODE.MOUSE)) {
        if (isConbinationKey("$d")) {
            moveMousePointerEdge(2, 2)
        } else if (isConbinationKey("$;")) {
            moveMousePointerScreen("RightDown")
        } else {
            moveMousePointer(2, 2)
        }
    } else if (mode(_MODE.SPECIAL)) {
        MoveWindow("RightDown")
    }
    return


;[NORMAL ]: Shift + dキー
;[EDIT   ]: Enter
;[RANGE  ]: Enter
;[MOUSE  ]: Enter
;[SPECIAL]: Enter
$+d::
    if (mode(_MODE.NORMAL)) {
        send +d
    } else if (mode(_MODE.EDIT)) {
        send {Enter}
    } else if (mode(_MODE.RANGE)) {
        send {Enter}
    } else if (mode(_MODE.MOUSE)) {
        send {Enter}
    } else if (mode(_MODE.SPECIAL)) {
        send {Enter}
    }
    return


;[NORMAL ]: eキー(;からのコンビネーションの場合は = を入力する）
;[EDIT   ]: 1つ戻る（visio: 前のシートへ移動)
;[RANGE  ]: 1つ戻る（visio: 前のシートへ移動)
;[MOUSE  ]: ポインタを画面中央上に移動 (eからのコンビネーションの場合は ポインタを画面中央上隅に移動）
;[SPECIAL]: アクティブウィンドウを右上に最大化して移動する
;[SNIPPET]: :evergreen_tree::
;[DEBUG  ]: 評価を開く
$e::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.SPECIAL)) {
            MoveWindow("RightUp")
        } else if (mode(_MODE.MOUSE)) {
            if (isConbinationKey("$e")) {
                moveMousePointerEdge(2, 1)
            } else if (isConbinationKey("$;")) {
                moveMousePointerScreen("RightUp")
            } else {
                moveMousePointer(2, 1)
            }
        } else if (mode(_MODE.SNIPPET)) {
            send :evergreen_tree:
        } else if (mode(_MODE.DEBUG)) {
            send ^u
        } else {
            send !{left}
        }
    } else {
        if (isConbinationKeyAndIMEOn("$;")) {
            send {BS}{space}={space}
        } else {
            send e
        }
    }
    return


;[NORMAL ]: Ctrl + eキー
;[EDIT   ]: 1つ進む
;[RANGE  ]: 1つ進む
;[MOUSE  ]: 1つ進む
;[SPECIAL]: 1つ進む
$^e::
    if (!mode(_MODE.NORMAL)) {
        send !{right}
    } else {
        send ^e
    }
    return


;[NORMAL ]: Shift + eキー
;[EDIT   ]: Shift + eキー（eclipse: 最後の編集場所へ移動)
;[RANGE  ]: Shift + eキー（eclipse: 最後の編集場所へ移動)
;[MOUSE  ]: Shift + eキー（eclipse: 最後の編集場所へ移動)
;[SPECIAL]: Shift + eキー（eclipse: 最後の編集場所へ移動)
$+e::
    if (isActive("eclipse")) {
        if (!mode(_MODE.NORMAL)) {
            send ^{q}
        } else {
            send +{e}
        }
    } else {
        send +{e}
    }
    return


;[NORMAL ]: fキー(;からのコンビネーションの場合は#）
;[EDIT   ]: ページの末尾に移動
;[RANGE  ]: 選択範囲をページの末尾に移動
;[MOUSE  ]: ポインタを画面中央右に移動 (fからのコンビネーションの場合は ポインタを画面中央右隅に移動）
;[SPECIAL]: 縦にフルスクリーン
$f::
    if (mode(_MODE.NORMAL)) {
        if (isConbinationKey("$`;")) {
            send {BS}{#}
        } else {
            send f
        }
    } else if (mode(_MODE.EDIT)) {
        send ^{End}
    } else if (mode(_MODE.RANGE)) {
        send ^+{End}
    } else if (mode(_MODE.MOUSE)) {
        if (isConbinationKey("$f")) {
            moveMousePointerEdge(3, 2)
        } else {
            moveMousePointer(3, 2)
        }
    } else if (mode(_MODE.SPECIAL)) {
        send #+{UP}
    }
    return


;[NORMAL ]: 検索
;[EDIT   ]: 検索
;[RANGE  ]: 検索
;[MOUSE  ]: 検索
;[SPECIAL]: 検索
$^f::
    if (isActive("console")) {
        send !{space}ef
    } else if (isActive("mintty")) {
        send !{F3}
    } else {
        send ^f
    }
    return


;[NORMAL ]: Shift + fキー
;[EDIT   ]: Enterキー
;[RANGE  ]: Enterキー
;[MOUSE  ]: Shift + fキー
;[SPECIAL]: Shift + fキー
$+f::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send {Enter}
        } else if (mode(_MODE.RANGE)) {
            send {Enter}
        } else if (mode(_MODE.MOUSE)) {
            send +f
        } else if (mode(_MODE.SPECIAL)) {
            send +f
        }
    } else {
        send +f
    }
    return


;[NORMAL ]: gキー(;からのコンビネーションの場合は$）
;[EDIT   ]: RANGEモードに切り替え (tmuxの場合はコピーモード)
;[RANGE  ]: EDITモードに切り替え
;[MOUSE  ]: RANGEモードに切り替え (tmuxの場合はコピーモード)
;[SPECIAL]: RANGEモードに切り替え (tmuxの場合はコピーモード)
;[SNIPPET]: :globe_with_meridians: 
$g::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.RANGE)) {
            setMode(_MODE.EDIT)
        } else if (mode(_MODE.SNIPPET)) {
            send :globe_with_meridians: 
        } else {
            if (isActive("mintty") || isActive("ubuntu")) {
                send ^b[
            } else {
                setMode(_MODE.RANGE)
            }
        }
    } else {
        if (isConbinationKey("$`;")) {
            send {BS}{$}
        } else {
            send g
        }
    }
    return


;[NORMAL ]: h (;からのコンビネーションの場合は~)
;[EDIT   ]: MOUSEモードに切り替え
;[RANGE  ]: MOUSEモードに切り替え
;[MOUSE  ]: EDITモードに切り替え
;[SPECIAL]: MOUSEモードに切り替え
$h::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.MOUSE)) {
            setMode(_MODE.EDIT)
        } else {
            setMode(_MODE.MOUSE)
        }
    } else {
        if (isConbinationKeyAndIMEOn("$;")) {
            send {BS}~
        } else {
            send h
        }
    }
    return


;[NORMAL ]: Ctrl + H
;[EDIT   ]: 15つ上に移動
;[RANGE  ]: 選択範囲を15つ上に移動
;[MOUSE  ]: Ctrl + H
;[SPECIAL]: Ctrl + H
$^h::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            sendInput {up 15}
        } else if (mode(_MODE.RANGE)) {
            sendInput +{up 15}
        } else if (mode(_MODE.MOUSE)) {
            send ^h
        } else if (mode(_MODE.SPECIAL)) {
            send ^h
        }
    } else {
        send ^h
    }
    return


;[NORMAL ]: Shift + hキー
;[EDIT   ]: 15つ左に移動
;[RANGE  ]: 選択範囲を15つ左に移動
;[MOUSE  ]: Shift + hキー
;[SPECIAL]: Shift + hキー
$+h::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            sendInput {left 15}
        } else if (mode(_MODE.RANGE)) {
            sendInput +{left 15}
        } else if (mode(_MODE.MOUSE)) {
            send +h
        } else if (mode(_MODE.SPECIAL)) {
            send +h
        }
    } else {
        send +h
    }
    return


;[NORMAL ]: iキー (;からのコンビネーションの場合は「{}」を入力）
;[EDIT   ]: 上に移動
;[RANGE  ]: 選択範囲を上に移動
;[MOUSE  ]: マウスポインタを上に微かに移動
;[SPECIAL]: 8キー
$i::
    if (mode(_MODE.NORMAL)) {
        if (isConbinationKeyAndIMEOn("$;")) {
            send {BS}
            sendMultiByte("{{}{}}")
            send {Left}
        } else {
            send i
        }
    } else if (mode(_MODE.EDIT)) {
        send {up}
    } else if (mode(_MODE.RANGE)) {
        send +{up}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseUpMicro()
    } else if (mode(_MODE.SPECIAL)) {
            if (isActive("mintty") || isActive("ubuntu")) {
                send 8
            } else {
                send {Numpad8}
            }
    }
    return


;[NORMAL ]: iキー
;[EDIT   ]: 上に5つ移動
;[RANGE  ]: 選択範囲を上に5つ移動
;[MOUSE  ]: マウスポインタを上に移動
;[SPECIAL]: 8キー + Enter
$^i::
    if (mode(_MODE.NORMAL)) {
        Send ^i
    } else if (mode(_MODE.EDIT)) {
        sendInput {up 5}
    } else if (mode(_MODE.RANGE)) {
        sendInput +{up 5}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseUpMiddle()
    } else if (mode(_MODE.SPECIAL)) {
        send {Numpad8}{Enter}
    }
    return


;[NORMAL ]: shift + iキー
;[EDIT   ]: 上に1ページ移動
;[RANGE  ]: 上に1ページ選択範囲を移動
;[MOUSE  ]: マウスポインタを上に大きく移動
;[SPECIAL]: ↑キー
$+i::
    if (mode(_MODE.NORMAL)) {
        Send +i
    } else if (mode(_MODE.EDIT)) {
        send {PgUp}
    } else if (mode(_MODE.RANGE)) {
        send +{PgUp}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseUpLarge()
    } else if (mode(_MODE.SPECIAL)) {
        Send ↑
    }
    return


;[NORMAL ]: Alt + iキー
;[EDIT   ]: Alt + 上キー
;[RANGE  ]: Alt + 上キー
;[MOUSE  ]: マウスポインタを上に少し移動
;[SPECIAL]: Alt + iキー
$!i::
    if (mode(_MODE.NORMAL)) {
        Send !i
    } else if (mode(_MODE.EDIT)) {
        send !{up}
    } else if (mode(_MODE.RANGE)) {
        send !{up}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseUpSmall()
    } else if (mode(_MODE.SPECIAL)) {
        Send !i
    }
    return


;[NORMAL ]: jキー (;からのコンビネーションの場合は''を入力して、フォーカスを''内に移動させる）
;[EDIT   ]: 左に移動
;[RANGE  ]: 選択範囲を左に移動
;[MOUSE  ]: マウスポインタを左に微かに移動
;[SPECIAL]: 4キー
;[DEBUG  ]: ステップアウト (SHIFT + F11)
$j::
    if (mode(_MODE.NORMAL)) {
        if (isConbinationKeyAndIMEOn("$;")) {
            send {BS}{' 2}{left}
        } else {
            send j
        }
    } else if (mode(_MODE.EDIT)) {
        send {left}
    } else if (mode(_MODE.RANGE)) {
        send +{left}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseLeftMicro()
    } else if (mode(_MODE.SPECIAL)) {
            if (isActive("mintty") || isActive("ubuntu")) {
                send 4
            } else {
                send {Numpad4}
            }
    } else if (mode(_MODE.DEBUG)) {
        send +{F11}
    }
    return


;[NORMAL ]: Ctrl + jキー
;[EDIT   ]: 左に1単語移動
;[RANGE  ]: 選択範囲を左に1単語移動
;[MOUSE  ]: マウスポインタを左に移動
;[SPECIAL]: 4キー + Enter
$^j::
    if (mode(_MODE.NORMAL)) {
        send ^j
    } else if (mode(_MODE.EDIT)) {
        if (isActive("poderose")) {
            send {ESC}b
        } else {
            send ^{left}
        }
    } else if (mode(_MODE.RANGE)) {
        send +^{left}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseLeftMiddle()
    } else if (mode(_MODE.SPECIAL)) {
        send {Numpad4}{Enter}
    }
    return


;[NORMAL ]: Shift + jキー
;[EDIT   ]: 左に5つ移動
;[RANGE  ]: 選択範囲を左に5つ移動
;[MOUSE  ]: マウスポインタを左に大きく移動
;[SPECIAL]: 左キー
$+j::
    if (mode(_MODE.NORMAL)) {
        send +j
    } else if (mode(_MODE.EDIT)) {
        sendInput {Left 5}
    } else if (mode(_MODE.RANGE)) {
        sendInput +{Left 5}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseLeftLarge()
    } else if (mode(_MODE.SPECIAL)) {
        send ←
    }
    return


;[NORMAL ]: Alt + jキー
;[EDIT   ]: Alt + jキー
;[RANGE  ]: Alt + jキー
;[MOUSE  ]: マウスポインタを左に少し移動
;[SPECIAL]: Alt + jキー
$!j::
    if (mode(_MODE.NORMAL)) {
        send !j
    } else if (mode(_MODE.EDIT)) {
        send !j
    } else if (mode(_MODE.RANGE)) {
        send !j
    } else if (mode(_MODE.MOUSE)) {
        moveMouseLeftSmall()
    } else if (mode(_MODE.SPECIAL)) {
        send !j
    }
    return


;[NORMAL ]: kキー (;からのコンビネーションの場合は``)
;[EDIT   ]: 下に移動
;[RANGE  ]: 下に選択範囲を移動
;[MOUSE  ]: マウスポインタを下に微かに移動
;[SPECIAL]: 5キー
;[DEBUG  ]: ステップオーバー (F10)
$k::
    if (mode(_MODE.NORMAL)) {
        if (isConbinationKey("$;")) {
            send {BS}``{left}``
        } else {
            send k
        }
    } else if (mode(_MODE.EDIT)) {
        send {down}
    } else if (mode(_MODE.RANGE)) {
        send +{down}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseDownMicro()
    } else if (mode(_MODE.SPECIAL)) {
            if (isActive("mintty") || isActive("ubuntu")) {
                send 5
            } else {
                send {Numpad5}
            }
    } else if (mode(_MODE.DEBUG)) {
        send {F10}
    }
    return


;[NORMAL ]: Ctrl + kキー
;[EDIT   ]: 下に5つ移動
;[RANGE  ]: 選択範囲を下に5つ移動
;[MOUSE  ]: マウスポインタを下に移動
;[SPECIAL]: 5キー + Enter
$^k::
    if (mode(_MODE.NORMAL)) {
        send ^k
    } else if (mode(_MODE.EDIT)) {
        sendInput {down 5}
    } else if (mode(_MODE.RANGE)) {
        sendInput +{down 5}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseDownMiddle()
    } else if (mode(_MODE.SPECIAL)) {
        send {Numpad5}{Enter}
    }
    return


;[NORMAL ]: Shift + kキー
;[EDIT   ]: 下に1ページ移動
;[RANGE  ]: 選択範囲を下に1ページ移動
;[MOUSE  ]: マウスポインタを下に大きく移動
;[SPECIAL]: ↓キー
$+k::
    if (mode(_MODE.NORMAL)) {
        send +k
    } else if (mode(_MODE.EDIT)) {
        send {PgDn}
    } else if (mode(_MODE.RANGE)) {
        send +{PgDn}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseDownLarge()
    } else if (mode(_MODE.SPECIAL)) {
        send ↓
    }
    return


;[NORMAL ]: Alt + kキー
;[EDIT   ]: Alt + 下キー
;[RANGE  ]: Alt + 下キー
;[MOUSE  ]: マウスポインタを下に少し移動
;[SPECIAL]: Alt + kキー
$!k::
    if (mode(_MODE.NORMAL)) {
        send !k
    } else if (mode(_MODE.EDIT)) {
        send !{down}
    } else if (mode(_MODE.RANGE)) {
        send !{down}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseDownSmall()
    } else if (mode(_MODE.SPECIAL)) {
        send !k
    }
    return


;[NORMAL ]: lキー (;からのコンビネーションの場合は、_キー）
;[EDIT   ]: 右に移動
;[RANGE  ]: 選択範囲を右に移動
;[MOUSE  ]: マウスポインタを右に微かに移動
;[SPECIAL]: 6キー
;[SNIPPET]: :fork_and_knife:
;[DEBUG  ]: ステップイン (F11)
$l::
    if (mode(_MODE.NORMAL)) {
        if (isConbinationKeyAndIMEOn("$;")) {
            send {BS}_
        } else {
            send l
        }
    } else if (mode(_MODE.EDIT)) {
        send {right}
    } else if (mode(_MODE.RANGE)) {
        send +{right}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseRightMicro()
    } else if (mode(_MODE.SPECIAL)) {
        if (isActive("mintty") || isActive("ubuntu")) {
            send 6
        } else {
            send {Numpad6}
        }
    } else if (mode(_MODE.SNIPPET)) {
        send :fork_and_knife:
    } else if (mode(_MODE.DEBUG)) {
        send {F11}
    }
    return


;[NORMAL ]: lキー
;[EDIT   ]: 右に1単語移動
;[RANGE  ]: 選択範囲を右に1単語移動
;[MOUSE  ]: マウスポインタを右に移動
;[SPECIAL]: 6キー + Enter
$^l::
    if (mode(_MODE.NORMAL)) {
        send ^l
    } else if (mode(_MODE.EDIT)) {
        if (isActive("poderosa")) {
            send {ESC}f
        } else {
            send ^{right}
        }
    } else if (mode(_MODE.RANGE)) {
        send +^{right}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseRightMiddle()
    } else if (mode(_MODE.SPECIAL)) {
        send {Numpad6}{Enter}
    }
    return


;[NORMAL ]: Shift + lキー
;[EDIT   ]: 右に5つ移動
;[RANGE  ]: 選択範囲を右に5つ移動
;[MOUSE  ]: マウスポインタを右に大きく移動
;[SPECIAL]: →キー
$+l::
    if (mode(_MODE.NORMAL)) {
        send +l
    } else if (mode(_MODE.EDIT)) {
        sendInput {Right 5}
    } else if (mode(_MODE.RANGE)) {
        sendInput +{Right 5}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseRightLarge()
    } else if (mode(_MODE.SPECIAL)) {
        send →
    }
    return


;[NORMAL ]: Alt + lキー
;[EDIT   ]: Alt + lキー
;[RANGE  ]: Alt + lキー
;[MOUSE  ]: マウスポインタ右に少し移動
;[SPECIAL]: Alt + lキー
$!l::
    if (mode(_MODE.NORMAL)) {
        send !l
    } else if (mode(_MODE.EDIT)) {
        send !l
    } else if (mode(_MODE.RANGE)) {
        send !l
    } else if (mode(_MODE.MOUSE)) {
        moveMouseRightSmall()
    } else if (mode(_MODE.SPECIAL)) {
        send !l
    }
    return


;[NORMAL ]: mキー
;[EDIT   ]: 日本語入力OFF + モードをNORMALに変更
;[RANGE  ]: 日本語入力OFF + モードをNORMALに変更
;[MOUSE  ]: 左ドラッグ
;[SPECIAL]: 1キー
;[SNIPPET]: :fork_and_knife:
$m::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            setIME(false)
            setMode(_MODE.NORMAL)
        } else if (mode(_MODE.RANGE)) {
            setIME(false)
            setMode(_MODE.NORMAL)
        } else if (mode(_MODE.MOUSE)) {
            send {LButton Down}
        } else if (mode(_MODE.SPECIAL)) {
            if (isActive("mintty") || isActive("ubuntu")) {
                send 1
            } else {
                send {Numpad1}
            }
        } else if (mode(_MODE.SNIPPET)) {
            send :fork_and_knife:
        }
    } else {
        send m
    }
    return


;[NORMAL ]: ウィンドウを最小化する
;[EDIT   ]: 15つ下に移動
;[RANGE  ]: 選択範囲を15つ下に移動
;[MOUSE  ]: ウィンドウを最小化する
;[SPECIAL]: 1キー
$^m::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            sendInput {down 15}
        } else if (mode(_MODE.RANGE)) {
            sendInput +{down 15}
        } else if (mode(_MODE.MOUSE)) {
            WinMinimize, A
        } else if (mode(_MODE.SPECIAL)) {
            send {Numpad1}{Enter}
        }
    } else {
        WinMinimize, A
    }
    return



;[NORMAL ]: shift + mキー
;[EDIT   ]: shift + mキー
;[RANGE  ]: shift + mキー
;[MOUSE  ]: shift + mキー
;[SPECIAL]: shift + mキー
$+m::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send +m
        } else if (mode(_MODE.RANGE)) {
            send +m
        } else if (mode(_MODE.MOUSE)) {
            send +m
        } else if (mode(_MODE.SPECIAL)) {
            send +m
        }
    } else {
        send +m
    }
    return


;[NORMAL ]: Nキー
;[EDIT   ]: F3キー相当
;[RANGE  ]: F3キー相当
;[MOUSE  ]: F3キー相当
;[SPECIAL]: F3キー相当
$n::
    if (!mode(_MODE.NORMAL)) {
        send {F3}
    } else {
        send n
    }
    return

;[NORMAL ]: 新規ウィンドウ
;[EDIT   ]: 新規ウィンドウ
;[RANGE  ]: 新規ウィンドウ
;[MOUSE  ]: 新規ウィンドウ
;[SPECIAL]: 新規ウィンドウ
$^n::
    if (!mode(_MODE.NORMAL)) {
        if (isActive("mintty")) {
            send !{F2}
        } else {
            sendInput {down 15}
        }
    } else {
        if (isActive("mintty")) {
            send !{F2}
        } else {
            send ^n
        }
    }
    return


;[NORMAL ]: Shift + Nキー
;[EDIT   ]: Shift + F3キー相当
;[RANGE  ]: Shift + F3キー相当
;[MOUSE  ]: Shift + F3キー相当
;[SPECIAL]: Shift + F3キー相当
$+n::
    if (!mode(_MODE.NORMAL)) {
        send +{F3}
    } else {
        send +n
    }
    return


;----- [N]Delete [R]Delete(範囲指定終了) [M]右クリック押下 [M]ホイールダウン-----
;[NORMAL ]: oキー(;からのコンビネーションの場合は | を入力する）
;[EDIT   ]: DELキー
;[RANGE  ]: DELキー(処理後に範囲指定を終了する)
;[MOUSE  ]: マウスホイールを少し下に動かす
;[SPECIAL]: 9キー
$o::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send {del}
        } else if (mode(_MODE.RANGE)) {
            send {del}
            setMode(_MODE.EDIT)
        } else if (mode(_MODE.MOUSE)) {
            scrollDownSmall()
        } else if (mode(_MODE.SPECIAL)) {
            if (isActive("mintty") || isActive("ubuntu")) {
                send 9
            } else {
                send {Numpad9}
            }
        }
    } else {
        if (isConbinationKeyAndIMEOn("$;")) {
            send {BS}|
        } else {
            send o
        }
    }
    return


;[NORMAL ]: Ctrl + O
;[EDIT   ]: 単語単位でDelete
;[RANGE  ]: 単語単位でDelete
;[MOUSE  ]: マウスホイールを下に動かす
;[SPECIAL]: Delete
$^o::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            if (isActive("poderosa")) {
                send {ESC}d
            } else {
                send ^{del}
            }
        } else if (mode(_MODE.RANGE)) {
            send ^{del}
            setMode(_MODE.EDIT)
        } else if (mode(_MODE.MOUSE)) {
            scrollDownMiddle()
        } else if (mode(_MODE.SPECIAL)) {
            send {Numpad9}{Enter}
        }
    } else {
        send ^o
    }
    return


;[NORMAL ]: Shift + O
;[EDIT   ]: 5個文字をDeleteする
;[RANGE  ]: Shift + O
;[MOUSE  ]: マウスホイールを大きく下に動かす
;[SPECIAL]: Shift + O
$+o::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            if (isActive("poderosa") || isActive("console") || isActive("ubuntu") || isActive("mintty")) {
                sendInput {DEL 5}
            } else {
                sendInput +{RIGHT 5}{DEL}
            }
        } else if (mode(_MODE.RANGE)) {
            send +o
        } else if (mode(_MODE.MOUSE)) {
            scrollDownLarge()
        } else if (mode(_MODE.SPECIAL)) {
            send +o
        }
    } else {
        send +o
    }
    return

;[NORMAL ]: pキー(;からのコンビネーションの場合は % を入力する）
;[EDIT   ]: コマンドパレット(Ctrl + Shift + pキー => NORMALモード)
;[RANGE  ]: pキ－
;[MOUSE  ]: pキ－
;[SPECIAL]: %キー
$p::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send ^+p
            setMode(_MODE.NORMAL)
        } else if (mode(_MODE.SPECIAL)) {
            send `%
        } else {
            send p
        }
    } else {
        if (isConbinationKeyAndIMEOn("$;")) {
            send {BS}`%
        } else {
            send p
        }
    }
    return


;[NORMAL ]: Shift+pキー
;[EDIT   ]: ahkスクリプトのリロード
;[RANGE  ]: ahkスクリプトのリロード
;[MOUSE  ]: ahkスクリプトのリロード
;[SPECIAL]: ahkスクリプトのリロード
$+p::
    if (!mode(_MODE.NORMAL)) {
        Reload
    } else {
        send +p
    }
    return


;[NORMAL ]: qキー
;[EDIT   ]: ウィンドウの最小化
;[RANGE  ]: ウィンドウの最小化
;[MOUSE  ]: ウィンドウの最小化
;[SPECIAL]: アクティブウィンドウを左上に最大化して移動する
$q::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.SPECIAL)) {
            MoveWindow("LeftUp")
        } else {
            WinMinimize, A
        }
    } else {
        send q
    }
    return



;[NORMAL ]: ウィンドウを閉じる
;[EDIT   ]: ウィンドウを閉じる
;[RANGE  ]: ウィンドウを閉じる
;[MOUSE  ]: ウィンドウを閉じる
;[SPECIAL]: ウィンドウを閉じる
$^q::
    if (isActive("console")) {
        send !{space}c
    } else {
        send !{f4}
    }
    return


;[NORMAL ]: Shift + Q
;[EDIT   ]: Ctrl + Shift + Q
;[RANGE  ]: Ctrl + Shift + Q
;[MOUSE  ]: Ctrl + Shift + Q
;[SPECIAL]: Ctrl + Shift + Q
$+q::
    if (mode(_MODE.NORMAL)) {
        send +q
    } else {
        send ^+q
    }
    return


;[NORMAL ]: rキー(;からのコンビネーションの場合は == を入力する）
;[EDIT   ]: 仮想入力モードをスペシャルモードにする
;[RANGE  ]: 仮想入力モードをスペシャルモードにする
;[MOUSE  ]: ポインタを画面右上に移動 (rからのコンビネーションの場合は ポインタを画面右上隅に移動）
;[SPECIAL]: 仮想入力モードを標準にする
;[DEBUG  ]: 再開

$r::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.SPECIAL)) {
            setMode(_MODE.EDIT)
        } else if (mode(_MODE.MOUSE)) {
            if (isConbinationKey("$r")) {
                moveMousePointerEdge(3, 1)
            } else {
                moveMousePointer(3, 1)
            }
        } else if (mode(_MODE.DEBUG)) {
            send {F8}
        } else {
            setMode(_MODE.SPECIAL)
        }
    } else {
        if (isConbinationKeyAndIMEOn("$;")) {
            send {BS}{space}=={space}
        } else {
            send r
        }
    }
    return

;[NORMAL ]: 更新(poderosa: Ctrl+r)
;[EDIT   ]: 更新(poderosa: Ctrl+r)
;[RANGE  ]: 更新(poderosa: Ctrl+r)
;[MOUSE  ]: 更新(poderosa: Ctrl+r)
;[SPECIAL]: 更新(poderosa: Ctrl+r)
$^r::
    if (isActive("poderosa") || isActive("console") || isActive("mintty") || isActive("ubuntu")) {
        send ^r
    } else {
        send {F5}
    }
    return

;[NORMAL ]: sキー(;からのコンビネーションの場合は「」を入力して、フォーカスを「」内に移動させる）
;[EDIT   ]: Ctrl+Shift+S
;[RANGE  ]: Ctrl+Shift+S
;[MOUSE  ]: ポインタを画面左隅に移動
;[SPECIAL]: アクティブウィンドウを中央下に最大化して移動する
;[DEBUG  ]: 停止
$s::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send ^+{s}
        } else if (mode(_MODE.RANGE)) {
            send ^+{s}
        } else if (mode(_MODE.SPECIAL)) {
            MoveWindow("CenterDown")
        } else if (mode(_MODE.MOUSE)) {
            if (isConbinationKey("$s")) {
                moveMousePointerEdge(1, 2)
            } else if (isConbinationKey("$;")) {
                moveMousePointerScreen("CenterDown")
            } else {
                moveMousePointer(1, 2)
            }
        } else if (mode(_MODE.DEBUG)) {
            send ^{F2}
        }
    } else {
        if (isConbinationKey("$;")) {
            send {BS}
            sendMultiByte("｢")
            sendMultiByte("｣")
            send {left}
        } else {
            send s
        }
    }
    return


;[NORMAL ]: Shif+sキー
;[EDIT   ]: Ctrl+Alt+sキー
;[RANGE  ]: Ctrl+Alt+sキー
;[MOUSE  ]: Ctrl+Alt+sキー
;[SPECIAL]: Ctrl+Alt+sキー
$+s::
    if (!mode(_MODE.NORMAL)) {
        send ^!s
    } else {
        send +s
    }
    return


;[NORMAL ]: Ctrl+Shif+sキー(poderosaの場合は画面更新再開）
;[EDIT   ]: Ctrl+Shif+sキー(poderosaの場合は画面更新再開）
;[RANGE  ]: Ctrl+Shif+sキー(poderosaの場合は画面更新再開）
;[MOUSE  ]: Ctrl+Shif+sキー(poderosaの場合は画面更新再開）
;[SPECIAL]: Ctrl+Shif+sキー(poderosaの場合は画面更新再開）
$^+s::
    if (isActive("poderosa")) {
        send ^q
    } else {
        send ^+s
    }
    return


;----- [N][R][M][S]ウィンドウのスクリーン間移動 -----
$t::
    if (!mode(_MODE.NORMAL)) {
        moveScreen()
    } else {
        send t
    }
    return


;[NORMAL ]: uキー
;[EDIT   ]: BackSpace
;[RANGE  ]: BackSpace後範囲指定を終了する
;[MOUSE  ]: マウスホイールを少し上に動かす
;[SPECIAL]: 7
;[SNIPPET]: :arrow_upper_right:
$u::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send {BS}
        } else if (mode(_MODE.RANGE)) {
            send {BS}
            setMode(_MODE.EDIT)
        } else if (mode(_MODE.MOUSE)) {
            scrollUpSmall()
        } else if (mode(_MODE.SPECIAL)) {
            if (isActive("mintty") || isActive("ubuntu")) {
                send 7
            } else {
                send {Numpad7}
            }
        } else if (mode(_MODE.SNIPPET)) {
            send :arrow_upper_right:
        }
    } else {
        if (isConbinationKeyAndIMEOn("$;")) {
            send {BS}{" 2}{left}
        } else {
            send u
        }
    }
    return

;[NORMAL ]: Ctrl + U
;[EDIT   ]: 単語単位で削除
;[RANGE  ]: 単語単位で削除
;[MOUSE  ]: マウスホイールを上に動かす
;[SPECIAL]: BackSpace
$^u::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            if (isActive("poderosa")) {
                send {ESC}^h
            } else {
                send ^{BS}
            }
        } else if (mode(_MODE.RANGE)) {
            send ^{BS}
            setMode(_MODE.EDIT)
        } else if (mode(_MODE.MOUSE)) {
            scrollUpMiddle()
        } else if (mode(_MODE.SPECIAL)) {
            send {Numpad7}{Enter}
        }
    } else {
        send ^u
    }
    return


;[NORMAL ]: shift + uキー
;[EDIT   ]: 5個文字をBSする
;[RANGE  ]: shift + uキー
;[MOUSE  ]: マウスホイールを大きく上に動かす
;[SPECIAL]: shift + uキー
$+u::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            if (isActive("poderosa") || isActive("console") || isActive("ubuntu") || isActive("mintty")) {
                sendInput {BS 5}
            } else {
                sendInput +{Left 5}{BS}
            }
        } else if (mode(_MODE.RANGE)) {
            send +u
        } else if (mode(_MODE.MOUSE)) {
            scrollUpLarge()
        } else if (mode(_MODE.SPECIAL)) {
            send +u
        }
    } else {
        send +u
    }
    return


;[NORMAL ]: v
;[EDIT   ]: 貼り付けしてモードをVirtual->NORMALに変更
;[RANGE  ]: 貼り付けしてモードをVirtual->NORMALに変更
;[MOUSE  ]: ポインタを画面右下に移動
;[SPECIAL]: ↓
$v::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.MOUSE)) {
            if (isConbinationKey("$v")) {
                moveMousePointerEdge(3, 3)
            } else {
                moveMousePointer(3, 3)
            }
        } else if (mode(_MODE.SPECIAL)) {
            send {down}
        } else {
            setMode(_MODE.EDIT)
            if (isActive("mintty") || isActive("ubuntu")) {
                send +{Ins}
            } else {
                send ^v
            }
        }
    } else {
        send v
    }
    return


;[NORMAL ]: 貼り付け
;[EDIT   ]: 貼り付け
;[RANGE  ]: 貼り付け
;[MOUSE  ]: 貼り付け
;[SPECIAL]: 貼り付け
$^v::
    if (isActive("mintty")) {
        send +{Ins}
    } else {
        send ^v
    }
    return


;[NORMAL ]: wキー (;からのコンビネーションの場合は != を入力する）
;[EDIT   ]: ページの先頭に移動
;[RANGE  ]: 選択範囲をページの先頭に移動
;[MOUSE  ]: ポインタを画面左上に移動 (;からのコンビネーションの場合は ポインタを左上画面の中央に移動）
;[SPECIAL]: アクティブウィンドウを中央上に最大化して移動する
;[SNIPPET]: :womans_clothes:
$w::
    if (mode(_MODE.NORMAL)) {
        if (isConbinationKeyAndIMEOn("$;")) {
            send {BS}{space}{!}={space}
        } else {
            send w
        }
    } else if (mode(_MODE.EDIT)) {
        send ^{Home}
    } else if (mode(_MODE.RANGE)) {
        send ^+{Home}
    } else if (mode(_MODE.MOUSE)) {
        if (isConbinationKey("$w")) {
            moveMousePointerEdge(1, 1)
        } else if (isConbinationKey("$;")) {
            moveMousePointerScreen("CenterUp")
        } else {
            moveMousePointer(1, 1)
        }
    } else if (mode(_MODE.SPECIAL)) {
        MoveWindow("CenterUp")
    } else if (mode(_MODE.SNIPPET)) {
        send :womans_clothes:
    }
    return


;[NORMAL ]: Shift + wキー
;[EDIT   ]: ウィンドウをデュアルサイズで最大化する
;[RANGE  ]: ウィンドウをデュアルサイズで最大化する
;[MOUSE  ]: ウィンドウをデュアルサイズで最大化する
;[SPECIAL]: ウィンドウをデュアルサイズで最大化する
$+w::
    if (mode(_MODE.NORMAL)) {
        send +w
    } else if (mode(_MODE.EDIT)) {
        changeWindowSizeDualMax()
    } else if (mode(_MODE.RANGE)) {
        changeWindowSizeDualMax()
    } else if (mode(_MODE.MOUSE)) {
        changeWindowSizeDualMax()
    } else if (mode(_MODE.SPECIAL)) {
        changeWindowSizeDualMax()
    }
    return


;[NORMAL ]: xキー
;[EDIT   ]: Ctrl + xキー ＆ モードをVirtual->NORMALに変更
;[RANGE  ]: Ctrl + xキー ＆ モードをVirtual->NORMALに変更
;[MOUSE  ]: ポインタを画面左下に移動
;[SPECIAL]: Ctrl + xキー ＆ モードをVirtual->NORMALに変更
$x::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.MOUSE)) {
            if (isConbinationKey("$x")) {
                moveMousePointerEdge(1, 3)
            } else {
                moveMousePointer(1, 3)
            }
        } else {
            setMode(_MODE.EDIT)
            send ^x
        }
    } else {
        send x
    }
    return


;----- [N]元に戻すをやめる [R]元に戻すをやめる -----
$y::
    if (!mode(_MODE.NORMAL)) {
        send ^y
    } else {
        send y
    }
    return

;----- [N]元に戻す [R]元に戻す -----
$z::
    if (!mode(_MODE.NORMAL)) {
        send ^z
    } else {
        send z
    }
    return


;******************************************************************
; マウスボタン
;******************************************************************

$XButton1::
    send {F12}
    return


;******************************************************************
; マウスジェスチャー
;******************************************************************

doMRd() {
    send ^#{Right}
}

doMRu() {
    send ^#{Left}
}

doMRl() {
    if (isActive("excelVBA")) {
        send +^{F2}
    } else {
        send !{Left}
    }
}

doMRr() {
    if (isActive("eclipse") || isActive("intellij")) {
        send {F3}
    } else if (isActive("excelVBA")) {
        send +{F2}
    } else {
        send !{Right}
    }
}

doMR() {
    send {RButton}
}
