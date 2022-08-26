;[NORMAL ]: 1キー (;コンビネーションの場合はTerminalを開く)
;[EDIT   ]: URLをエクスプローラーまたはブラウザで開く
;[RANGE  ]: URLをエクスプローラーまたはブラウザで開く
;[MOUSE  ]: URLをエクスプローラーまたはブラウザで開く
;[SPECIAL]: URLをエクスプローラーまたはブラウザで開く
$1::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            ActivateWindowByProcess("terminal")
        } else {
            send 1
        }
    } else {
        openUri()
    }
    return


;[NORMAL ]: 2キー (コンビネーションキーの場合はObsidianを開く )
;[EDIT   ]: 2キー
;[RANGE  ]: 2キー
;[MOUSE  ]: 2キー
;[SPECIAL]: 2キー
$2::
    if (isSecondKey()) {
        ActivateWindowByProcess("obsidian")
    } else {
        send 2
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

;[NORMAL ]: Alt+2  (Obsidianの場合、見出しレベル2)
;[EDIT   ]: Alt+2  (Obsidianの場合、見出しレベル2)
;[RANGE  ]: Alt+2  (Obsidianの場合、見出しレベル2)
;[MOUSE  ]: Alt+2  (Obsidianの場合、見出しレベル2)
;[SPECIAL]: Alt+2  (Obsidianの場合、見出しレベル2)
$!2::
    if (isActiveProcess("Obsidian")) {
        send, {#}{#}{space}
    }
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

;[NORMAL ]: Alt+3  (Obsidianの場合、見出しレベル3)
;[EDIT   ]: Alt+3  (Obsidianの場合、見出しレベル3)
;[RANGE  ]: Alt+3  (Obsidianの場合、見出しレベル3)
;[MOUSE  ]: Alt+3  (Obsidianの場合、見出しレベル3)
;[SPECIAL]: Alt+3  (Obsidianの場合、見出しレベル3)
$!3::
    if (isActiveProcess("Obsidian")) {
        send, {#}{#}{#}{space}
    }
    return

;[NORMAL ]: 4キー
;[EDIT   ]: ウィンドウ最小化
;[RANGE  ]: ウィンドウ最小化
;[MOUSE  ]: ウィンドウ最小化
;[SPECIAL]: ウィンドウ最小化
$4::
    if (!mode(_MODE.NORMAL)) {
        WinMinimize, A
    } else {
        send 4
    }
    return

;[NORMAL ]: Alt+4  (Obsidianの場合、見出しレベル4)
;[EDIT   ]: Alt+4  (Obsidianの場合、見出しレベル4)
;[RANGE  ]: Alt+4  (Obsidianの場合、見出しレベル4)
;[MOUSE  ]: Alt+4  (Obsidianの場合、見出しレベル4)
;[SPECIAL]: Alt+4  (Obsidianの場合、見出しレベル4)
$!4::
    if (isActiveProcess("Obsidian")) {
        send, {#}{#}{#}{#}{space}
    }
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
