;[NORMAL ]: aキー(コンビネーションから場合は^）
;[EDIT   ]: 行頭へ移動
;[RANGE  ]: 行頭に選択範囲を移動
;[MOUSE  ]: ポインタを１画面分右に移動
;[SPECIAL]: アクティブウィンドウを左下に最大化して移動する
$a::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send {home}
        } else if (mode(_MODE.RANGE)) {
            send +{home}
        } else if (mode(_MODE.MOUSE)) {
            moveMouseLeftScreen()
        } else if (mode(_MODE.SPECIAL)) {
            MoveWindow("LeftDown")
        }
    } else {
        if (isSecondKey()) {
            send {^}
        } else {
            send a
        }
    }
return

;[All Mode]: Alt+a (Slack: Mentions & reactions)
$!a::
    if (isActiveProcess("slack")) {
        send ^+m
    } else {
        send !a
    }
return

;[NORMAL ]: アクティブウィンドウを常時最前面表示にする
;[EDIT   ]: アクティブウィンドウを常時最前面表示にする
;[RANGE  ]: アクティブウィンドウを常時最前面表示にする
;[MOUSE  ]: アクティブウィンドウを常時最前面表示にする
;[SPECIAL]: アクティブウィンドウを常時最前面表示にする
$#a::
    WinSet, Topmost, Toggle, A
return

;[NORMAL ]: bキー
;[EDIT   ]: 1単語左へ移動する
;[RANGE  ]: 選択範囲を1単語左に移動
;[MOUSE  ]: bキー
;[SPECIAL]: bキー
$b::
    if (mode(_MODE.NORMAL)) {
        send b
    } else if (mode(_MODE.EDIT)) {
        send ^{Left}
    } else if (mode(_MODE.RANGE)) {
        send ^+{Left}
    } else if (mode(_MODE.MOUSE)) {
        send b
    } else if (mode(_MODE.SPECIAL)) {
        send b
    }
return

;[NORMAL ]: cキー (コンビネーションの場合はコードブロック）
;[EDIT   ]: コピーしてモードをVirtual->NORMALに変更
;[RANGE  ]: コピーしてモードをVirtual->NORMALに変更
;[MOUSE  ]:
;[SPECIAL]: コピーしてモードをVirtual->NORMALに変更
;[SNIPPET]: :calendar:
$c::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.MOUSE)) {
        } else if (mode(_MODE.SNIPPET)) {
            send :calendar:
        } else {
            setMode(_MODE.EDIT)
            if (isTerminal()) {
                send ^{Ins}
            } else {
                send ^c
            }
        }
    } else {
        if (isSecondKey()) {
            send {`` 3}
        } else {
            send c
        }
    }
return

;[NORMAL ]: Shift + cキー (コンビネーションの場合はGoogleカレンダーを表示する)
;[EDIT   ]: Shift + cキー (Dynalist: チェックリスト切り替えトグル)
;[RANGE  ]: Shift + cキー
;[MOUSE  ]: Shift + cキー
;[SPECIAL]: Shift + cキー
$+c::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            ActivateWindowByTitle("カレンダー")
        } else {
            send +c
        }
    } else if (mode(_MODE.EDIT)) {
        if (isActiveProcess("dynalist")) {
            send ^+c
        } else {
            send +c
        }
    } else if (mode(_MODE.RANGE)) {
        send +c
    } else if (mode(_MODE.MOUSE)) {
        send +c
    } else if (mode(_MODE.SPECIAL)) {
        send +c
    }
return

;[NORMAL ]: dキー (コンビネーションの場合は#）
;[EDIT   ]: BSキー
;[RANGE  ]: BSキー
;[MOUSE  ]: 中央下のエリアにフォーカスを移してNORMALモードに
;[SPECIAL]: アクティブウィンドウを右下に最大化して移動する
$d::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            send {#}
        } else {
            send d
        }
    } else if (mode(_MODE.EDIT)) {
        send {BS}
    } else if (mode(_MODE.RANGE)) {
        send {BS}
    } else if (mode(_MODE.MOUSE)) {
        ActivateWindow("CenterDown")
        setMode(_MODE.NORMAL)
        FlashWindow()
    } else if (mode(_MODE.SPECIAL)) {
        MoveWindow("RightDown")
    }
return

;[NORMAL ]: Ctrl + dキー (Dynalist: トピック削除)
;[EDIT   ]: Ctrl + dキー (Dynalist: トピック削除)
;[RANGE  ]: Ctrl + dキー
;[MOUSE  ]: Ctrl + dキー
;[SPECIAL]: Ctrl + dキー
$^d::
    if (mode(_MODE.NORMAL)) {
        if (isActiveProcess("dynalist")) {
            send ^+{Del}
        } else {
            send ^d
        }
    } else if (mode(_MODE.EDIT)) {
        if (isActiveProcess("dynalist")) {
            send ^+{Del}
        } else {
            send ^d
        }
    } else if (mode(_MODE.RANGE)) {
        send ^d
    } else if (mode(_MODE.MOUSE)) {
        send ^d
    } else if (mode(_MODE.SPECIAL)) {
        send ^d
    }
return

;[NORMAL ]: Shift + dキー
;[EDIT   ]: Enter
;[RANGE  ]: Enter
;[MOUSE  ]: Enter
;[SPECIAL]: Enter
$+d::
    if (mode(_MODE.NORMAL)) {
        send +d
    } else if (mode(_MODE.EDIT)) {
        send {Enter}
    } else if (mode(_MODE.RANGE)) {
        send {Enter}
    } else if (mode(_MODE.MOUSE)) {
        send {Enter}
    } else if (mode(_MODE.SPECIAL)) {
        send {Enter}
    }
return

;[NORMAL ]: Alt + D (Slack: Threads)
;[EDIT   ]: デバッグを開始してデバッグモードに移行
;[RANGE  ]: デバッグを開始してデバッグモードに移行
;[MOUSE  ]: デバッグを開始してデバッグモードに移行
;[SPECIAL]: デバッグを開始してデバッグモードに移行
;[DEBUG  ]: デバッグを開始してデバッグモードに移行
$!d::
    if (mode(_MODE.NORMAL)) {
        if (isActiveProcess("slack")) {
            send ^+t
        } else {
            send !d
        }
    } else {
        send !d
        setMode(_MODE.DEBUG)
    }
return

;[NORMAL ]: eキー (コンビネーションキーの場合は=)
;[EDIT   ]: 1つ戻る
;[RANGE  ]: 1つ戻る
;[MOUSE  ]: 中央上のエリアにフォーカスを移してNORMALモードに
;[SPECIAL]: アクティブウィンドウを右上に最大化して移動する
;[SNIPPET]: :evergreen_tree::
;[DEBUG  ]: 評価を開く
$e::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.SPECIAL)) {
            MoveWindow("RightUp")
        } else if (mode(_MODE.MOUSE)) {
            ActivateWindow("CenterUp")
            setMode(_MODE.NORMAL)
            FlashWindow()
        } else if (mode(_MODE.SNIPPET)) {
            send :evergreen_tree:
        } else if (mode(_MODE.DEBUG)) {
            send ^u
        } else {
            send !{left}
        }
    } else {
        if (isSecondKey()) {
            send {space}={space}
        } else {
            send e
        }
    }
return

;[NORMAL ]: Ctrl + eキー
;[EDIT   ]: 1つ進む
;[RANGE  ]: 1つ進む
;[MOUSE  ]: 1つ進む
;[SPECIAL]: 1つ進む
$^e::
    if (!mode(_MODE.NORMAL)) {
        send !{right}
    } else {
        send ^e
    }
return

;[NORMAL ]: Shift + eキー (コンビネーションの場合はTablacus Explorerを開く)
;[EDIT   ]: Shift + eキー (コンビネーションの場合はTablacus Explorerを開く)
;[RANGE  ]: Shift + eキー (コンビネーションの場合はTablacus Explorerを開く)
;[MOUSE  ]: Shift + eキー (コンビネーションの場合はTablacus Explorerを開く)
;[SPECIAL]: Shift + eキー (コンビネーションの場合はTablacus Explorerを開く)
$+e::
    if (isSecondKey()) {
        ActivateWindowByTool("tablacus")
    } else {
        send +e
    }
return


;[NORMAL ]: fキー(コンビネーションの場合は$）
;[EDIT   ]: 一番上に移動
;[RANGE  ]: 選択範囲を一番上に移動
;[MOUSE  ]: 右下のエリアにフォーカスを移してNORMALモードに
;[SPECIAL]: 縦にフルスクリーン
;[DEBUG  ]: ステップオーバー (F10)
$f::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            send {$}
        } else {
            send f
        }
    } else if (mode(_MODE.EDIT)) {
        send ^{Home}
    } else if (mode(_MODE.RANGE)) {
        send +^{Home}
    } else if (mode(_MODE.MOUSE)) {
        ActivateWindow("RightDown")
        setMode(_Mode.NORMAL)
        FlashWindow()
    } else if (mode(_MODE.SPECIAL)) {
        send #+{UP}
    } else if (mode(_MODE.DEBUG)) {
        send {F10}
    }
return

;[NORMAL ]: 検索
;[EDIT   ]: 検索
;[RANGE  ]: 検索
;[MOUSE  ]: 検索
;[SPECIAL]: 検索
$^f::
    if (isActive("console")) {
        send !{space}ef
    } else {
        send ^f
    }
return

;[NORMAL ]: Shift + fキー
;[EDIT   ]: 一番下に移動
;[RANGE  ]: 選択範囲を一番下に移動
;[MOUSE  ]: Shift + fキー
;[SPECIAL]: Shift + fキー
$+f::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send ^{End}
        } else if (mode(_MODE.RANGE)) {
            send +^{End}
        } else if (mode(_MODE.MOUSE)) {
            send +f
        } else if (mode(_MODE.SPECIAL)) {
            send +f
        }
    } else {
        send +f
    }
return

;[NORMAL ]: gキー (コンビネーションの場合は &)
;[EDIT   ]: RANGEモードに切り替え
;[RANGE  ]: EDITモードに切り替え
;[MOUSE  ]: RANGEモードに切り替え
;[SPECIAL]: G+NORMALモードに切り替え(Vimジャンプ用)
;[DEBUG  ]: ステップイン (F11)
$g::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.RANGE)) {
            setMode(_MODE.EDIT)
        } else if (mode(_MODE.SPECIAL)) {
            send G
            setMode(_MODE.NORMAL)
        } else if (mode(_MODE.DEBUG)) {
            send {F11}
        } else {
            setMode(_MODE.RANGE)
        }
    } else {
        if (isSecondKey()) {
            send &
        } else {
            send g
        }
    }
return

;[NORMAL ]: h (;からのコンビネーションの場合は~)
;[EDIT   ]: 左に移動
;[RANGE  ]: 選択範囲を左に移動
;[MOUSE  ]: マウスポインタを左に微かに移動
;[SPECIAL]: hキー
;[DEBUG  ]: ステップアウト (SHIFT + F11)
$h::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            send ~
        } else {
            send h
        }
    } else if (mode(_MODE.EDIT)) {
        send {Left}
    } else if (mode(_MODE.RANGE)) {
        send +{Left}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseLeftMicro()
    } else if (mode(_MODE.SPECIAL)) {
        send h
    } else if (mode(_MODE.DEBUG)) {
        send +{F11}
    }
return

;[NORMAL ]: Ctrl + H
;[EDIT   ]: 5つ左に移動
;[RANGE  ]: 選択範囲を5つ左に移動
;[MOUSE  ]: マウスポインタを左に移動
;[SPECIAL]: Ctrl + H
$^h::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            sendInput {Left 5}
        } else if (mode(_MODE.RANGE)) {
            sendInput +{Left 5}
        } else if (mode(_MODE.MOUSE)) {
            moveMouseLeftMiddle()
        } else if (mode(_MODE.SPECIAL)) {
            send ^h
        }
    } else {
        send ^h
    }
return

;[NORMAL ]: Shift + hキー
;[EDIT   ]: 15つ左に移動
;[RANGE  ]: 選択範囲を15つ左に移動
;[MOUSE  ]: マウスポインタを大きく左に移動
;[SPECIAL]: Shift + hキー
$+h::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            sendInput {Left 15}
        } else if (mode(_MODE.RANGE)) {
            sendInput +{Left 15}
        } else if (mode(_MODE.MOUSE)) {
            moveMouseLeftLarge()
        } else if (mode(_MODE.SPECIAL)) {
            send +h
        }
    } else {
        send +h
    }
return

;[NORMAL ]: Alt + hキー (Dynalist: トピックを左に移動, cmder: タブを左に移動, chrome: 左のタブに移動)
;[EDIT   ]: Alt + 左キー (Dynalist: トピックを左に移動, cmder: タブを左に移動, chrome: 左のタブに移動)
;[RANGE  ]: Alt + 左キー (Dynalist: トピックを左に移動, cmder: タブを左に移動, chrome: 左のタブに移動)
;[MOUSE  ]: マウスポインタを大きく左に移動
;[SPECIAL]: Alt + hキー
$!h::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            if (isActiveProcess("dynalist")) {
                send +{TAB}
            } else if (isActive("cmder")) {
                send ^+{TAB}
            } else if (isActiveProcess("chrome")) {
                send ^+{TAB}
            } else {
                send !{Left}
            }
        } else if (mode(_MODE.RANGE)) {
            if (isActiveProcess("dynalist")) {
                send +{TAB}
            } else if (isActive("cmder")) {
                send ^+{TAB}
            } else if (isActiveProcess("chrome")) {
                send ^+{TAB}
            } else {
                send !{Left}
            }
        } else if (mode(_MODE.MOUSE)) {
            moveMouseLeftLarge()
        } else if (mode(_MODE.SPECIAL)) {
            send !h
        }
    } else {
        if (isActive("cmder")) {
            send ^+{TAB}
        } else if (isActiveProcess("chrome")) {
            send ^+{TAB}
        } else {
            send !h
        }
    }
return

;[NORMAL ]: iキー (コンビネーションの場合は{}）
;[EDIT   ]: MOUSEモードに変更
;[RANGE  ]: MOUSEモードに変更
;[MOUSE  ]: NORMALモードに変更
;[SPECIAL]: 8キー
$i::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            send {{}{}}
            Sleep, 50
            send {Left}
        } else {
            send i
        }
    } else if (mode(_MODE.EDIT)) {
        setMode(_MODE.MOUSE)
    } else if (mode(_MODE.RANGE)) {
        setMode(_MODE.MOUSE)
    } else if (mode(_MODE.MOUSE)) {
        setMode(_MODE.NORMAL)
    } else if (mode(_MODE.SPECIAL)) {
        if (isTerminal() || isActive("ubuntu")) {
            send 8
        } else {
            send {Numpad8}
        }
    }
return

;[NORMAL ]: Ctrl + iキー (コンビネーションの場合 →<Space>{}←)
;[EDIT   ]: Ctrl + iキー
;[RANGE  ]: Ctrl + iキー
;[MOUSE  ]: Ctrl + iキー
;[SPECIAL]: 8キー + Enter
$^i::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            send {Right}{space}
            send {{}{}}
            Sleep, 50
            send {Left}
        } else {
            Send ^i
        }
    } else if (mode(_MODE.EDIT)) {
        Send ^i
    } else if (mode(_MODE.RANGE)) {
        Send ^i
    } else if (mode(_MODE.MOUSE)) {
        Send ^i
    } else if (mode(_MODE.SPECIAL)) {
        send {Numpad8}{Enter}
    }
return

;[NORMAL ]: shift + iキー
;[EDIT   ]: 上に1ページ移動
;[RANGE  ]: 上に1ページ選択範囲を移動
;[MOUSE  ]: マウスポインタを上に大きく移動
;[SPECIAL]: ↑キー
$+i::
    if (mode(_MODE.NORMAL)) {
        Send +i
    } else if (mode(_MODE.EDIT)) {
        send {PgUp}
    } else if (mode(_MODE.RANGE)) {
        send +{PgUp}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseUpLarge()
    } else if (mode(_MODE.SPECIAL)) {
        Send ↑
    }
return

;[NORMAL ]: Alt + iキー
;[EDIT   ]: Alt + iキー
;[RANGE  ]: Alt + iキー
;[MOUSE  ]: マウスポインタを上に少し移動
;[SPECIAL]: Alt + iキー
$!i::
    if (mode(_MODE.NORMAL)) {
        Send !i
    } else if (mode(_MODE.EDIT)) {
        Send !i
    } else if (mode(_MODE.RANGE)) {
        Send !i
    } else if (mode(_MODE.MOUSE)) {
        moveMouseUpSmall()
    } else if (mode(_MODE.SPECIAL)) {
        Send !i
    }
return

;[NORMAL ]: jキー (コンビネーションの場合は''）
;[EDIT   ]: 下に移動
;[RANGE  ]: 選択範囲を下に移動
;[MOUSE  ]: マウスポインタを下に微かに移動
;[SPECIAL]: 4キー
;[DEBUG  ]: ステップアウト (SHIFT + F11)
$j::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            send {' 2}
            Sleep 50
            send {Left}
        } else {
            send j
        }
    } else if (mode(_MODE.EDIT)) {
        send {Down}
    } else if (mode(_MODE.RANGE)) {
        send +{Down}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseDownMicro()
    } else if (mode(_MODE.SPECIAL)) {
        if (isTerminal() || isActive("ubuntu")) {
            send 4
        } else {
            send {Numpad4}
        }
    } else if (mode(_MODE.DEBUG)) {
        send +{F11}
    }
return

;[NORMAL ]: Ctrl + jキー
;[EDIT   ]: 下に5つ移動
;[RANGE  ]: 選択範囲を下に5つ移動
;[MOUSE  ]: マウスポインタを下に移動
;[SPECIAL]: 4キー + Enter
$^j::
    if (mode(_MODE.NORMAL)) {
        send ^j
    } else if (mode(_MODE.EDIT)) {
        if (isActive("poderose")) {
            send {ESC}b
        } else {
            sendInput {Down 5}
        }
    } else if (mode(_MODE.RANGE)) {
        sendInput +{Down 5}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseDownMiddle()
    } else if (mode(_MODE.SPECIAL)) {
        send {Numpad4}{Enter}
    }
return

;[NORMAL ]: Shift + jキー
;[EDIT   ]: 下に1ページ移動
;[RANGE  ]: 選択範囲を下に1ページ移動
;[MOUSE  ]: マウスポインタを下に大きく移動
;[SPECIAL]: 左キー
$+j::
    if (mode(_MODE.NORMAL)) {
        send +j
    } else if (mode(_MODE.EDIT)) {
        send {PgDn}
    } else if (mode(_MODE.RANGE)) {
        send +{PgDn}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseDownLarge()
    } else if (mode(_MODE.SPECIAL)) {
        send ←
    }
return

;[NORMAL ]: Alt + jキー
;[EDIT   ]: Alt + jキー (Dynalist: トピックを下に移動)
;[RANGE  ]: Alt + jキー (Dynalist: トピックを下に移動)
;[MOUSE  ]: マウスポインタを下に少し移動
;[SPECIAL]: Alt + jキー
$!j::
    if (mode(_MODE.NORMAL)) {
        send !j
    } else if (mode(_MODE.EDIT)) {
        if (isActiveProcess("dynalist")) {
            send ^{Down}
        } else {
            send !{Down}
        }
    } else if (mode(_MODE.RANGE)) {
        if (isActiveProcess("dynalist")) {
            send ^{Down}
        } else {
            send !{Down}
        }
    } else if (mode(_MODE.MOUSE)) {
        moveMouseDownSmall()
    } else if (mode(_MODE.SPECIAL)) {
        send !j
    }
return

;[NORMAL ]: kキー (;からのコンビネーションの場合は``)
;[EDIT   ]: 上に移動
;[RANGE  ]: 上に選択範囲を移動
;[MOUSE  ]: マウスポインタを上に微かに移動
;[SPECIAL]: 5キー
;[DEBUG  ]: ステップオーバー (F10)
$k::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            send ````
            Sleep 50
            send {left}
        } else {
            send k
        }
    } else if (mode(_MODE.EDIT)) {
        send {Up}
    } else if (mode(_MODE.RANGE)) {
        send +{Up}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseUpMicro()
    } else if (mode(_MODE.SPECIAL)) {
        if (isTerminal() || isActive("ubuntu")) {
            send 5
        } else {
            send {Numpad5}
        }
    } else if (mode(_MODE.DEBUG)) {
        send {F10}
    }
return

;[NORMAL ]: Ctrl + kキー
;[EDIT   ]: 上に5つ移動
;[RANGE  ]: 選択範囲を上に5つ移動
;[MOUSE  ]: マウスポインタを上に移動
;[SPECIAL]: 5キー + Enter
$^k::
    if (mode(_MODE.NORMAL)) {
        send ^k
    } else if (mode(_MODE.EDIT)) {
        sendInput {Up 5}
    } else if (mode(_MODE.RANGE)) {
        sendInput +{Up 5}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseUpMiddle()
    } else if (mode(_MODE.SPECIAL)) {
        send {Numpad5}{Enter}
    }
return

;[NORMAL ]: Shift + kキー
;[EDIT   ]: 上に1ページ移動
;[RANGE  ]: 選択範囲を上に1ページ移動
;[MOUSE  ]: マウスポインタを上に大きく移動
;[SPECIAL]: ↓キー
$+k::
    if (mode(_MODE.NORMAL)) {
        send +k
    } else if (mode(_MODE.EDIT)) {
        send {PgUp}
    } else if (mode(_MODE.RANGE)) {
        send +{PgUp}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseUpLarge()
    } else if (mode(_MODE.SPECIAL)) {
        send ↓
    }
return

;[NORMAL ]: Alt + kキー
;[EDIT   ]: Alt + 上キー (Dynalist: トピックを上に移動)
;[RANGE  ]: Alt + 上キー (Dynalist: トピックを上に移動)
;[MOUSE  ]: マウスポインタを上に少し移動
;[SPECIAL]: Alt + kキー
$!k::
    if (mode(_MODE.NORMAL)) {
        send !k
    } else if (mode(_MODE.EDIT)) {
        if (isActiveProcess("dynalist")) {
            send ^{Up}
        } else {
            send !{Up}
        }
    } else if (mode(_MODE.RANGE)) {
        if (isActiveProcess("dynalist")) {
            send ^{Up}
        } else {
            send !{Up}
        }
    } else if (mode(_MODE.MOUSE)) {
        moveMouseUpSmall()
    } else if (mode(_MODE.SPECIAL)) {
        send !k
    }
return

;[NORMAL ]: lキー (コンビネーションキーの場合は_)
;[EDIT   ]: 右に移動
;[RANGE  ]: 選択範囲を右に移動
;[MOUSE  ]: マウスポインタを右に微かに移動
;[SPECIAL]: 6キー
;[SNIPPET]: :fork_and_knife:
;[DEBUG  ]: ステップイン (F11)
$l::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            imeOn := getIME()
            setIME(false)
            send _
            setIME(imeOn)
        } else {
            send l
        }
    } else if (mode(_MODE.EDIT)) {
        send {right}
    } else if (mode(_MODE.RANGE)) {
        send +{right}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseRightMicro()
    } else if (mode(_MODE.SPECIAL)) {
        if (isTerminal() || isActive("ubuntu")) {
            send 6
        } else {
            send {Numpad6}
        }
    } else if (mode(_MODE.SNIPPET)) {
        send :fork_and_knife:
    } else if (mode(_MODE.DEBUG)) {
        send {F11}
    }
return

;[NORMAL ]: Ctrl+lキー
;[EDIT   ]: 右に5つ移動
;[RANGE  ]: 選択範囲を右に5つ移動
;[MOUSE  ]: マウスポインタを右にそこそこ移動
;[SPECIAL]: 6キー + Enter
$^l::
    if (mode(_MODE.NORMAL)) {
        send ^l
    } else if (mode(_MODE.EDIT)) {
        sendInput {Right 5}
    } else if (mode(_MODE.RANGE)) {
        sendInput +{Right 5}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseRightMiddle()
    } else if (mode(_MODE.SPECIAL)) {
        send {Numpad6}{Enter}
    }
return

;[NORMAL ]: Shift + lキー
;[EDIT   ]: 右に15つ移動
;[RANGE  ]: 選択範囲を右に15つ移動
;[MOUSE  ]: マウスポインタを右に大きく移動
;[SPECIAL]: Shift + lキー
$+l::
    if (mode(_MODE.NORMAL)) {
        send +l
    } else if (mode(_MODE.EDIT)) {
        sendInput {Right 15}
    } else if (mode(_MODE.RANGE)) {
        sendInput +{Right 15}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseRightLarge()
    } else if (mode(_MODE.SPECIAL)) {
        send +l
    }
return

;[NORMAL ]: Alt + lキー  (Dynalist: トピックを右に移動, cmder: タブを右に移動, chrome: 右のタブへ移動)
;[EDIT   ]: Alt + lキー (Dynalist: トピックを右に移動, cmder: タブを右に移動, chrome: 右のタブへ移動)
;[RANGE  ]: Alt + lキー (Dynalist: トピックを右に移動, cmder: タブを右に移動, chrome: 右のタブへ移動)
;[MOUSE  ]: マウスポインタ右に少し移動
;[SPECIAL]: Alt + lキー
$!l::
    if (mode(_MODE.NORMAL)) {
        if (isActive("cmder")) {
            send ^{TAB}
        } else if (isActiveProcess("chrome")) {
            send ^{TAB}
        } else {
            send !l
        }
    } else if (mode(_MODE.EDIT)) {
        if (isActiveProcess("dynalist")) {
            send {TAB}
        } else if (isActive("cmder")) {
            send ^{TAB}
        } else if (isActiveProcess("chrome")) {
            send ^{TAB}
        } else {
            send !l
        }
    } else if (mode(_MODE.RANGE)) {
        if (isActiveProcess("dynalist")) {
            send {TAB}
        } else if (isActive("cmder")) {
            send ^{TAB}
        } else if (isActiveProcess("chrome")) {
            send ^{TAB}
        } else {
            send !l
        }
    } else if (mode(_MODE.MOUSE)) {
        moveMouseRightSmall()
    } else if (mode(_MODE.SPECIAL)) {
        send !l
    }
return

;[NORMAL ]: mキー (コンビネーションキーの場合はダブルコーテーション)
;[EDIT   ]: 日本語入力OFF + モードをNORMALに変更
;[RANGE  ]: 日本語入力OFF + モードをNORMALに変更
;[MOUSE  ]: 左ドラッグ
;[SPECIAL]: 1キー
;[SNIPPET]: :fork_and_knife:
$m::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            setIME(false)
            setMode(_MODE.NORMAL)
        } else if (mode(_MODE.RANGE)) {
            setIME(false)
            setMode(_MODE.NORMAL)
        } else if (mode(_MODE.MOUSE)) {
            send {LButton Down}
        } else if (mode(_MODE.SPECIAL)) {
            if (isTerminal() || isActive("ubuntu")) {
                send 1
            } else {
                send {Numpad1}
            }
        } else if (mode(_MODE.SNIPPET)) {
            send :fork_and_knife:
            }
    } else {
        if (isSecondKey()) {
            send "
        } else {
            send m
        }
    }
return

;[NORMAL ]: Ctrl+M
;[EDIT   ]: Ctrl+M
;[RANGE  ]: Ctrl+M
;[MOUSE  ]: Ctrl+M
;[SPECIAL]: 1キー
$^m::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.SPECIAL)) {
            send {Numpad1}{Enter}
        } else {
            send ^m
        }
    } else {
        send ^m
    }
return

;[NORMAL ]: Shift + mキー (コンビネーションの場合はmimizou-roomをVSCodeで表示する)
;[EDIT   ]: shift + mキー
;[RANGE  ]: shift + mキー
;[MOUSE  ]: shift + mキー
;[SPECIAL]: shift + mキー
$+m::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send +m
        } else if (mode(_MODE.RANGE)) {
            send +m
        } else if (mode(_MODE.MOUSE)) {
            send +m
        } else if (mode(_MODE.SPECIAL)) {
            send +m
        }
    } else {
        if (isSecondKey()) {
            ActivateWindowByTitle("[mimizou-room]")
        } else {
            send +m
        }
    }
return

;[NORMAL ]: Nキー (コンビネーションの場合は =>)
;[EDIT   ]: F3キー相当 (Dynalist: Zoom in) (Chrome: 新しいタブを開く + NORMALモード)
;[RANGE  ]: F3キー相当 (Dynalist: Zoom in) (Chrome: 新しいタブを開く + NORMALモード)
;[MOUSE  ]: F3キー相当 (Dynalist: Zoom in) (Chrome: 新しいタブを開く + NORMALモード)
;[SPECIAL]: F3キー相当 (Dynalist: Zoom in) (Chrome: 新しいタブを開く + NORMALモード)
$n::
    if (!mode(_MODE.NORMAL)) {
        if (isActiveProcess("dynalist")) {
            send ^]
        } else if (isActiveProcess("chrome")) {
            send ^t
            setMode(_MODE.NORMAL)
        } else {
            send {F3}
        }
    } else {
        if (isSecondKey()) {
            send {space}=>{space}
        } else {
            send n
        }
    }
return

;[NORMAL ]: 新規ウィンドウ
;[EDIT   ]: Ctrl+Shift+F3 (実装のプレビュー) (Dynalist: Zoom out)
;[RANGE  ]: Ctrl+Shift+F3 (実装のプレビュー)
;[MOUSE  ]: Ctrl+Shift+F3 (実装のプレビュー)
;[SPECIAL]: Ctrl+Shift+F3 (実装のプレビュー)
$^n::
    if (!mode(_MODE.NORMAL)) {
        if (isActiveProcess("dynalist")) {
            send ^[
        } else {
            send ^+{F3}
        }
    } else {
        send ^n
    }
return

;[NORMAL ]: Shift + Nキー
;[EDIT   ]: Shift + F3キー相当
;[RANGE  ]: Shift + F3キー相当
;[MOUSE  ]: Shift + F3キー相当
;[SPECIAL]: Shift + F3キー相当
$+n::
    if (!mode(_MODE.NORMAL)) {
        send +{F3}
    } else {
        send +n
    }
return

;----- [N]Delete [R]Delete(範囲指定終了) [M]右クリック押下 [M]ホイールダウン-----
;[NORMAL ]: oキー(コンビネーションキーの場合は|)
;[EDIT   ]: DELキー
;[RANGE  ]: DELキー(処理後に範囲指定を終了する)
;[MOUSE  ]: マウスホイールを少し下に動かす
;[SPECIAL]: 9キー
$o::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send {del}
        } else if (mode(_MODE.RANGE)) {
            send {del}
        } else if (mode(_MODE.MOUSE)) {
            scrollDownSmall()
        } else if (mode(_MODE.SPECIAL)) {
            if (isTerminal() || isActive("ubuntu")) {
                send 9
            } else {
                send {Numpad9}
            }
        }
    } else {
        if (isSecondKey()) {
            imeOn := getIME()
            setIME(false)
            send |
            setIME(imeOn)
        } else {
            send o
        }
    }
return

;[NORMAL ]: Ctrl + O
;[EDIT   ]: 単語単位でDelete
;[RANGE  ]: 単語単位でDelete
;[MOUSE  ]: マウスホイールを下に動かす
;[SPECIAL]: Delete
$^o::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send ^{del}
        } else if (mode(_MODE.RANGE)) {
            send ^{del}
            setMode(_MODE.EDIT)
        } else if (mode(_MODE.MOUSE)) {
            scrollDownMiddle()
        } else if (mode(_MODE.SPECIAL)) {
            send {Numpad9}{Enter}
        }
    } else {
        send ^o
    }
return

;[NORMAL ]: Shift + O
;[EDIT   ]: 5個文字をDeleteする
;[RANGE  ]: Shift + O
;[MOUSE  ]: マウスホイールを大きく下に動かす
;[SPECIAL]: Shift + O
$+o::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            if (isTerminal() || isActive("intellij") || isActive("ubuntu") || isActive("vscode")) {
                sendInput {DEL 5}
            } else {
                sendInput +{RIGHT 5}{DEL}
            }
        } else if (mode(_MODE.RANGE)) {
            send +o
        } else if (mode(_MODE.MOUSE)) {
            scrollDownLarge()
        } else if (mode(_MODE.SPECIAL)) {
            send +o
        }
    } else {
        send +o
    }
return

;[NORMAL ]: pキー (コンビネーションキーの場合は%)
;[EDIT   ]: コマンドパレット(Ctrl + Shift + pキー => NORMALモード)
;[RANGE  ]: pキ－
;[MOUSE  ]: pキ－
;[SPECIAL]: ハイフン
$p::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send ^+p
            setMode(_MODE.NORMAL)
        } else if (mode(_MODE.SPECIAL)) {
            send -
        } else {
            send p
        }
    } else {
        if (isSecondKey()) {
            send `%
        } else {
            send p
        }
    }
return

;[NORMAL ]: Shift+pキー
;[EDIT   ]: ahkスクリプトのリロード
;[RANGE  ]: ahkスクリプトのリロード
;[MOUSE  ]: ahkスクリプトのリロード
;[SPECIAL]: ahkスクリプトのリロード
$+p::
    if (!mode(_MODE.NORMAL)) {
        Reload
    } else {
        send +p
    }
return

;[NORMAL ]: qキー(コンビネーションから場合はCtrl + Shift + q)
;[EDIT   ]: Ctrl + Shift + q (Chrome/Tablacus: タブを閉じる)
;[RANGE  ]: Ctrl + Shift + q (Chrome/Tablacus: タブを閉じる)
;[MOUSE  ]: Ctrl + Shift + q (Chrome/Tablacus: タブを閉じる)
;[SPECIAL]: Windowを左上に移動
$q::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.SPECIAL)) {
            MoveWindow("LeftUp")
        } else {
            if (isActiveProcess("chrome") || isActive("tablacus")) {
                send ^w
            } else {
                send ^+q
            }
        }
    } else {
        if (isSecondKey()) {
            send ^+q
        } else {
            send q
        }
    }
return

;[NORMAL ]: ウィンドウを閉じる
;[EDIT   ]: ウィンドウを閉じる
;[RANGE  ]: ウィンドウを閉じる
;[MOUSE  ]: ウィンドウを閉じる
;[SPECIAL]: ウィンドウを閉じる
$^q::
    if (isActive("console")) {
        send !{space}c
    } else {
        send !{f4}
    }
return

;[NORMAL ]: Shift + Q
;[EDIT   ]: Ctrl + Shift + Q
;[RANGE  ]: Ctrl + Shift + Q
;[MOUSE  ]: Ctrl + Shift + Q
;[SPECIAL]: Ctrl + Shift + Q
$+q::
    if (mode(_MODE.NORMAL)) {
        send +q
    } else {
        send ^+q
    }
return

;[NORMAL ]: rキー (コンビネーションキーの場合は==)
;[EDIT   ]: 仮想入力モードをスペシャルモードにする
;[RANGE  ]: 仮想入力モードをスペシャルモードにする
;[MOUSE  ]: 右上のエリアにフォーカスを移してNORMALモードに
;[SPECIAL]: 仮想入力モードを標準にする
;[DEBUG  ]: 再開
$r::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.SPECIAL)) {
            setMode(_MODE.EDIT)
        } else if (mode(_MODE.MOUSE)) {
            ActivateWindow("RightUp")
            setMode(_MODE.NORMAL)
            FlashWindow()
        } else if (mode(_MODE.DEBUG)) {
            send {F8}
        } else {
            setMode(_MODE.SPECIAL)
        }
    } else {
        if (isSecondKey()) {
            send {space}=={space}
        } else {
            send r
        }
    }
return

;[NORMAL ]: 更新
;[EDIT   ]: 更新
;[RANGE  ]: 更新
;[MOUSE  ]: 更新
;[SPECIAL]: 更新
$^r::
    if (isTerminal() || isActive("vscode") || isActive("intellij")) {
        send ^r
    } else {
        send {F5}
    }
return

;[NORMAL ]: sキー (コンビネーションキーの場合は())
;[EDIT   ]: Ctrl+Shift+S (Dynalistの場合は展開/格納) 
;[RANGE  ]: Ctrl+Shift+S
;[MOUSE  ]: 左下のエリアにフォーカスを移してNORMALモードに
;[SPECIAL]: アクティブウィンドウを中央下に最大化して移動する
;[DEBUG  ]: 停止
$s::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            if (isActiveProcess("dynalist")) {
                send ^.
            } else {
                send ^+{s}
            }
        } else if (mode(_MODE.RANGE)) {
            send ^+{s}
        } else if (mode(_MODE.SPECIAL)) {
            MoveWindow("CenterDown")
        } else if (mode(_MODE.MOUSE)) {
            ActivateWindow("LeftDown")
            setMode(_MODE.NORMAL)
            FlashWindow()
        } else if (mode(_MODE.DEBUG)) {
            send ^{F2}
        }
    } else {
        if (isSecondKey()) {
            imeOn := getIME()
            setIME(false)
            send ()
            setIME(imeOn)
            Sleep, 50
            send {Left}
        } else {
            send s
        }
    }
return

;[NORMAL ]: Shif+sキー
;[EDIT   ]: Ctrl+Alt+Shift+sキー (Dynalistの場合は全展開/全格納)
;[RANGE  ]: Ctrl+Alt+Shift+sキー (Dynalistの場合は全展開/全格納)
;[MOUSE  ]: Ctrl+Alt+Shift+sキー (Dynalistの場合は全展開/全格納)
;[SPECIAL]: Ctrl+Alt+Shift+sキー (Dynalistの場合は全展開/全格納)
$+s::
    if (isSecondKey()) {
        ActivateWindowByTitle("Slack")
    } else {
        if (!mode(_MODE.NORMAL)) {
            if (isActiveProcess("dynalist")) {
                send ^+.
            } else {
                send ^+!s
            }
        } else {
            send +s
        }
    }
return

;[NORMAL ]: Ctrl+Shif+sキー(poderosaの場合は画面更新再開）
;[EDIT   ]: Ctrl+Shif+sキー(poderosaの場合は画面更新再開）
;[RANGE  ]: Ctrl+Shif+sキー(poderosaの場合は画面更新再開）
;[MOUSE  ]: Ctrl+Shif+sキー(poderosaの場合は画面更新再開）
;[SPECIAL]: Ctrl+Shif+sキー(poderosaの場合は画面更新再開）
$^+s::
    if (isActive("poderosa")) {
        send ^q
    } else {
        send ^+s
    }
return

;[All Mode]: Alt+a (Slack: Saved items)
$!s::
    if (isActiveProcess("slack")) {
        send ^+s
    } else {
        send !s
    }
return

;[NORMAL ]: tキー (コンビネーションキーの場合は今日の日付)
;[EDIT   ]: ウィンドウの移動
;[RANGE  ]: ウィンドウの移動
;[MOUSE  ]: ウィンドウの移動
;[SPECIAL]: ウィンドウの移動
;[SNIPPET]: ウィンドウの移動
$t::
    if (!mode(_MODE.NORMAL)) {
        moveScreen()
    } else {
        if (isSecondKey()) {
            Clipboard = %A_Year%-%A_Mon%-%A_MDay%
            Send, ^v
        } else {
            send t
        }
    }
return

;[NORMAL ]: Shift+tキー (コンビネーションキーの場合はTogowlをアクティブにする)
;[EDIT   ]: Shift+tキー
;[RANGE  ]: Shift+tキー
;[MOUSE  ]: Shift+tキー
;[SPECIAL]: Shift+tキー
;[SNIPPET]: Shift+tキー
$+t::
    if (!mode(_MODE.NORMAL)) {
        send +t
    } else {
        if (isSecondKey()) {
            ActivateWindowByTitle("togowl-next")
        } else {
            send +t
        }
    }
return

;[NORMAL ]: Alt+tキー (コンビネーションキーの場合は現在のタイムスタンプ)
;[EDIT   ]: Alt+tキー
;[RANGE  ]: Alt+tキー
;[MOUSE  ]: Alt+tキー
;[SPECIAL]: Alt+tキー
;[SNIPPET]: Alt+tキー
$!t::
    if (!mode(_MODE.NORMAL)) {
        send !t
    } else {
        if (isSecondKey()) {
            Clipboard = %A_Year%-%A_Mon%-%A_MDay%T%A_Hour%:%A_Min%:%A_Sec%+09:00
            Send, ^v
        } else {
            send !t
        }
    }
return

;[NORMAL ]: uキー (コンビネーションキーの場合は"")
;[EDIT   ]: BackSpace
;[RANGE  ]: BackSpace後範囲指定を終了する
;[MOUSE  ]: マウスホイールを少し上に動かす
;[SPECIAL]: 7
;[SNIPPET]: :arrow_upper_right:
$u::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send {BS}
        } else if (mode(_MODE.RANGE)) {
            send {BS}
            setMode(_MODE.EDIT)
        } else if (mode(_MODE.MOUSE)) {
            scrollUpSmall()
        } else if (mode(_MODE.SPECIAL)) {
            if (isTerminal() || isActive("ubuntu")) {
                send 7
            } else {
                send {Numpad7}
            }
        } else if (mode(_MODE.SNIPPET)) {
            send :arrow_upper_right:
        }
    } else {
        if (isSecondKey()) {
            send {" 2}
            Sleep 50
            send {Left}
        } else {
            send u
        }
    }
return

;[NORMAL ]: Ctrl + U
;[EDIT   ]: 単語単位で削除
;[RANGE  ]: 単語単位で削除
;[MOUSE  ]: マウスホイールを上に動かす
;[SPECIAL]: BackSpace
$^u::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send ^{BS}
        } else if (mode(_MODE.RANGE)) {
            send ^{BS}
        } else if (mode(_MODE.MOUSE)) {
            scrollUpMiddle()
        } else if (mode(_MODE.SPECIAL)) {
            send {Numpad7}{Enter}
        }
    } else {
        send ^u
    }
return

;[NORMAL ]: shift + uキー
;[EDIT   ]: 5個文字をBSする
;[RANGE  ]: shift + uキー
;[MOUSE  ]: マウスホイールを大きく上に動かす
;[SPECIAL]: shift + uキー
$+u::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            if (isTerminal() || isActive("intellij") || isActive("ubuntu") || isActive("vscode")) {
                sendInput {BS 5}
            } else {
                sendInput +{Left 5}{BS}
            }
        } else if (mode(_MODE.RANGE)) {
            send +u
        } else if (mode(_MODE.MOUSE)) {
            scrollUpLarge()
        } else if (mode(_MODE.SPECIAL)) {
            send +u
        }
    } else {
        send +u
    }
return

;[NORMAL ]: v (コンビネーションキーの場合はシングルコーテーション) 
;[EDIT   ]: 貼り付けしてモードをVirtual->NORMALに変更
;[RANGE  ]: 貼り付けしてモードをVirtual->NORMALに変更
;[MOUSE  ]:
;[SPECIAL]: ↓
$v::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.MOUSE)) {
        } else if (mode(_MODE.SPECIAL)) {
            send {down}
        } else {
            setMode(_MODE.EDIT)
            send +{Ins}
        }
    } else {
        if (isSecondKey()) {
            send '
        } else {
            send v
        }
    }
return

;[NORMAL ]: wキー (コンビネーションキーの場合はCtrl+W)
;[EDIT   ]: 1単語右に移動
;[RANGE  ]: 選択範囲を1単語右に移動
;[MOUSE  ]: 左上のエリアにフォーカスを移してNORMALモードに
;[SPECIAL]: アクティブウィンドウを中央上に最大化して移動する
;[DEBUG  ]: ブレークポイントトグル
$w::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            send ^w
        } else {
            send w
        }
    } else if (mode(_MODE.EDIT)) {
        send ^{Right}
    } else if (mode(_MODE.RANGE)) {
        send ^+{Right}
    } else if (mode(_MODE.MOUSE)) {
        ActivateWindow("LeftUp")
        setMode(_MODE.NORMAL)
        FlashWindow()
    } else if (mode(_MODE.SPECIAL)) {
        MoveWindow("CenterUp")
    } else if (mode(_MODE.DEBUG)) {
        send ^+b
    }
return

;[NORMAL ]: Shift + wキー
;[EDIT   ]: ウィンドウをデュアルサイズで最大化する
;[RANGE  ]: ウィンドウをデュアルサイズで最大化する
;[MOUSE  ]: ウィンドウをデュアルサイズで最大化する
;[SPECIAL]: ウィンドウをデュアルサイズで最大化する
$+w::
    if (mode(_MODE.NORMAL)) {
        send +w
    } else if (mode(_MODE.EDIT)) {
        changeWindowSizeDualMax()
    } else if (mode(_MODE.RANGE)) {
        changeWindowSizeDualMax()
    } else if (mode(_MODE.MOUSE)) {
        changeWindowSizeDualMax()
    } else if (mode(_MODE.SPECIAL)) {
        changeWindowSizeDualMax()
    }
return

;[NORMAL ]: xキー(コンビネーションから場合は【】）
;[EDIT   ]: Ctrl + xキー ＆ モードをVirtual->NORMALに変更
;[RANGE  ]: Ctrl + xキー ＆ モードをVirtual->NORMALに変更
;[MOUSE  ]
;[SPECIAL]: ウィンドウを右半分に寄せる
$x::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.MOUSE)) {
        } else if (mode(_MODE.SPECIAL)) {
            send #{Right}
        } else {
            setMode(_MODE.EDIT)
            send ^x
        }
    } else {
        if (isSecondKey()) {
            sendMultiByte("【】")
            Sleep 50
            send {left}
        } else {
            send x
        }
    }
return

;[NORMAL ]: yキー (コンビネーションの場合は ->)
;[EDIT   ]: 元に戻すのをやめる
;[RANGE  ]: 元に戻すのをやめる
;[MOUSE  ]: 元に戻すのをやめる
;[SPECIAL]: 元に戻すのをやめる
$y::
    if (!mode(_MODE.NORMAL)) {
        send ^y
    } else {
        if (isSecondKey()) {
            send {space}->{space}
        } else {
            send y
        }
    }
return

;[NORMAL ]: zキー (コンビネーションの場合は!)
;[EDIT   ]: 元に戻す
;[RANGE  ]: 元に戻す
;[MOUSE  ]: 元に戻す
;[SPECIAL]: ウィンドウを左半分に寄せる
$z::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            send {!}
        } else {
            send z
        }
    } else if (mode(_MODE.SPECIAL)) {
        send #{Left}
    } else {
        send ^z
    }
return

