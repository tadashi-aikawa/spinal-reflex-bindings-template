;******************************************************************
; ユーティリティ 初めにincludeすること
;******************************************************************

;【概要】設定ファイルから値を取得します
;【引数】section: 設定ファイルのセクション名
;        key:     設定ファイルのキー名
;【戻値】設定値
;【備考】設定値はSettings.iniの設定値によって取得元を変更します
getSettingsValue(section, key) {
    IniRead setting, %A_ScriptDir%\Settings.ini, FILE, name
    IniRead value, %A_ScriptDir%\settings\%setting%.ini, %section%, %key%

    return value
}

;【概要】指定されたウィンドウがアクティブであるか
;【引数】name: ウィンドウクラス名
;【戻値】true / false
isActive(name) {
    winName := getSettingsValue("WindowClassName", name)
    IfWinActive ahk_class %winName%
    {
        return true
    }
    else
    {
        return false
    }
}

;【概要】指定されたウィンドウがターミナルか (ゆるい判定..)
;【戻値】true / false
isTerminal() {
    return isActive("mintty") || isActive("cmder")
}

;【概要】指定されたプロセスがアクティブであるか
;【引数】name: プロセス名
;【戻値】true / false
isActiveProcess(name) {
    pName := getSettingsValue("ProcessName", name)
    WinGet, ahk_process, ProcessName, A
    if (pName == ahk_process) {
        return true
    } else {
        return false
    }
}

;【概要】指定位置のウィンドウハンドラを取得する
;【引数】px: x座標, py: y座標
;【戻値】Window handler
getWindowHandlerAtPosition(px, py) {
    VarSetCapacity(POINT, 8, 0x00)
    NumPut(PX, POINT, 0x00, "int")
    NumPut(PY, POINT, 0x04, "int")
    HWND := DllCall("WindowFromPoint", "Int64", NumGet(POINT, 0x00, "int64"))
    ANCESTOR_HWND := DllCall("GetAncestor", "UInt", HWND, "UInt", GA_ROOT := 2)
    WinExist("ahk_id" . ANCESTOR_HWND)
    return %ANCESTOR_HWND%
}
