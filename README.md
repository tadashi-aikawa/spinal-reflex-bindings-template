Spinal reflex bindings template
================================


機能
----

思考の速度で操作するためのキーバインドセットです😄  

これはtadashi-aikawaが普段使用しているものです。  
テンプレートやフレームワーク、ライブラリではありません。

* 仮想キーボード
* コンビネーションキー
* マウスジェスチャー
* アプリケーションごとの設定変更


必要な環境
----------

* Windows 10
* [AutoHotkeyU64](http://ahkscript.org/download/)
* [IME.ahk](http://www6.atwiki.jp/eamat/pages/17.html) (bundled)
* `EnableUIAccess.ahk` (必要なら)


インストール
------------

```
$ git clone https://github.com/tadashi-aikawa/spinal-reflex-bindings-template.git
```

### 設定ファイル作成

ディレクトリの中に移動して`Settings.ini`を作ります。  
`FILE.name`には`settings`配下のファイル名(拡張子なし)を指定します。

```
[FILE]
name = home
```


実行
----

`Main.ahk`を実行します。


ファイル構成
------------

* `Main.ahk`
    * エントリポイント
* `AppUtils.ahk`
    * ユーティリティ
    * このスクリプトは何よりも先にincludeされる必要があります
* `ModeController.ahk`
    * 仮想キーボードのモード制御
* `MouseGesture.ahk`
    * マウスジェスチャーの実装
* `MouseUtils.ahk`
    * マウス操作のユーティリティ
* `Command.ahk`
    * 複雑名コマンドのラッパ
* `keybindings (Directory)`
    * `Alphabets.ahk`
        * アルファベットに関するキーバインド設定
    * `Numbers.ahk`
        * 数字に関するキーバインド設定
    * `Symbols.ahk`
        * 記号に関するキーバインド設定
    * `Others.ahk`
        * その他キーバインド設定
    * `Gesture.ahk`
        * マウスジェスチャーのバインド設定
* `settings (Directory)`
    * 環境毎の設定ファイル保存場所.


ライセンス
----------

### MIT

* 詳細は`LICENSE.txt`をご覧下さい

