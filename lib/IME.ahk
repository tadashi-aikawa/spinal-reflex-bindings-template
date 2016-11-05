/*****************************************************************************
  IME制御用 関数群 (IME.ahk)

    グローバル変数 : なし
    各関数の依存性 : なし(必要関数だけ切出してコピペでも使えます)

    AutoHotkey:     v1.0.46以降
    Language:       Japanease
    Platform:       Win9x/NT
    Author:         eamat.      http://www6.atwiki.jp/eamat/pub/MyScript/
*****************************************************************************
履歴
    2008.07.11 v1.0.47以降の 関数ライブラリスクリプト対応用にファイル名を変更
    2008.12.10 コメント修正
    2009.07.03 IME_GetConverting() 追加 
               Last Found Windowが有効にならない問題修正、他。
    2009.12.03 
      ・IME 状態チェック GUIThreadInfo 利用版 入れ込み
       （IEや秀丸8βでもIME状態が取れるように）
        http://blechmusik.xrea.jp/resources/keyboard_layout/DvorakJ/inc/IME.ahk
      ・Google日本語入力β 向け調整
        入力モード 及び 変換モードは取れないっぽい
        IME_GET/SET() と IME_GetConverting()は有効
*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;---------------------------------------------------------------------------
;  汎用関数 (多分どのIMEでもいけるはず)

;-----------------------------------------------------------
; IMEの状態の取得
;   WinTitle="A"    対象Window
;   戻り値          1:ON / 0:OFF
;-----------------------------------------------------------
IME_GET(WinTitle="A")  {
    VarSetCapacity(stGTI, 48, 0)
    NumPut(48, stGTI,  0, "UInt")   ;	DWORD   cbSize;
	hwndFocus := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
	             ? NumGet(stGTI,12,"UInt") : WinExist(WinTitle)

    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwndFocus)
          , UInt, 0x0283  ;Message : WM_IME_CONTROL
          ,  Int, 0x0005  ;wParam  : IMC_GETOPENSTATUS
          ,  Int, 0)      ;lParam  : 0
}

;-----------------------------------------------------------
; IMEの状態をセット
;   SetSts          1:ON / 0:OFF
;   WinTitle="A"    対象Window
;   戻り値          0:成功 / 0以外:失敗
;-----------------------------------------------------------
IME_SET(SetSts, WinTitle="A")    {
    VarSetCapacity(stGTI, 48, 0)
    NumPut(48, stGTI,  0, "UInt")   ;	DWORD   cbSize;
	hwndFocus := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
	             ? NumGet(stGTI,12,"UInt") : WinExist(WinTitle)

    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwndFocus)
          , UInt, 0x0283  ;Message : WM_IME_CONTROL
          ,  Int, 0x006   ;wParam  : IMC_SETOPENSTATUS
          ,  Int, SetSts) ;lParam  : 0 or 1
}