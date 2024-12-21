;[N]  1キー (; -> Terminalを開く)
;[ER] URLをエクスプローラーまたはブラウザで開く
;[S]  ウィンドウサイズを600x400に変更
$1::
    if (modes("N")) {
        if (2K(";")) {
            ActivateWindowByProcess("terminal")
        } else {
            send 1
        }
    } else if (modes("ER")) {
        openUri()
    } else if (modes("S")) {
        setWindowSize(600, 400)
    }
return


;[N] 2キー (; -> Obsidianを開く) (Obsidian: C-j -> 2hop search)
;[S] ウィンドウサイズを800x480に変更
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
    } else if (modes("S")) {
        setWindowSize(800, 480)
    }
return


;[NERMS]: F2キー
$^2::
    send {f2}
return

;[N]: 見出しレベル2の挿入
$!2::
    if (modes("N")) {
        send, {#}{#}{space}
    }
return

;[N] 3キー
;[S] ウィンドウサイズを1024x600に変更
$3::
    if (modes("N")) {
        send 3
    } else if (modes("S")) {
        setWindowSize(1024, 600)
    }

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
;[S] ウィンドウサイズを1280x720に変更
$4::
    if (modes("N")) {
        send 4
    } else if (modes("E")) {
        WinMinimize, A
    } else if (modes("S")) {
        setWindowSize(1280, 720)
    }
return

;[N]: 見出しレベル4の挿入
$!4::
    if (modes("N")) {
        send, {#}{#}{#}{#}{space}
    }
return

;[N] 5キー
;[S] ウィンドウサイズを1366x768に変更
$5::
    if (modes("N")) {
        send 5
    } else if (modes("S")) {
        setWindowSize(1366, 768)
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
