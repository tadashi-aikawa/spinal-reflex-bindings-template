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
AW(name) {
  return isActive(name)
}

;【概要】指定されたプロセスがアクティブであるか
;【引数】name: プロセス名
;【戻値】true / false
isActiveProcess(name) {
    pName := getSettingsValue("ProcessName", name)
    WinGet, ahk_process, ProcessName, A
    return pName == ahk_process
}
AP(name) {
  return isActiveProcess(name)
}

;【概要】指定されたウィンドウがターミナルか (ゆるい判定..minttyはgit bashかな...)
;【戻値】true / false
isTerminal() {
    return isActive("mintty") || isActiveProcess("terminal") || isActiveProcess("wezterm")
}

;【概要】指定されたウィンドウがUbuntuか (おおざっぱな判定..)
;【戻値】true / false
isUbuntu() {
    ;Virtual BoxかVCXSRVを使っている想定
    return isActive("ubuntu") || isActiveProcess("vcxsrv")
}

