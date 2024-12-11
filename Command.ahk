;【概要】選択されたUriを開く（エクスプローラかブラウザかは文字列で判断）
;【引数】なし
;【戻値】なし
openUri() {
    Clipboard = ;ClipWaitで確実にコピーするため？
    Send ^c
    Sleep 200
    word := RegExReplace(Clipboard, "\r\n", "") ;URLに改行が含まれる場合は削除する

    SplitPath, word, name, dir, ext, noext, drive
    IfInString, drive, http://
    {
        Run, %word%
    }
    else if(drive != "") {
        Run, %word%
    }
    else if(Clipboard != "") {
        Run, http://www.google.com/search?q=%word%
    }
}

;【概要】ウィンドウを最適な大きさで、任意の場所に移動する
;【引数】場所 (LeftUp / LeftDown / CenterUp / CenterDown / RightUp / RightDown )
;【戻値】なし
MoveWindow(location) {
    locX := getSettingsValue("QuickMoveWindow", location . "LocX")
    locY := getSettingsValue("QuickMoveWindow", location . "LocY")
    winX := getSettingsValue("QuickMoveWindow", location . "WinX")
    winY := getSettingsValue("QuickMoveWindow", location . "WinY")
    isFull := getSettingsValue("QuickMoveWindow", location . "IsFull")

    ; WinMaximizeの後にWinMoveすると、最小化から復帰したときウィンドウ位置が不正になる
    WinRestore, A
    WinMove A, , %locX%, %locY%, %winX%, %winY%
    if (isFull) {
        WinMaximize, A
    }
}

;【概要】現在のウィンドウを横1920、縦最大にして画面中央に表示
SetFullHDWidthAtCenter() {
    WinGetPos, WinX, WinY,,, A
    SysGet, MonitorCount, MonitorCount
    Loop, %MonitorCount%
    {
        SysGet, Monitor, Monitor, %A_Index%
        padding := 30
        if (WinX >= MonitorLeft - padding
            and WinX <= MonitorRight - padding
            and WinY >= MonitorTop - padding
            and WinY <= MonitorBottom - padding)
        {
            TargetMonitor := A_Index
            break
        }
    }

    SysGet, Monitor, Monitor, %TargetMonitor%
    NewX := MonitorLeft + (MonitorRight - MonitorLeft - 1920) / 2
    NewY := MonitorTop - 1
    TaskBarHeight := 48 - 3
    WinHeight := MonitorBottom - MonitorTop - TaskBarHeight
    WinRestore, A

    WinMove, A,, NewX, NewY, 1920, WinHeight
}

;【概要】現在のウィンドウの幅・高さを変更
setWindowSize(width, height) {
    WinGetPos, WinX, WinY, WinW, WinH, A
    WinRestore, A
    WinMove, A, , WinX, WinY, width, height
}

;【概要】指定位置のウィンドウハンドラを取得する
;【引数】px: x座標, py: y座標
;【戻値】Window handler
getWindowHandlerAtPosition(px, py) {
    VarSetCapacity(POINT, 8, 0x00)
    NumPut(px, POINT, 0x00, "int")
    NumPut(py, POINT, 0x04, "int")
    HWND := DllCall("WindowFromPoint", "Int64", NumGet(POINT, 0x00, "int64"))
    ANCESTOR_HWND := DllCall("GetAncestor", "UInt", HWND, "UInt", GA_ROOT := 2)
    WinExist("ahk_id" . ANCESTOR_HWND)
    return %ANCESTOR_HWND%
}

;【概要】ウィンドウをアクティブにする
;【引数】場所 (LeftUp / LeftDown / CenterUp / CenterDown / RightUp / RightDown )
;【戻値】なし
ActivateWindow(location) {
    locX := getSettingsValue("QuickMoveWindow", location . "LocX")
    locY := getSettingsValue("QuickMoveWindow", location . "LocY")
    winX := getSettingsValue("QuickMoveWindow", location . "WinX")
    winY := getSettingsValue("QuickMoveWindow", location . "WinY")

    ; MsgBox, %locX% . - . %locY% . - . %winX% . - . %winY%
    hwnd := getWindowHandlerAtPosition(locX + winX / 2, locY + winY / 2)
    WinActivate, ahk_id %hwnd%
}

;【概要】ツールウィンドウタイトルの文字列を含むウィンドウをアクティブにする
;【引数】設定で定義されたウィンドウタイトル名
;【戻値】なし
ActivateWindowByToolWindowTitle(tool) {
    SetTitleMatchMode, 2
    titleName := getSettingsValue("WindowTitleName", tool)
    WinGet, hwnd, ID, %titleName%
    WinActivate, ahk_id %hwnd%
    SetTitleMatchMode, 1
}

;【概要】指定したツールのウィンドウをアクティブにする
;【引数】設定で定義されたツール名
;【戻値】なし
ActivateWindowByTool(tool) {
    clsname := getSettingsValue("WindowClassName", tool)
    WinGet, hwnd, ID, ahk_class %clsname%
    WinActivate, ahk_id %hwnd%
}

;【概要】指定したプロセスのウィンドウをアクティブにする
;【引数】設定で定義されたプロセス名
;【戻値】なし
ActivateWindowByProcess(process) {
    pName := getSettingsValue("ProcessName", process)
    WinGet, hwnd, ID, ahk_exe %pName%
    WinActivate, ahk_id %hwnd%
}

;【概要】アクティブウィンドウの中央にカーソルを移動します
;【引数】なし
;【戻値】なし
MoveCenterInActiveWindow() {
    WinGetPos, winX, winY, width, height, A
    CoordMode, Mouse, Screen
    MouseGetPos, mX, mY

    moveMouse(winX + width / 2 - mX, winY + height / 2 - mY)

    CoordMode, Mouse, Relative
}

;【概要】アクティブウィンドウをフラッシュします
;【引数】なし
;【戻値】なし
FlashWindow() {
    WinSet, Transparent, 128, A
    Sleep, 50
    WinSet, Transparent, OFF, A
}

;【概要】ウィンドウをスクリーン単位で移動します
;【引数】なし
;【戻値】なし
moveScreen() {
    Send #+{right}
}

;【概要】2キーバインドのキーかどうかを判定します
;【引数】Prefixキー
;【戻値】boolean
2K(prefix) {
    return (A_PriorHotKey = "$" . prefix)
}

;【概要】マルチバイト文字列をsendします。
;        日本語入力のON/OFFに関わらず決定された状態で出力します。
;        複数指定することもできます。
;【引数】キー
;【戻値】なし
sendMultiByte(keys) {
    sendInput %keys%
    sleep 50
}

;【概要】日本語入力をON/OFFを指定して切り替える
;【引数】true: 日本語入力ON / false: 日本語入力OFF
;【戻値】なし
setIME(imeOn) {
    if (isUbuntu()) {
        if (imeOn) {
            send {sc046}
        } else {
            send ^{sc046}
        }
    } else {
        IME_SET(imeOn)
    }
}

getIME() {
    return IME_GET()
}

; クリップボードの貼り付け
paste() {
    if (isTerminal() || AW("intellij")) {
        send +{Ins}
    } else {
        send ^v
    }
}
