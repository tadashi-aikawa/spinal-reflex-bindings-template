;[N]  1キー (; -> Terminalを開く)
;[ER] URLをエクスプローラーまたはブラウザで開く
$1::
    if (modes("N")) {
        if (2K(";")) {
            ActivateWindowByProcess("terminal")
        } else {
            send 1
        }
    } else if (modes("ER")) {
        openUri()
    }
return


;[N] 2キー (; -> Obsidianを開く) (Obsidian: C-j -> 2hop search)
$2::
    if (modes("N")) {
        if (2K(";")) {
            ActivateWindowByToolWindowTitle("obsidian")
        } else {
            if (AP("Obsidian") && 2K("^j")) {
                send {F22}
            } else {
                send 2
            }
        }
    }
return


;[EERMS]: F2キー
$^2::
    send {f2}
return

;[N]: 見出しレベル2の挿入
$!2::
    if (modes("N")) {
        send, {#}{#}{space}
    }
return

;[EERMS]: F3キー
$^3::
    send {f3}
return

;[N]: 見出しレベル3の挿入
$!3::
    if (modes("N")) {
        send, {#}{#}{#}{space}
    }
return

;[N] 4キー
;[E] ウィンドウ最小化
$4::
    if (modes("N")) {
        send 4
    } else if (modes("E")) {
        WinMinimize, A
    }
return

;[N]: 見出しレベル4の挿入
$!4::
    if (modes("N")) {
        send, {#}{#}{#}{#}{space}
    }
return

;[N]: 見出しレベル5の挿入
$!5::
    if (modes("N")) {
        send, {#}{#}{#}{#}{#}{space}
    }
return

;[N]: 見出しレベル6の挿入
$!6::
    if (modes("N")) {
        send, {#}{#}{#}{#}{#}{#}{space}
    }
return

;[N] { (中カッコ開始）
$^8::
    if (modes("N")) {
        send {{}
    }
return


;[N] } (中カッコ終了）
$^9::
    if (modes("N")) {
        send {}}
    }
return
