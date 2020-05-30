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
    if (isSecondKey()) {
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

$Space::
    if (isSecondKey()) {
        Send {Right}{Space}
    } else {
        Send {Space}
    }
    return

;******************************************************************
; ESC
;******************************************************************
;----- いかなる場合も『日本語入力』『モード』をOFFにする -----
$ESC::
    send {ESC}
    if (isTerminal()) {
        setIME(false)
        setMode(_MODE.NORMAL)
    }
    return


;******************************************************************
; Enter
;******************************************************************

;[NORMAL ]: Enterキー (コンビネーション時は;入力後にEnter)
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
            if (isTerminal() || isActive("ubuntu")) {
                send 0
            } else {
                send {Numpad0}
            }
        } else {
            send {Enter}
        }
    } else {
        if (isSecondKey()) {
            send `;
        }
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
            if (isTerminal() || isActive("ubuntu")) {
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


;******************************************************************
; タブ
;******************************************************************

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


;[NORMAL ]: Ctrl + TABキー (Chromeのときは直近のタブに移動する)
;[EDIT   ]: Ctrl + TABキー (Chromeのときは直近のタブに移動する)
;[RANGE  ]: Ctrl + TABキー (Chromeのときは直近のタブに移動する)
;[MOUSE  ]: Ctrl + TABキー
;[SPECIAL]: Ctrl + TABキー
$^TAB::
    if (isActiveProcess("chrome")) {
        ;CLUTを使用
        send !a
    } else {
        send ^{TAB}
    }
    return


;******************************************************************
; PageUp PageDown
;******************************************************************

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
; マウス/トラックボールにEnterを割り当てるための確保
$PgDn::
    send {Enter}
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
