;[NORMAL ]: aキー(コンビネーションから場合は^）(ObsidianでCtrl+jのあとならプロパティの追加)
;[EDIT   ]: 行頭へ移動
;[RANGE  ]: 行頭に選択範囲を移動
;[MOUSE  ]: 左下のエリアにフォーカスを移してNORMALモードに
;[SPECIAL]: ウィンドウリサイズ特殊キー (コンビネーションの場合はリマインド)
$a::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            send {home}
        } else if (mode(_MODE.RANGE)) {
            send +{home}
        } else if (mode(_MODE.MOUSE)) {
            ActivateWindow("LeftDown")
            setMode(_MODE.NORMAL)
            FlashWindow()
        } else if (mode(_MODE.SPECIAL)) {
            if (isSecondKey()) {
                MoveWindow("LeftDownRest")
            } else {
                MoveWindow("LeftDown")
            }
        }
    } else {
        if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ()) {
            send {F23}
        } else if (isSecondKey()) {
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
;[SPECIAL]: ウィンドウリサイズ特殊キー (コンビネーションの場合はリマインド)
$c::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.MOUSE)) {
        } else if (mode(_MODE.SPECIAL)) {
            if (isSecondKey()) {
                MoveWindow("RightSpecialRest")
            } else {
                MoveWindow("RightSpecial")
            }
        } else {
            setMode(_MODE.EDIT)
            if (isTerminal() || isActive("intellij") || isActive("vscode")) {
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
;[EDIT   ]: Shift + cキー
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
        send +c
    } else if (mode(_MODE.RANGE)) {
        send +c
    } else if (mode(_MODE.MOUSE)) {
        send +c
    } else if (mode(_MODE.SPECIAL)) {
        send +c
    }
return

;[NORMAL ]: dキー (コンビネーションの場合は#）(ObsidianでCtrl+jのあとならカレンダー検索)
;[EDIT   ]: BSキー
;[RANGE  ]: BSキー
;[MOUSE  ]: 右下のエリアにフォーカスを移してNORMALモードに
;[SPECIAL]: ウィンドウリサイズ特殊キー (コンビネーションの場合はリマインド)
$d::
    if (mode(_MODE.NORMAL)) {
        if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ()) {
            send {F15}
            return
        }
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
        ActivateWindow("RightDown")
        setMode(_MODE.NORMAL)
        FlashWindow()
    } else if (mode(_MODE.SPECIAL)) {
        if (isSecondKey()) {
            MoveWindow("RightDownRest")

        }else {
            MoveWindow("RightDown")
        }
    }
return

;[NORMAL ]: Ctrl + dキー
;[EDIT   ]: Ctrl + dキー
;[RANGE  ]: Ctrl + dキー
;[MOUSE  ]: Ctrl + dキー
;[SPECIAL]: Ctrl + dキー
$^d::
    if (mode(_MODE.NORMAL)) {
        send ^d
    } else if (mode(_MODE.EDIT)) {
        send ^d
    } else if (mode(_MODE.RANGE)) {
        send ^d
    } else if (mode(_MODE.MOUSE)) {
        send ^d
    } else if (mode(_MODE.SPECIAL)) {
        send ^d
    }
return

;[NORMAL ]: Shift + dキー (コンビネーションキーの場合はTodoistをアクティブにする)
;[EDIT   ]: Enter
;[RANGE  ]: Enter
;[MOUSE  ]: Enter
;[SPECIAL]: Enter
$+d::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            ActivateWindowByTitle(": Todoist")
        } else {
            send +d
        }
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

;[NORMAL ]: eキー (コンビネーションキーの場合は=) (ObsidianでCtrl+jのあとなら最近のファイルを開く) (ChromeでCtrl+jのあとならタブ検索)
;[EDIT   ]: 1つ戻る
;[RANGE  ]: 1つ戻る
;[MOUSE  ]: 右上のエリアにフォーカスを移してNORMALモードに
;[SPECIAL]: アクティブウィンドウを右上に最大化して移動する
;[SNIPPET]: :evergreen_tree::
;[DEBUG  ]: 評価を開く
$e::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.SPECIAL)) {
            MoveWindow("RightUp")
        } else if (mode(_MODE.MOUSE)) {
            ActivateWindow("RightUp")
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
        if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ()) {
            send {F14}
            return
        }
        if (isActiveProcess("chrome") && isSecondKeyAfterCtrlJ()) {
            send ^+a
            return
        }
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

;[NORMAL ]: fキー(コンビネーションの場合は$）(ObsidianでCtrl+jのあとならファイルを開く)
;[EDIT   ]: 一番上に移動
;[RANGE  ]: 選択範囲を一番上に移動
;[MOUSE  ]: 右下のエリアにフォーカスを移してNORMALモードに
;[SPECIAL]: フルスクリーン
;[DEBUG  ]: ステップオーバー (F10)
$f::
    if (mode(_MODE.NORMAL)) {
        if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ()) {
            send {F13}
            return
        }
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
        send #{UP}
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

;[NORMAL ]: gキー (コンビネーションの場合は &)(ObsidianでCtrl+jのあとなら全文検索)
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
        if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ()) {
            send ^g
        } else {
            if (isSecondKey()) {
                send &
            } else {
                send g
            }
        }
    }
return

;[NORMAL ]: h (;からのコンビネーションの場合は~)(ObsidianでCtrl+jのあとならBacklink Search)
;[EDIT   ]: 左に移動
;[RANGE  ]: 選択範囲を左に移動
;[MOUSE  ]: マウスポインタを左に微かに移動
;[SPECIAL]: hキー
;[DEBUG  ]: ステップアウト (SHIFT + F11)
$h::
    if (mode(_MODE.NORMAL)) {
        if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ()) {
            send {F17}
        } else {
            if (isSecondKey()) {
                send ~
            } else {
                send h
            }
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

;[NORMAL ]: Ctrl + H (ObsidianでCtrl+jのあとならFold more)
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
        if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ()) {
            send {F20}
        } else {
            send ^h
        }
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

;[NORMAL ]: Alt + hキー (ターミナル: タブを左に移動, chrome: 左のタブに移動)
;[EDIT   ]: Alt + 左キー (ターミナル: タブを左に移動, chrome: 左のタブに移動)
;[RANGE  ]: Alt + 左キー (ターミナル: タブを左に移動, chrome: 左のタブに移動)
;[MOUSE  ]: マウスポインタを大きく左に移動
;[SPECIAL]: Alt + hキー
$!h::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            if (isTerminal()) {
                send ^+{TAB}
            } else if (isActiveProcess("chrome")) {
                send ^+{TAB}
            } else {
                send !{Left}
            }
        } else if (mode(_MODE.RANGE)) {
            if (isTerminal()) {
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
        if (isSecondKey()) {
            send, #^{Left}
        } else {
            if (isActive("cmder")) {
                send ^+{TAB}
            } else if (isActiveProcess("chrome")) {
                send ^+{TAB}
            } else {
                send !h
            }
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
        if (isTerminal() || isUbuntu()) {
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
        if (isTerminal() || isUbuntu()) {
            send 4
        } else {
            send {Numpad4}
        }
    } else if (mode(_MODE.DEBUG)) {
        send +{F11}
    }
return

;[NORMAL ]: Ctrl + jキー (Obsidian/chromeの場合はコンビネーション)
;[EDIT   ]: 下に5つ移動
;[RANGE  ]: 選択範囲を下に5つ移動
;[MOUSE  ]: マウスポインタを下に移動
;[SPECIAL]: 4キー + Enter
$^j::
    if (mode(_MODE.NORMAL)) {
        if (isActiveProcess("Obsidian") || isActiveProcess("chrome")) {
            ;Do Nothing
        } else {
            send ^j
        }
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
;[EDIT   ]: Alt + jキー
;[RANGE  ]: Alt + jキー
;[MOUSE  ]: マウスポインタを下に少し移動
;[SPECIAL]: Alt + jキー
$!j::
    if (mode(_MODE.NORMAL)) {
        send !j
    } else if (mode(_MODE.EDIT)) {
        send !{Down}
    } else if (mode(_MODE.RANGE)) {
        send !{Down}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseDownSmall()
    } else if (mode(_MODE.SPECIAL)) {
        send !j
    }
return

;Ctrl+Shift+jキー (ターミナルの場合はCtrl+Shift+jが使えないのでAlt+jで代用)
$^+j::
    if (isTerminal()) {
        send !j
    } else {
        send ^+j
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
        if (isTerminal() || isUbuntu()) {
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
;[EDIT   ]: Alt + kキー
;[RANGE  ]: Alt + kキー
;[MOUSE  ]: マウスポインタを上に少し移動
;[SPECIAL]: Alt + kキー
$!k::
    if (mode(_MODE.NORMAL)) {
        send !k
    } else if (mode(_MODE.MOUSE)) {
        moveMouseUpSmall()
    } else if (mode(_MODE.SPECIAL)) {
        send !k
    }
return

;Ctrl+Shift+kキー (ターミナルの場合はCtrl+Shift+kが使えないのでAlt+kで代用)
$^+k::
    if (isTerminal()) {
        send !k
    } else {
        send ^+k
    }
return

;[NORMAL ]: lキー (コンビネーションキーの場合は_) (Obsidianの場合はLink search)
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
            if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ()) {
                send {F19}
            } else {
                send l
            }
        }
    } else if (mode(_MODE.EDIT)) {
        send {right}
    } else if (mode(_MODE.RANGE)) {
        send +{right}
    } else if (mode(_MODE.MOUSE)) {
        moveMouseRightMicro()
    } else if (mode(_MODE.SPECIAL)) {
        if (isTerminal() || isUbuntu()) {
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

;[NORMAL ]: Ctrl+lキー (ObsidianでCtrl+jのあとならFold less)
;[EDIT   ]: 右に5つ移動
;[RANGE  ]: 選択範囲を右に5つ移動
;[MOUSE  ]: マウスポインタを右にそこそこ移動
;[SPECIAL]: 6キー + Enter
$^l::
    if (mode(_MODE.NORMAL)) {
        if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ()) {
            send {F21}
        } else {
            send ^l
        }
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

;[NORMAL ]: Alt + lキー (ターミナル: タブを右に移動, chrome: 右のタブへ移動)
;[EDIT   ]: Alt + lキー (ターミナル: タブを右に移動, chrome: 右のタブへ移動)
;[RANGE  ]: Alt + lキー (ターミナル: タブを右に移動, chrome: 右のタブへ移動)
;[MOUSE  ]: マウスポインタ右に少し移動
;[SPECIAL]: Alt + lキー
$!l::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            send, #^{Right}
        } else {
            if (isTerminal()) {
                send ^{TAB}
            } else if (isActiveProcess("chrome")) {
                send ^{TAB}
            } else {
                send !l
            }
        }
    } else if (mode(_MODE.EDIT)) {
        if (isTerminal()) {
            send ^{TAB}
        } else if (isActiveProcess("chrome")) {
            send ^{TAB}
        } else {
            send !l
        }
    } else if (mode(_MODE.RANGE)) {
        if (isActive("cmder")) {
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
            if (isTerminal() || isUbuntu()) {
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
;[EDIT   ]: F3キー相当 (Chrome: 新しいタブを開く + NORMALモード)
;[RANGE  ]: F3キー相当 (Chrome: 新しいタブを開く + NORMALモード)
;[MOUSE  ]: F3キー相当 (Chrome: 新しいタブを開く + NORMALモード)
;[SPECIAL]: F3キー相当 (Chrome: 新しいタブを開く + NORMALモード)
$n::
    if (!mode(_MODE.NORMAL)) {
        if (isActiveProcess("chrome")) {
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
;[EDIT   ]: Ctrl+Shift+F3 (実装のプレビュー)
;[RANGE  ]: Ctrl+Shift+F3 (実装のプレビュー)
;[MOUSE  ]: Ctrl+Shift+F3 (実装のプレビュー)
;[SPECIAL]: Ctrl+Shift+F3 (実装のプレビュー)
$^n::
    if (!mode(_MODE.NORMAL)) {
        send ^+{F3}
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
;[NORMAL ]: oキー(コンビネーションキーの場合は|)(ObsidianでCtrl+jのあとならアウトラインに移動する)
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
            if (isTerminal() || isUbuntu()) {
                send 9
            } else {
                send {Numpad9}
            }
        }
    } else {
        if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ()) {
            send {F18}
            return
        }
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
            if (isTerminal() || isActive("intellij") || isUbuntu() || isActive("vscode")) {
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
;[EDIT   ]: Ctrl + Shift + q (Chromeタブを閉じる)
;[RANGE  ]: Ctrl + Shift + q (Chromeタブを閉じる)
;[MOUSE  ]: 左上のエリアにフォーカスを移してNORMALモードに
;[SPECIAL]: Windowを左上に移動
$q::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.SPECIAL)) {
            MoveWindow("LeftUp")
        } else if (mode(_MODE.MOUSE)) {
            ActivateWindow("LeftUp")
            setMode(_MODE.NORMAL)
            FlashWindow()
        } else {
            if (isActiveProcess("chrome")) {
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
;[MOUSE  ]: r
;[SPECIAL]: 仮想入力モードを標準にする
;[DEBUG  ]: 再開
$r::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.SPECIAL)) {
            setMode(_MODE.EDIT)
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

;[NORMAL ]: sキー (コンビネーションキーの場合は()) (ObsidianでCtrl+jのあとならスターファイルを開く)
;[EDIT   ]: Ctrl+Shift+S + NORMALモードへ (Google Chrome: Ctrl+Shift+c)
;[RANGE  ]: Ctrl+Shift+S + NORMALモードへ
;[MOUSE  ]: 中央下のエリアにフォーカスを移してNORMALモードに
;[SPECIAL]: アクティブウィンドウを中央下に最大化して移動する
;[DEBUG  ]: 停止
$s::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.EDIT)) {
            if (isActiveProcess("chrome")) {
                send ^+c
            } else {
                send ^+{s}
                setMode(_MODE.NORMAL)
            }
        } else if (mode(_MODE.RANGE)) {
            send ^+{s}
            setMode(_MODE.NORMAL)
        } else if (mode(_MODE.SPECIAL)) {
            MoveWindow("CenterDown")
        } else if (mode(_MODE.MOUSE)) {
            ActivateWindow("CenterDown")
            setMode(_MODE.NORMAL)
            FlashWindow()
        } else if (mode(_MODE.DEBUG)) {
            send ^{F2}
        }
    } else {
        if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ()) {
            send {F16}
            return
        }
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

;[NORMAL ]: Shif+sキー (ObsidianでCtrl+jのあとなら設定を開く)
;[EDIT   ]: Ctrl+Alt+Shift+sキー
;[RANGE  ]: Ctrl+Alt+Shift+sキー
;[MOUSE  ]: Ctrl+Alt+Shift+sキー
;[SPECIAL]: Ctrl+Alt+Shift+sキー
$+s::
    if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ()) {
        send ^,
        return
    }
    if (isSecondKey()) {
        ActivateWindowByProcess("slack")
    } else {
        if (!mode(_MODE.NORMAL)) {
            send ^+!s
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

;[NORMAL ]: tキー (コンビネーションキーの場合は今日の日付、ハイフン区切り)
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

;[All Mode]: Ctrl+t (Slack: timesを開く)
$^t::
    if (isActiveProcess("slack")) {
        send ^k
        send times_tadashi-aikawa
        Sleep 500
        send {Enter}
    } else {
        send ^t
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
            ActivateWindowByTitle("togowl - togowl")
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

;[NORMAL ]: uキー (コンビネーションキーの場合は"")(ObsidianでCtrl+jのあとならchangelogの更新)
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
            if (isTerminal() || isUbuntu()) {
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
            if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ()) {
                send ^!+u
            } else {
                send u
            }
        }
    }
return

;[NORMAL ]: Ctrl + U (IMEがONの場合はF7でカタカナ変換)
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
        if (getIME()) {
            send {F7}
        } else {
            send ^u
        }
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
            if (isTerminal() || isActive("intellij") || isUbuntu() || isActive("vscode")) {
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
            if (isTerminal() || isActive("intellij") || isActive("vscode")) {
                send +{Ins}
            } else {
                send ^v
            }
        }
    } else {
        if (isSecondKey()) {
            send '
        } else {
            send v
        }
    }
return

;[NORMAL ]: wキー (コンビネーションキーの場合はCtrl+W) (ObsidianでCtrl+jのあとなら設定を開く)
;[EDIT   ]: 1単語右に移動
;[RANGE  ]: 選択範囲を1単語右に移動
;[MOUSE  ]: 中央上のエリアにフォーカスを移してNORMALモードに
;[SPECIAL]: アクティブウィンドウを中央上に最大化して移動する
;[DEBUG  ]: ブレークポイントトグル
$w::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            send ^w
            return
        }
        if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ()) {
            send !+t
            return
        }
        send w
    } else if (mode(_MODE.EDIT)) {
        send ^{Right}
    } else if (mode(_MODE.RANGE)) {
        send ^+{Right}
    } else if (mode(_MODE.MOUSE)) {
        ActivateWindow("CenterUp")
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
;[SPECIAL]: ウィンドウリサイズ特殊キー
$x::
    if (!mode(_MODE.NORMAL)) {
        if (mode(_MODE.MOUSE)) {
        } else if (mode(_MODE.SPECIAL)) {
            MoveWindow("CenterSpecial")
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
;[SPECIAL]: ウィンドウリサイズ特殊キー (コンビネーションの場合はリマインド)
$z::
    if (mode(_MODE.NORMAL)) {
        if (isSecondKey()) {
            send {!}
        } else {
            send z
        }
    } else if (mode(_MODE.SPECIAL)) {
        if (isSecondKey()) {
            MoveWindow("LeftSpecialRest")
        } else {
            MoveWindow("LeftSpecial")
        }
    } else {
        send ^z
    }
return
