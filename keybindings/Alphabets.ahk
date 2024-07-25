;[N] aキー(; -> ^) (Obsidian: C-j -> プロパティ追加)
;[E] 行頭へ移動
;[R] 行頭に選択範囲を移動
;[M] 左下のエリアにフォーカスとポインタを移してNORMALモードに
;[S] ウィンドウリサイズ特殊キー (; -> restサイズ)
$a::
    if (modes("N")) {
        if (AP("Obsidian") && 2K("^j")) {
            send {F23}
        } else if (2K(";")) {
            send {^}
        } else {
            send a
        }
    } else if (modes("E")) {
        send {home}
    } else if (modes("R")) {
        send +{home}
    } else if (modes("M")) {
        ActivateWindow("LeftDown")
        setMode(_MODE.NORMAL)
        MoveCenterInActiveWindow()
    } else if (modes("S")) {
        if (2K(";")) {
            MoveWindow("LeftDownRest")
        } else {
            MoveWindow("LeftDown")
        }
    }
return

;[NERMS] アクティブウィンドウを常時最前面表示にする
$#a::
    WinSet, Topmost, Toggle, A
return

;[NMS] bキー
;[E]   1単語左へ移動する
;[R]   選択範囲を1単語左に移動
$b::
    if (modes("NMS")) {
        send b
    } else if (modes("E")) {
        send ^{Left}
    } else if (modes("R")) {
        send ^+{Left}
    }
return

;[N]  cキー (; -> コードブロック)
;[ER] コピーしてモードをVirtual->NORMALに変更
;[S]  ウィンドウリサイズ特殊キー (; -> restサイズ)
$c::
    if (modes("N")) {
        if (2K(";")) {
            send {`` 3}
        } else {
            send c
        }
    } else if (modes("ER")) {
        setMode(_MODE.EDIT)
        if (isTerminal() || AW("intellij")) {
            send ^{Ins}
        } else {
            send ^c
        }
    } else if (modes("S")) {
        if (2K(";")) {
            MoveWindow("RightSpecialRest")
        } else {
            MoveWindow("RightSpecial")
        }
    }
return

;[N]  dキー (; -> #)
;[ER] BSキー
;[M]  右下のエリアにフォーカスとポインタを移してNORMALモードに
;[S]  ウィンドウリサイズ特殊キー (; -> restサイズ)
$d::
    if (modes("N")) {
        if (2K(";")) {
            send {#}
        } else {
            send d
        }
    } else if (modes("ER")) {
        send {BS}
    } else if (modes("M")) {
        ActivateWindow("RightDown")
        setMode(_MODE.NORMAL)
        MoveCenterInActiveWindow()
    } else if (modes("S")) {
        if (2K(";")) {
            MoveWindow("RightDownRest")
        } else {
            MoveWindow("RightDown")
        }
    }
return

;[N]  eキー (; -> =) (Obsidian: C-j -> 最近のファイルを開く) (Chrome: C-j -> タブ検索)
;[ER] 1つ戻る
;[M]  右上のエリアにフォーカスとポインタを移してNORMALモードに
;[S]  アクティブウィンドウを右上に最大化して移動する
$e::
    if (modes("N")) {
        if (2K(";")) {
            send {space}={space}
        } else if (AP("Obsidian") && 2K("^j")) {
            send {F14}
        } else if (AP("chrome") && 2K("^j")) {
            send ^+a
        } else {
            send e
        }
    } else if (modes("ER")) {
        send !{left}
    } else if (modes("M")) {
        ActivateWindow("RightUp")
        setMode(_MODE.NORMAL)
        MoveCenterInActiveWindow()
    } else if (modes("S")) {
        MoveWindow("RightUp")
    }
return

;[N]    Ctrl + eキー
;[ERMS] 1つ進む
$^e::
    if (modes("N")) {
        send ^e
    } else if (modes("ERMS")) {
        send !{right}
    }
return

;[N] fキー(; -> $) (Obsidian: C-j -> ファイルを開く)
;[E] 一番上に移動
;[R] 選択範囲を一番上に移動
;[M] 右下のエリアにフォーカスを移してNORMALモードに
;[S] フルスクリーン
$f::
    if (modes("N")) {
        if (2K(";")) {
            send {$}
        } else if (AP("Obsidian") && 2K("^j")) {
            send {F13}
        } else {
            send f
        }
    } else if (modes("E")) {
        send ^{Home}
    } else if (modes("R")) {
        send +^{Home}
    } else if (modes("M")) {
        ActivateWindow("RightDown")
        setMode(_Mode.NORMAL)
    } else if (modes("S")) {
        SetFullHDWidthAtCenter()
    }
return

;[NMS] Shift + fキー
;[E]   一番下に移動
;[R]   選択範囲を一番下に移動
$+f::
    if (modes("NMS")) {
        send +f
    } else if (modes("E")) {
        send ^{End}
    } else if (modes("R")) {
        send +^{End}
    }
return

;[N]  gキー (; -> &)(Obsidian: C-j -> 全文検索)
;[EM] RANGEモードに切り替え
;[R]  EDITモードに切り替え
;[S]  G+NORMALモードに切り替え(Vimジャンプ用)
$g::
    if (modes("N")) {
        if (2K(";")) {
            send &
        } else if (AP("Obsidian") && 2K("^j")) {
            send ^g
        } else {
            send g
        }
    } else if (modes("EM")) {
        setMode(_MODE.RANGE)
    } else if (modes("R")) {
        setMode(_MODE.EDIT)
    } else if (modes("S")) {
        send G
        setMode(_MODE.NORMAL)
    }
return

;[N] h (; -> ~)(Obsidian: C-j -> Backlink Search)
;[E] 左に移動
;[R] 選択範囲を左に移動
;[S] ウィンドウを左半分にリサイズ
$h::
    if (modes("N")) {
        if (2K(";")) {
            send ~
        } else if (AP("Obsidian") && 2K("^j")) {
            send {F17}
        } else {
            send h
        }
    } else if (modes("E")) {
        send {Left}
    } else if (modes("R")) {
        send +{Left}
    } else if (modes("S")) {
        send #{Left}
    }
return

;[N] Ctrl + H (Obsidian: C-j -> Fold more)
;[E] 5つ左に移動
;[R] 選択範囲を5つ左に移動
;[S] Ctrl + H
$^h::
    if (modes("N")) {
        if (AP("Obsidian") && 2K("^j")) {
            send {F20}
        } else {
            send ^h
        }
    } else if (modes("E")) {
        sendInput {Left 5}
    } else if (modes("R")) {
        sendInput +{Left 5}
    } else if (modes("S")) {
        send ^h
    }
return

;[NS] Shift + hキー
;[E]  15つ左に移動
;[R]  選択範囲を15つ左に移動
$+h::
    if (modes("NS")) {
        send +h
    } else if (modes("E")) {
        sendInput {Left 15}
    } else if (modes("R")) {
        sendInput +{Left 15}
    }
return

;[NERS] Alt + hキー (Chrome: 左のタブに移動)
$!h::
    if (modes("NERS")) {
        if (AP("chrome")) {
            send ^+{TAB}
        } else {
            send !h
        }
    }
    return

;[N]  iキー (; -> {})
;[ER] MOUSEモードに変更
;[M]  NORMALモードに変更
;[S]  8キー
$i::
    if (modes("N")) {
        if (2K(";")) {
            send {{}{}}
            Sleep, 50
            send {Left}
        } else {
            send i
        }
    } else if (modes("ER")) {
        setMode(_MODE.MOUSE)
    } else if (modes("M")) {
        setMode(_MODE.NORMAL)
    } else if (modes("S")) {
        if (isTerminal() || isUbuntu()) {
            send 8
        } else {
            send {Numpad8}
        }
    }
return

;[N] jキー (; -> '')
;[E] 下に移動
;[R] 選択範囲を下に移動
;[S] 4キー
$j::
    if (modes("N")) {
        if (2K(";")) {
            send {' 2}
            Sleep 50
            send {Left}
        } else {
            send j
        }
    } else if (modes("E")) {
        send {Down}
    } else if (modes("R")) {
        send +{Down}
    } else if (modes("S")) {
        if (isTerminal() || isUbuntu()) {
            send 4
        } else {
            send {Numpad4}
        }
    }
return

;[N] Ctrl + jキー (Obsidian: Prefixキーのため何もしない) (Chrome: Prefixキーのため何もしない)
;[E] 下に5つ移動
;[R] 選択範囲を下に5つ移動
$^j::
    if (modes("N")) {
        if (AP("Obsidian") || AP("chrome")) {
            ;Do Nothing
        } else {
            send ^j
        }
    } else if (modes("E")) {
        sendInput {Down 5}
    } else if (modes("R")) {
        sendInput +{Down 5}
    }
return

;[N] Shift + jキー
;[E] 下に1ページ移動
;[R] 選択範囲を下に1ページ移動
$+j::
    if (modes("N")) {
        send +j
    } else if (modes("E")) {
        send {PgDn}
    } else if (modes("R")) {
        send +{PgDn}
    }
return

;[N]  Alt + jキー
;[ER] Alt + 下キー
$!j::
    if (modes("N")) {
        send !j
    } else if (modes("ER")){
        send !{Down}
    }
return

;[NERMS] Ctrl+Shift+jキー (ターミナルの場合はCtrl+Shift+jが使えないのでAlt+jで代用)
$^+j::
    if (isTerminal()) {
        send !j
    } else {
        send ^+j
    }
return

;[N] kキー (; -> ``)
;[E] 上に移動
;[R] 上に選択範囲を移動
;[S] 5キー
$k::
    if (modes("N")) {
        if (2K(";")) {
            send ````
            Sleep 50
            send {left}
        } else {
            send k
        }
    } else if (modes("E")) {
        send {Up}
    } else if (modes("R")) {
        send +{Up}
    } else if (modes("S")) {
        if (isTerminal() || isUbuntu()) {
            send 5
        } else {
            send {Numpad5}
        }
    }
return

;[N] Ctrl + kキー
;[E] 上に5つ移動
;[R] 選択範囲を上に5つ移動
$^k::
    if (modes("N")) {
        send ^k
    } else if (modes("E")) {
        sendInput {Up 5}
    } else if (modes("R")) {
        sendInput +{Up 5}
    }
return

;[N] Shift + kキー
;[E] 上に1ページ移動
;[R] 選択範囲を上に1ページ移動
$+k::
    if (modes("N")) {
        send +k
    } else if (modes("E")) {
        send {PgUp}
    } else if (modes("R")) {
        send +{PgUp}
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

;[N] lキー (; -> _) (Obsidian: C-j -> Link search)
;[E] 右に移動
;[R] 選択範囲を右に移動
;[S] 6キー
$l::
    if (modes("N")) {
        if (2K(";")) {
            imeOn := getIME()
            setIME(false)
            send _
            setIME(imeOn)
        } else if (AP("Obsidian") && 2K("^j")) {
            send {F19}
        } else {
            send l
        }
    } else if (modes("E")) {
        send {right}
    } else if (modes("R")) {
        send +{right}
    } else if (modes("S")) {
        if (isTerminal() || isUbuntu()) {
            send 6
        } else {
            send {Numpad6}
        }
    }
return

;[N] Ctrl+lキー (Obsidian: C-j -> Fold less)
;[E] 右に5つ移動
;[R] 選択範囲を右に5つ移動
$^l::
    if (modes("N")) {
        if (AP("Obsidian") && 2K("^j")) {
            send {F21}
        } else {
            send ^l
        }
    } else if (modes("E")) {
        sendInput {Right 5}
    } else if (modes("R")) {
        sendInput +{Right 5}
    }
return

;[N] Shift + lキー
;[E] 右に15つ移動
;[R] 選択範囲を右に15つ移動
;[S] Shift + lキー
$+l::
    if (modes("N")) {
        send +l
    } else if (modes("E")) {
        sendInput {Right 15}
    } else if (modes("R")) {
        sendInput +{Right 15}
    } else if (modes("S")) {
        send +l
    }
return

;[NERS] Alt + lキー (Chrome: 右のタブに移動)
$!l::
    if (modes("NERS")) {
        if (AP("chrome")) {
            send ^{TAB}
        } else {
            send !l
        }
    }
    return

;[N]  mキー (; -> ")
;[ER] 日本語入力OFF + モードをNORMALに変更
;[S]  1キー
$m::
    if (modes("N")) {
        if (2K(";")) {
            send "
        } else {
            send m
        }
    } else if (modes("ER")) {
        setIME(false)
        setMode(_MODE.NORMAL)
    } else if (modes("S")) {
        if (isTerminal() || isUbuntu()) {
            send 1
        } else {
            send {Numpad1}
        }
    }
return

;[N] oキー(; -> |) (Obsidian: C-j -> アウトライン表示)
;[E] DELキー
;[R] DELキー(処理後に範囲指定を終了する)
;[S] 9キー
$o::
    if (modes("N")) {
        if (2K(";")) {
            imeOn := getIME()
            setIME(false)
            send |
            setIME(imeOn)
        } else if (AP("Obsidian") && 2K("^j")) {
            send {F18}
        } else {
            send o
        }
    } else if (modes("E")) {
        send {del}
    } else if (modes("R")) {
        send {del}
        setMode(_MODE.EDIT)
    } else if (modes("S")) {
        if (isTerminal() || isUbuntu()) {
            send 9
        } else {
            send {Numpad9}
        }
    }
return

;[N]  Ctrl + O
;[ER] 単語単位でDelete
$^o::
    if (modes("N")) {
        send ^o
    } else if (modes("ER")) {
        send ^{del}
    }
return

;[NR] Shift + O
;[E]  5個文字をDeleteする
$+o::
    if (modes("NR")) {
        send +o
    } else if (modes("E")) {
        if (isTerminal() || AW("intellij") || isUbuntu() || AW("vscode")) {
            sendInput {DEL 5}
        } else {
            sendInput +{RIGHT 5}{DEL}
        }
    }
return

;[NERMS] Ctrl+Shift+oキー (ターミナルの場合はCtrl+Shift+oが使えないのでAlt+oで代用)
$^+o::
    if (isTerminal()) {
        send !o
    } else {
        send ^+o
    }
return

;[N] pキー (; -> %)
;[S] ハイフン
$p::
    if (modes("N")) {
        if (2K(";")) {
            send `%
        } else {
            send p
        }
    } else if (modes("S")) {
        send -
    }
return

;[N] Shift+pキー
;[E] ahkスクリプトのリロード
$+p::
    if (modes("N")) {
        send +p
    } else if (modes("E")) {
        Reload
    }
return

;[N] qキー
;[E] Ctrl + Shift + q (Chrome: タブを閉じる)
;[M] 左上のエリアにフォーカスとポインタを移してNORMALモードに
;[S] Windowを左上に移動
$q::
    if (modes("N")) {
        send q
    } else if (modes("E")) {
        if (AP("chrome")) {
            send ^w
        } else {
            send ^+q
        }
    } else if (modes("M")) {
        ActivateWindow("LeftUp")
        setMode(_MODE.NORMAL)
        MoveCenterInActiveWindow()
    } else if (modes("S")) {
        MoveWindow("LeftUp")
    }
return

;[NERMS] ウィンドウを閉じる
$^q::
    send !{f4}
return

;[N]    rキー (; -> R)
;[EMR]  SPECIALモードに切り替え
;[S]    EDITモードに切り替え
$r::
    if (modes("N")) {
        if (2K(";")) {
            send R
        } else {
            send r
        }
    } else if (modes("EMR")) {
        setMode(_MODE.SPECIAL)
    } else if (modes("S")) {
        setMode(_MODE.EDIT)
    }
return

;[NERMS] 更新
$^r::
    if (isTerminal() || AW("vscode") || AW("intellij")) {
        send ^r
    } else {
        send {F5}
    }
return

;[N] sキー (; -> ()) (Obsidian: C-j -> スターファイル検索)
;[E] Ctrl+Shift+S + NORMALモードへ (Google Chrome: Ctrl+Shift+c)
;[R] Ctrl+Shift+S + NORMALモードへ
;[M] 中央下のエリアにフォーカスとポインタを移してNORMALモードに
;[S] アクティブウィンドウを中央下に最大化して移動する
$s::
    if (modes("N")) {
        if (2K(";")) {
            imeOn := getIME()
            setIME(false)
            send ()
            setIME(imeOn)
            Sleep, 50
            send {Left}
        } else if (AP("Obsidian") && 2K("^j")) {
            send {F16}
        } else {
            send s
        }
    } else if (modes("E")) {
        if (AP("chrome")) {
            send ^+c
        } else {
            send ^+{s}
            setMode(_MODE.NORMAL)
        }
    } else if (modes("R")) {
        send ^+{s}
        setMode(_MODE.NORMAL)
    } else if (modes("M")) {
        ActivateWindow("CenterDown")
        setMode(_MODE.NORMAL)
        MoveCenterInActiveWindow()
    } else if (modes("S")) {
        MoveWindow("CenterDown")
    }
return

;[N] Shif+sキー (設定を開く) (Obsidian: C-j -> 設定を開く)
;[E] Ctrl+Alt+Shift+sキー (設定を開く)
$+s::
    if (modes("N")) {
        if (AP("Obsidian") && 2K("^j")) {
            send ^,
        } else {
            send +s
        }
    } else if (modes("E")) {
        send ^+!s
    }
return

;[N] tキー (; -> 今日の日付、ハイフン区切り(ex: 2024-06-21))
;[E] ウィンドウの移動
$t::
    if (modes("N")) {
        if (2K(";")) {
            Clipboard = %A_Year%-%A_Mon%-%A_MDay%
            paste()
        } else {
            send t
        }
    } else if (modes("E")) {
        moveScreen()
    }
return

;[N] Shift+tキー (; -> 現在のタイムスタンプ(ISO8601))
$+t::
    if (modes("N")) {
        if (2K(";")) {
            Clipboard = %A_Year%-%A_Mon%-%A_MDay%T%A_Hour%:%A_Min%:%A_Sec%+09:00
            paste()
        } else {
            send +t
        }
    }
return

;[N] uキー (; -> "") (Obsidian: C-j -> changelog更新)
;[E] BackSpace
;[R] BackSpace後範囲指定を終了する
;[S] 7
$u::
    if (modes("N")) {
        if (2K(";")) {
            send {" 2}
            Sleep 50
            send {Left}
        } else if (AP("Obsidian") && 2K("^j")) {
            send ^!+u
        } else {
            send u
        }
    } else if (modes("E")) {
        send {BS}
    } else if (modes("R")) {
        send {BS}
        setMode(_MODE.EDIT)
    } else if (modes("S")) {
        if (isTerminal() || isUbuntu()) {
            send 7
        } else {
            send {Numpad7}
        }
    }
return

;[N]  Ctrl + U (IMEがONの場合はF7でカタカナ変換)
;[ER] 単語単位で削除
$^u::
    if (modes("N")) {
        if (getIME()) {
            send {F7}
        } else {
            send ^u
        }
    } else if (modes("ER")) {
        send ^{BS}
    }
return

;[N] shift + uキー
;[E] 5個文字をBSする
$+u::
    if (modes("N")) {
        send +u
    } else if (modes("E")) {
        if (isTerminal() || AW("intellij") || isUbuntu() || AW("vscode")) {
            sendInput {BS 5}
        } else {
            sendInput +{Left 5}{BS}
        }
    }
return

;[N]  v (; - ')
;[ER] 貼り付けしてモードをEDITに
$v::
    if (modes("N")) {
        if (2K(";")) {
            send '
        } else {
            send v
        }
    } else if (modes("ER")) {
        paste()
        setMode(_MODE.EDIT)
    }
return

;[N] wキー (; -> Ctrl + w)
;[E] 1単語右に移動
;[R] 選択範囲を1単語右に移動
;[M] 中央上のエリアにフォーカスとポインタを移してNORMALモードに
;[S] アクティブウィンドウを中央上に最大化して移動する
$w::
    if (modes("N")) {
        if (2K(";")) {
            send ^w
        } else {
            send w
        }
    } else if (modes("E")) {
        send ^{Right}
    } else if (modes("R")) {
        send ^+{Right}
    } else if (modes("M")) {
        ActivateWindow("CenterUp")
        setMode(_MODE.NORMAL)
        MoveCenterInActiveWindow()
    } else if (modes("S")) {
        MoveWindow("CenterUp")
    }
return

;[N]  xキー (; -> 【】)
;[ER] Ctrl + xキー ＆ モードをEDITに
;[M]  中央特殊エリアにフォーカスとポインタを移してモードをNORMALに
;[S]  ウィンドウリサイズ特殊キー
$x::
    if (modes("N")) {
        if (2K(";")) {
            sendMultiByte("【】")
            Sleep 50
            send {left}
        } else {
            send x
        }
    } else if (modes("ER")) {
        setMode(_MODE.EDIT)
        send ^x
    } else if (modes("M")) {
        ActivateWindow("CenterSpecial")
        setMode(_MODE.NORMAL)
        MoveCenterInActiveWindow()
    } else if (modes("S")) {
        MoveWindow("CenterSpecial")
    }
return

;[N] yキー (; -> ->)
;[E] Redo
$y::
    if (modes("N")) {
        if (2K(";")) {
            send {space}->{space}
        } else {
            send y
        }
    } else if (modes("E")) {
        send ^y
    }
return

;[N] zキー (; -> !)
;[E] Undo
;[M] 左特殊エリアにフォーカスとポインタを移してモードをNORMALに
;[S] ウィンドウリサイズ特殊キー (; -> restサイズ)
$z::
    if (modes("N")) {
        if (2K(";")) {
            send {!}
        } else {
            send z
        }
    } else if (modes("E")) {
        send ^z
    } else if (modes("M")) {
        ActivateWindow("LeftSpecial")
        setMode(_MODE.NORMAL)
        MoveCenterInActiveWindow()
    } else if (modes("S")) {
        if (2K(";")) {
            MoveWindow("LeftSpecialRest")
        } else {
            MoveWindow("LeftSpecial")
        }
    }
return
