;******************************************************************
; マウス制御処理
;******************************************************************

moveMouse(x, y) {
 MouseGetPos nowX, nowY
 SendMode Event
 MouseMove, nowX + x, nowY + y
 SendMode Input
}

