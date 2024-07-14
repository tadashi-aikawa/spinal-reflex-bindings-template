;******************************************************************
; マウス制御処理
;******************************************************************

moveMouse(x, y) {
 MouseGetPos nowX, nowY
 SendMode Event
 MouseMove, nowX + x, nowY + y
 SendMode Input
}

;----- マウスカーソルを左へ微少に移動 -----
moveMouseLeftMicro() {
 moveMouse(-getHorizontalMicro(), 0)
}
;----- マウスカーソルを左へ少し移動 -----
moveMouseLeftSmall() {
 moveMouse(-getHorizontalSmall(), 0)
}
;----- マウスカーソルを左へ移動 -----
moveMouseLeftMiddle() {
 moveMouse(-getHorizontalMiddle(), 0)
}
;----- マウスカーソルを左へ大きく移動 -----
moveMouseLeftLarge() {
 moveMouse(-getHorizontalLarge(), 0)
}
;----- マウスカーソルを左端へ移動 -----
moveMouseLeftScreen() {
 moveMouse(-getHorizontalScreen(), 0)
}

;----- マウスカーソルを下へ微少に移動 -----
moveMouseDownMicro() {
 moveMouse(0, getVerticalMicro())
}
;----- マウスカーソルを下へ少し移動 -----
moveMouseDownSmall() {
 moveMouse(0, getVerticalSmall())
}
;----- マウスカーソルを下へ移動 -----
moveMouseDownMiddle() {
 moveMouse(0, getVerticalMiddle())
}
;----- マウスカーソルを下へ大きく移動 -----
moveMouseDownLarge() {
 moveMouse(0, getVerticalLarge())
}
;----- マウスカーソルを下端へ移動 -----
moveMouseDownScreen() {
 moveMouse(0, getVerticalScreen())
}

;----- マウスカーソルを右へ微少に移動 -----
moveMouseRightMicro() {
 moveMouse(getHorizontalMicro(), 0)
}
;----- マウスカーソルを右へ少し移動 -----
moveMouseRightSmall() {
 moveMouse(getHorizontalSmall(), 0)
}
;----- マウスカーソルを右へ移動 -----
moveMouseRightMiddle() {
 moveMouse(getHorizontalMiddle(), 0)
}
;----- マウスカーソルを右へ大きく移動 -----
moveMouseRightLarge() {
 moveMouse(getHorizontalLarge(), 0)
}
;----- マウスカーソルを右端へ移動 -----
moveMouseRightScreen() {
 moveMouse(getHorizontalScreen(), 0)
}

;----- マウスカーソルを上へ微少に移動 -----
moveMouseUpMicro() {
 moveMouse(0, -getVerticalMicro())
}
;----- マウスカーソルを上へ少し移動 -----
moveMouseUpSmall() {
 moveMouse(0, -getVerticalSmall())
}
;----- マウスカーソルを上へ移動 -----
moveMouseUpMiddle() {
 moveMouse(0, -getVerticalMiddle())
}
;----- マウスカーソルを上へ大きく移動 -----
moveMouseUpLarge() {
 moveMouse(0, -getVerticalLarge())
}
;----- マウスカーソルを上端へ移動 -----
moveMouseUpScreen() {
 moveMouse(0, -getVerticalScreen())
}

scrollUpSmall() {
	sendInput {WheelUp}
}

scrollUpMiddle() {
	sendInput {WheelUp 3}
}

scrollUpLarge() {
	sendInput {WheelUp 10}
}

scrollDownSmall() {
	sendInput {WheelDown}
}

scrollDownMiddle() {
	sendInput {WheelDown 3}
}

scrollDownLarge() {
	sendInput {WheelDown 10}
}


!---------------------水平方向------------------------------
getHorizontalMicro()
{
	ret := getSettingsValue("MouseSettings", "MoveHorizontalMicro")
	return ret
}

getHorizontalSmall()
{
	ret := getSettingsValue("MouseSettings", "MoveHorizontalSmall")
	return ret
}

getHorizontalMiddle()
{
	ret := getSettingsValue("MouseSettings", "MoveHorizontalMiddle")
	return ret
}

getHorizontalLarge()
{
	ret := getSettingsValue("MouseSettings", "MoveHorizontalLarge")
	return ret
}

getHorizontalScreen()
{
	ret := getSettingsValue("MouseSettings", "MoveHorizontalScreen")
	return ret
}

!---------------------垂直方向------------------------------
getVerticalMicro()
{
	ret := getSettingsValue("MouseSettings", "MoveVerticalMicro")
	return ret
}

getVerticalSmall()
{
	ret := getSettingsValue("MouseSettings", "MoveVerticalSmall")
	return ret
}

getVerticalMiddle()
{
	ret := getSettingsValue("MouseSettings", "MoveVerticalMiddle")
	return ret
}

getVerticalLarge()
{
	ret := getSettingsValue("MouseSettings", "MoveVerticalLarge")
	return ret
}

getVerticalScreen()
{
	ret := getSettingsValue("MouseSettings", "MoveVerticalScreen")
	return ret
}
