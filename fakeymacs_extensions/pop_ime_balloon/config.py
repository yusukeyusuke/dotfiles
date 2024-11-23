﻿# -*- mode: python; coding: utf-8-with-signature-dos -*-

####################################################################################################
## 指定したキーを押下したときに IME の状態を表示する
####################################################################################################

try:
    # 設定されているか？
    fc.pop_ime_balloon_key
except:
    # IME の状態を表示するキーを指定する
    fc.pop_ime_balloon_key = ["C-;"]

# --------------------------------------------------------------------------------------------------

for key in fc.pop_ime_balloon_key:
    define_key(keymap_emacs, key, lambda: showImeStatus(getImeStatus(), force=True))
    define_key(keymap_ime,   key, lambda: showImeStatus(getImeStatus(), force=True))
