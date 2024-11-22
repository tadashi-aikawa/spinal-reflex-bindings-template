;******************************************************************
; 無変換
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

;******************************************************************
; コントロール
;******************************************************************

;----- マウスカーソル配下のウィンドウをアクティブにする -----
; コンビネーション時はアクティブウィンドウの中央にマウスカーソルを召喚する
$Ctrl::
    if (2K(";")) {
        MoveCenterInActiveWindow()
    } else {
        MouseGetPos, , , hWindow
        WinActivate, ahk_id %hWindow%
        FlashWindow() 
    }
return

;******************************************************************
; Space
;******************************************************************

;Ctrl+Spaceキー (ターミナルの場合はCtrl+Spaceが使えないのでF5で代用)
$^Space::
    if (isTerminal()) {
        send {F5}
    } else {
        send ^{Space}
    }
return

;Shift+Spaceキー (ターミナルの場合はShift+Spaceが使えないのでShift+F6 or F18(WSL)で代用)
$+Space::
    if (isTerminal()) {
        ; WSLだとF18になる
        send +{F6}
    } else {
        send +{Space}
    }
return

;******************************************************************
; ESC
;******************************************************************
;----- モードを標準に戻し、『日本語入力』『モード』をOFFにして、修飾キーも上げる -----
; TODO: 一旦試しに無効化してみる
$ESC::
    send {ESC}
    setIME(false)
    setMode(_MODE.NORMAL)
    Send, {Shift up}{Ctrl up}{Alt up}{LWin up}{RWin up}
return

;---- 修飾キーが押しっぱなしになってしまった場合の発動もフォロー(2つ同時は無理だけど)
$+ESC::
    Send, {Shift up}{Ctrl up}{Alt up}{LWin up}{RWin up}
return
$^ESC::
    Send, {Shift up}{Ctrl up}{Alt up}{LWin up}{RWin up}
return
$!ESC::
    Send, {Shift up}{Ctrl up}{Alt up}{LWin up}{RWin up}
return
$#ESC::
    Send, {Shift up}{Ctrl up}{Alt up}{LWin up}{RWin up}
return


;******************************************************************
; Enter
;******************************************************************

;[N]  Enterキー (; -> ;<Enter>)
;[ER] Enterキー
;[M]  マウスの左クリック
;[S]  0キー
$Enter::
    if (modes("N")) {
        if (2K(";")) {
            send `;{Enter}
        } else {
            send {Enter}
        }
    } else if (modes("ER")) {
        send {Enter}
    } else if (modes("M")) {
        MouseGetPos nowX, nowY
        Click nowX, nowY
    } else if (modes("S")) {
        if (isTerminal() || isUbuntu()) {
            send 0
        } else {
            send {Numpad0}
        }
    }
return

;[N]  Ctrl+Enterキー (ターミナルの場合はCtrl+Enterが使えないのでF12で代用)
$^Enter::
    if (modes("N")) {
        if (isTerminal()) {
            send {F12}
        } else {
            send ^{Enter}
        }
    }
return

;[NE] Shift+Enterキー (IMEがONのときは候補の1つもを選択する) (ターミナルの場合はShift+Enterが使えないのでF11で代用)
$+Enter::
    if (modes("NE")) {
        if (getIME()) {
            send {down}{Enter}
        } else {
            if (isTerminal()) {
                send {F11}
            } else {
                send +{Enter}
            }
        }
    }
return

;******************************************************************
; タブ
;******************************************************************

;[NES] TABキー
;[R]   TABキー + モードをNORMALに変更
$TAB::
    if (modes("NES")) {
        send {TAB}
    } else if (modes("R")) {
        if (mode(_MODE.RANGE)) {
            setMode(_MODE.EDIT)
        }
        send {TAB}
    }
return

;[NES] Shift+TABキー
;[R]   Shift+TABキー + モードをNORMALに変更
$+TAB::
    if (modes("NES")) {
        send +{TAB}
    } else if (modes("R")) {
        if (mode(_MODE.RANGE)) {
            setMode(_MODE.EDIT)
        }
        send +{TAB}
    }
return

;******************************************************************
; PageUp PageDown
;******************************************************************

;BS
$PgUp::
    send {BS}
return

; Enter
; マウス/トラックボールにEnterを割り当てるための確保
$PgDn::
    send {Enter}
return

