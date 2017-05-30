;******************************************************************
; マウスジェスチャー
;******************************************************************

;【いくつか注意事項】
;GetKeyStateは条件分岐する直前に取得すること。当たり前だけど状態が変わるから
;キーの定義は以下(大文字、小文字は区別されないが、可読性のため意識すること)
; 左クリック（ML) 右クリック(MR) 上(u) 左(l) 下(d) 右(r) 拡張ボタン1(XF) 拡張ボタン2(XS)

STimeoutTime := getSettingsValue("MouseGesture", TimeoutTime) ;タイムアウトの時間(未実装）
SCommandMovePicUp := getSettingsValue("MouseGesture", "MoveThresholdUp") ;１ジェスチャの動作閾値
SCommandMovePicDown := getSettingsValue("MouseGesture", "MoveThresholdDown")
SCommandMovePicLeft := getSettingsValue("MouseGesture", "MoveThresholdLeft")
SCommandMovePicRight := getSettingsValue("MouseGesture", "MoveThresholdRight")
SCommandTime := getSettingsValue("MouseGesture", "JudgeTime")          ;１ジェスチャの判定時間


;【概要】コマンドの追加
;【引数】commands: コマンド文字列
;		 command: 追加するコマンド
;		 lastCommands: 最後のコマンド
;
addCommand(byref commands, command, byref lastCommand)
{
	if (lastCommand != command) {
		commands := commands command
		lastCommand := command
	}
}

;【概要】コマンドの表示
;【引数】commands: コマンド文字列
;
msgCommands(byref commands)
{
	msgBox % commands
}

;【概要】コマンドを解析して処理を行う
;【引数】commands: コマンド文字列
;
doCommands(commands)
{
	do%commands%()
}


;------------------右クリックから始まる--------------------------------------
$RButton::

    commands := ""

    ;--------- コマンド --------------
    lastCommand := "init"
    addCommand(commands, "MR", lastCommand)                ;１つ目のコマンド挿入

    ;--------- 変数 --------------
    waitTime := 0                                ;待機時間
    timeOut := 0                                ;タイムアウトフラグ

    ;--------- 他のボタンが押されていたら終了 --------------
    GetKeyState,xf,XButton1,P
    GetKeyState,xs,XButton2,P
    GetKeyState,lb,LButton,P
    if(lb=="D" || xf=="D" || xs=="D" )
    {
        send {RButton}
        return
    }

    ;--------- コマンド取得ループ --------------
    LOOP
    {
        MouseGetPos beforeX, beforeY
        sleep, %SCommandTime%
        waitTime += %SCommandTime%
        MouseGetPos afterX, afterY

        GetKeyState,rb,RButton,P
        if(rb=="D")
        {
            if (timeOut = 0)
            { 
                ;--------- 縦と横の移動量を比較し、大きい方を採用 --------------
                verticalMovePic := Abs(afterY - beforeY)
                horizontalMovePic := Abs(afterX - beforeX)
                if (verticalMovePic > horizontalMovePic) {
                    if (afterY - beforeY < -1 * SCommandMovePicUp) {
                        addCommand(commands, "u", lastCommand)
                    } else if (afterY - beforeY > SCommandMovePicDown){
                        addCommand(commands, "d", lastCommand)
                    }
                } else {
                    if (afterX - beforeX < -1 * SCommandMovePicLeft){
                        addCommand(commands, "l", lastCommand)
                    } else if (afterX - beforeX > SCommandMovePicRight){
                        addCommand(commands, "r", lastCommand)
                    }
                }

                GetKeyState,lb,LButton,P
                if (lb=="D")
                {
                    addCommand(commands, "ML", lastCommand)
                }
            }
        }
        else
        {
            doCommands(commands)
            break
        }

    }

return


;------------------X2クリックから始まる--------------------------------------
$XButton2::

    commands := ""

    ;--------- コマンド --------------
    lastCommand := "init"
    addCommand(commands, "XS", lastCommand)                ;１つ目のコマンド挿入

    ;--------- 変数 --------------
    waitTime := 0                                ;待機時間
    timeOut := 0                                ;タイムアウトフラグ

    ;--------- 他のボタンが押されていたら終了 --------------
    GetKeyState,xf,XButton1,P
    GetKeyState,rb,RButton,P
    GetKeyState,lb,LButton,P
    if(lb=="D" || rb=="D" || xf=="D" )
    {
        send {XButton2}
        return
    }

    ;--------- コマンド取得ループ --------------
    LOOP
    {
        MouseGetPos beforeX, beforeY
        sleep, %SCommandTime%
        waitTime += %SCommandTime%
        MouseGetPos afterX, afterY

        GetKeyState,xs,XButton2,P
        if(xs=="D")
        {
            if (timeOut = 0) {
                ;--------- 縦と横の移動量を比較し、大きい方を採用 --------------
                verticalMovePic := Abs(afterY - beforeY)
                horizontalMovePic := Abs(afterX - beforeX)
                if (verticalMovePic > horizontalMovePic) {
                    if (afterY - beforeY < -1 * SCommandMovePicUp) {
                        addCommand(commands, "u", lastCommand)
                    } else if (afterY - beforeY > SCommandMovePicDown){
                        addCommand(commands, "d", lastCommand)
                    }
                } else {
                    if (afterX - beforeX < -1 * SCommandMovePicLeft){
                        addCommand(commands, "l", lastCommand)
                    } else if (afterX - beforeX > SCommandMovePicRight){
                        addCommand(commands, "r", lastCommand)
                    }
                }

                GetKeyState,lb,LButton,P
                if (lb=="D")
                {
                    addCommand(commands, "ML", lastCommand)
                }
            }
        }
        else
        {
            doCommands(commands)
            break
        }

    }

return
