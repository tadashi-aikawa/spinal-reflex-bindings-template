;******************************************************************
; セミコロン
;******************************************************************

;[NORMAL ]: コンビネーション開始
;[EDIT   ]: 行末へ移動
;[RANGE  ]: 行末に選択範囲を移動
;[MOUSE  ]: ポインタを１画面分左に移動
;[SPECIAL]: セミコロン
$;::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send {end}
        } else if (mode(_MODE.RANGE)) {
            send +{end}
        } else if (mode(_MODE.MOUSE)) {
            moveMouseRightScreen()
        } else if (mode(_MODE.SPECIAL)) {
            send :
        }
    } else {
        ; Do nothing...
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


;[NORMAL ]: セミコロン (コンビネーションからだと行末に移動してセミコロン)
;[EDIT   ]: 行末へ移動
;[RANGE  ]: 行末へ移動
;[MOUSE  ]: 行末へ移動
;[SPECIAL]: 行末へ移動
$^;::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            send {End}
        }
        send `;
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


;******************************************************************
; アットマーク
;******************************************************************

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


;******************************************************************
; コロン
;******************************************************************

;[NORMAL ]: :キー (コンビネーションからだと →:<Space>)
;[EDIT   ]: 日本語入力ON + モードをNORMALに変更
;[RANGE  ]: 日本語入力ON + モードをNORMALに変更
;[MOUSE  ]: 日本語入力ON + モードをNORMALに変更
;[SPECIAL]: 日本語入力ON + モードをNORMALに変更
;※ :
$SC028::
    if (!mode(_MODE.NORMAL)) {
        setIME(true)
        setMode(_MODE.NORMAL)
    } else {
        if (isSecondKey()) {
            send {Right}:{space}
        } else {
            send :
        }
    }
    return


;[NORMAL ]: Ctrl+: (コンビネーションからだと行末に移動してコロン)
;[EDIT   ]: Ctrl+: 
;[RANGE  ]: Ctrl+:
;[MOUSE  ]: Ctrl+:
;[SPECIAL]: Ctrl+:
;※ Ctrl + :
$^SC028::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            send {End}
            send :
        } else {
            send ^:
        }
    } else {
        send ^:
    }
    return


;[NORMAL ]: 現在の時刻を入力(hhmmss)
;[EDIT   ]: 現在の時刻を入力(hhmmss)
;[RANGE  ]: 現在の時刻を入力(hhmmss)
;[MOUSE  ]: 現在の時刻を入力(hhmmss)
;[SPECIAL]: 現在の時刻を入力(hhmmss)
;※ Ctrl + Shift + :
$^+SC028::
    Clipboard = %A_Hour%%A_Min%%A_Sec%
    Send, ^v
    return


;******************************************************************
; ピリオド
;******************************************************************

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


;******************************************************************
; カンマ
;******************************************************************

;[NORMAL ]: ,キー (コンビネーションからだと →,<Space>)
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
        if (isSecondKey()) {
            send {Right},{space}
        } else {
            send `,
        }
    }
    return


;[NORMAL ]: Ctrl + , キー (コンビネーションからだと行末に移動してカンマ)
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
        if (isSecondKey()) {
            send {End}
            send `,
        } else {
            send ^,
        }
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
; スラッシュ
;******************************************************************

;[NORMAL ]: /キー
;[EDIT   ]: Ctrl+J + NORMALモード
;[RANGE  ]: Ctrl+J + NORMALモード
;[MOUSE  ]: Ctrl+J + NORMALモード
;[SPECIAL]: .キー
$/::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send ^j
            setMode(_MODE.NORMAL)
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

