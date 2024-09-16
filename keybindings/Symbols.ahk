;******************************************************************
; セミコロン
;******************************************************************

;[N] 2キーバインドのPrefixキー
;[E] 行末へ移動
;[R] 行末に選択範囲を移動
;[S] コロン
$;::
    if (modes("N")) {
        ; Do nothing...
    } else if (modes("E")) {
        send {end}
    } else if (modes("R")) {
        send +{end}
    } else if (modes("S")) {
        send :
    }
    return

;[N] Shift + ;キー
;[E] 15つ右に移動
;[R] 選択範囲を15つ右に移動
$+;::
    if (modes("N")) {
        send +`;
    } else if (modes("E")) {
        sendInput {right 15}
    } else if (modes("R")) {
        sendInput +{right 15}
    }
return

;[N] セミコロン (; -> 行末に移動してセミコロン)
$^;::
    if (modes("N")) {
        if (2K(";")) {
            send {End}`;
        } else {
            send `;
        }
    }
return

;[NE]: 本日の日付を入力(YYYYMMDD)
$^+;::
    if (modes("NE")) {
        if (AW("excel")) {
            send ^+;
        } else {
            Clipboard = %A_Year%%A_Mon%%A_MDay%
            paste()
        }
    }
return

;******************************************************************
; コロン
;******************************************************************

;[N]    :キー
;[ERMS] 日本語入力ON + モードをNORMALに変更
;※ :
$SC028::
    if (modes("N")) {
        send :
    } else if (modes("ERMS")) {
        setIME(true)
        setMode(_MODE.NORMAL)
    }
return

;[NE] 現在の時刻を入力(hh:mm) (コンビネーションからだと行末に移動してコロン)
;※ Ctrl + :
$^SC028::
    if (modes("NE")) {
        Clipboard = %A_Hour%:%A_Min%
        paste()
    }
return

;[NE] 現在の時刻を入力(hhmmss)
;※ Ctrl + Shift + :
$^+SC028::
    if (modes("NE")) {
        Clipboard = %A_Hour%%A_Min%%A_Sec%
        paste()
    }
return

;******************************************************************
; ピリオド
;******************************************************************

;[N] .キー
;[E] = を入力しモードをNORMALに
;[S] 3キー
$.::
    if (modes("N")) {
        send .
    } else if (modes("E")) {
        send `=
        setMode(_MODE.NORMAL)
    } else if (modes("S")) {
        if (isTerminal() || isUbuntu()) {
            send 3
        } else {
            send {Numpad3}
        }
    }
return

; 右クリックメニュー
$^.::
    send {appsKey}
    return

;[N] shift + .キー
;[E] スペースキー × 10
$+.::
    if (modes("N")) {
        send +.
    } else if (modes("E")) {
        send {space 10}
    }
return

;******************************************************************
; カンマ
;******************************************************************

;[N] ,キー
;[S] 2キー
$,::
    if (modes("N")) {
        send `,
    } else if (modes("S")) {
        if (isTerminal() || isUbuntu()) {
            send 2
        } else {
            send {Numpad2}
        }
    }
return

;[N] shift + ,キー
;[E] スペースキー × 5
$+,::
    if (modes("N")) {
        send +,
    } else if (modes("E")) {
        send {space 5}
    }
return

;******************************************************************
; スラッシュ
;******************************************************************

;[N] /キー (; -> 今日の日付/スラッシュ区切り (ex: 2024/07/14))
;[S] .キー
$/::
    if (modes("N")) {
        if (2K(";")) {
            Clipboard = %A_Year%/%A_Mon%/%A_MDay%
            paste()
        } else {
            send /
        }
    } else if (modes("S")) {
        if (isTerminal() || isUbuntu()) {
            send .
        } else {
            send {NumpadDot}
        }
    }
return

;******************************************************************
; 山かっこ(閉じる)
;******************************************************************
;[NE]: ]キー  (; -> タスク箇条書き)(Obsidian: C-j -> Link search)
$]::
    if (modes("NE")) {
        if (2K(";")) {
            send - [ ]{Space} 
        } else {
            if (AP("Obsidian") && 2K("^j")) {
                Send, {F24}
            } else {
                Send, ] 
            }
        }
    }
return

; Ctrl+Shift+]キー (ターミナルの場合はCtrl+Shift+]が使えないのでAlt+]で代用)
$^+]::
  if (isTerminal()) {
      Send !] 
  } else {
      Send ^+] 
  }
return

