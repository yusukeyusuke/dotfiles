﻿# -*- mode: python; coding: utf-8-with-signature-dos -*-

####################################################################################################
## ブラウザをポップアップしてから、ブラウザのショートカットキーを入力するキーを設定する
####################################################################################################

try:
    # 設定されているか？
    fc.browser_list
except:
    # 本機能を適用するブラウザのプログラム名称を指定する
    fc.browser_list= ["chrome.exe",
                      "msedge.exe",
                      "firefox.exe",
                      ]

try:
    # 設定されているか？
    fc.browser_url
except:
    # ブラウザが起動していない場合に開く URL を指定する
    # fc.browser_url = r"https://www.google.com/"
    fc.browser_url = r"https://"

try:
    # 設定されているか？
    fc.browser_key1
except:
    # ブラウザをポップアップし、アドレスバーに移動するキーを指定する（IME は OFF）
    fc.browser_key1 = "C-A-i" # C-A-l は VSCode Extension で利用しているため使わない

try:
    # 設定されているか？
    fc.browser_key2
except:
    # ブラウザをポップアップし、新しいタブを開くキーを指定する（IME は OFF）
    fc.browser_key2 = "C-A-t"

try:
    # 設定されているか？
    fc.browser_key3
except:
    # ブラウザをポップアップし、新しいウィンドウを開くキーを指定する（IME は OFF）
    fc.browser_key3 = "C-A-o" # C-A-n は VSCode Extension で利用しているため使わない

# --------------------------------------------------------------------------------------------------

# ブラウザをポップアップしてから指定したキーを実行する
def browser_popup(key, ime_status, browser_list=fc.browser_list):
    def _func():
        def _inputKey():
            escape() # 検索状態になっていた場合に Esc で解除する
            self_insert_command(key)()
            setImeStatus(ime_status)

        if keymap.getWindow().getProcessName() in browser_list:
            _inputKey()
        else:
            for window in getWindowList():
                if window.getProcessName() in browser_list:
                    popWindow(window)()
                    keymap.delayedCall(_inputKey, 50)
                    break
            else:
                # browser_list に設定されているブラウザが起動していない場合、browser_url を開く
                keymap.ShellExecuteCommand(None, fc.browser_url, "", "")()
    return _func

define_key(keymap_global, fc.browser_key1, browser_popup("C-l", 0))
define_key(keymap_global, fc.browser_key2, browser_popup("C-t", 0))
define_key(keymap_global, fc.browser_key3, browser_popup("C-n", 0))

## config_personal.py ファイルの読み込み
exec(readConfigExtension(r"browser_key\config_personal.py", msg=False), dict(globals(), **locals()))
