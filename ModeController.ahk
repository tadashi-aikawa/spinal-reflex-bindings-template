;WARNING: 最初にincludeする

;******************************************************************
; 定数
;******************************************************************

;-------------------------------
;モード
;-------------------------------
_MODE := {}
_MODE.NORMAL := {"id":0, "color":"", "label":""}
_MODE.EDIT := {"id":1, "color":"000000", "label":"Edit"}
_MODE.RANGE := {"id":2, "color":"00FF00", "label":"Range"}
_MODE.MOUSE := {"id":3, "color":"FF0000", "label":"Mouse"}
_MODE.SPECIAL := {"id":4, "color":"0000FF", "label":"Special"}
_MODE.SNIPPET := {"id":5, "color":"AAAA00", "label":"Snippet"}
_MODE.DEBUG := {"id":6, "color":"FF00FF", "label":"Debug"}

;-------------------------------
;ディスプレイ設定
;-------------------------------
_DISPLAYS := initDisplays()
_TRANSPARENT := getSettingsValue("ModeLabel", "Transparent")

initDisplays() {
    ret := {}

    x1 := getSettingsValue("ModeLabel", "X1")
    y1 := getSettingsValue("ModeLabel", "Y1")
    if (x1 != "ERROR") {
        ret[1] := {"label_x":x1, "label_y":y1, "label_id":"dis1_label", "text_id":"dis1_text"}
    }

    x2 := getSettingsValue("ModeLabel", "X2")
    y2 := getSettingsValue("ModeLabel", "Y2")
    if (x2 != "ERROR") {
        ret[2] := {"label_x":x2, "label_y":y2, "label_id":"dis2_label", "text_id":"dis2_text"}
    }

    x3 := getSettingsValue("ModeLabel", "X3")
    y3 := getSettingsValue("ModeLabel", "Y3")
    if (x3 != "ERROR") {
        ret[3] := {"label_x":x3, "label_y":y3, "label_id":"dis3_label", "text_id":"dis3_text"}
    }

    x4 := getSettingsValue("ModeLabel", "X4")
    y4 := getSettingsValue("ModeLabel", "Y4")
    if (x4 != "ERROR") {
        ret[4] := {"label_x":x4, "label_y":y4, "label_id":"dis4_label", "text_id":"dis4_text"}
    }

    x5 := getSettingsValue("ModeLabel", "X5")
    y5 := getSettingsValue("ModeLabel", "Y5")
    if (x5 != "ERROR") {
        ret[5] := {"label_x":x5, "label_y":y5, "label_id":"dis5_label", "text_id":"dis5_text"}
    }

    x6 := getSettingsValue("ModeLabel", "X6")
    y6 := getSettingsValue("ModeLabel", "Y6")
    if (x6 != "ERROR") {
        ret[6] := {"label_x":x6, "label_y":y6, "label_id":"dis6_label", "text_id":"dis6_text"}
    }

    return ret
}

;******************************************************************
; モード制御
;******************************************************************

;現在のモード
g_mode := _MODE.NORMAL

;【概要】モードを設定する
;【引数】mode: モード
setMode(mode) {
    global g_mode, _MODE, _DISPLAYS
    g_mode := mode

    ;ここを通過した後、スレッド割り込みを禁止する
    ;モードを素早くON -> OFFにすると全てをONにする前にOFFが先行して一部ラベルが表示されたままになるため
    Thread, Interrupt, -1, -1

    ; 下記の処理はスレッドセーフに扱う必要あり
    if (mode(_MODE.NORMAL)) {
        hideLine()
    } else {
        for i, d in _DISPLAYS {
            showModeLabel(mode.label, mode.color, d.label_id, d.text_id, d.label_x, d.label_y)
        }
    }
}

mode(mode) {
    global g_mode
    return (g_mode = mode)
}


;******************************************************************
; モードラベル初期設定
;******************************************************************

for i, d in _DISPLAYS {
    label_id := d.label_id
    text_id := d.text_id

    Gui, %label_id%:+AlwaysOnTop -Caption +LastFound
    Gui, %label_id%:+E0x00020020
    Gui, %label_id%:Font, S30
    GuiControl, %label_id%:, Mode, SEL

    Gui, %label_id%:Color, C000000
    Gui, %label_id%:Add, Text, w200 h50 X0 Y0 CFFFFFF Center v%text_id%,

    Winset, Transparent, %_TRANSPARENT%
    Winset, Region, R50-50 W200 H50 0-0
}


;******************************************************************
; モードラベル制御
;******************************************************************

;【概要】モードラベル表示を消去します (ラベルの破棄はされません)
;【引数】なし
;【戻値】なし
hideLine() {
    global _DISPLAYS
    for i, d in _DISPLAYS {
        id := d.label_id
        Gui, %id%:hide
    }
}


;【概要】モードラベルを表示します (ラベルの生成は行いません)
;【引数】mode:    モード名(表示用)
;        color:   ラベル背景色 (例: FF0000)
;        labelId: ラベルID
;        textId:  ラベル内に表示するテキストID
;        posX:    ラベルの表示x座標
;        posY:    ラベルの表示y座標
;【戻値】なし
showModeLabel(mode, color, labelId, textId, posX, posY) {
    Gui, %labelId%:Color, C%color%
    Gui, %labelId%:Hide ; 直前の残像が残るため
    GuiControl, %labelId%:+Cffffff, %textId%
    GuiControl, %labelId%:, %textId%, %mode%
    Gui, %labelId%:Show, X%posX% Y%posY% NA
}
