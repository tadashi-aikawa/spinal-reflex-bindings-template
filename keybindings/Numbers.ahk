;[NORMAL ]: 1キー
;[EDIT   ]: URLをエクスプローラーまたはブラウザで開く
;[RANGE  ]: URLをエクスプローラーまたはブラウザで開く
;[MOUSE  ]: URLをエクスプローラーまたはブラウザで開く
;[SPECIAL]: ウィンドウを左半分に寄せる
$1::
    if (mode(_MODE.NORMAL)) {
        send 1
    } else {
        if (mode(_MODE.SPECIAL)) {
            send #{Left}
        } else {
            openUri()
        }
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

;[NORMAL ]: 4
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
