;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 画面設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ウィンドウ(Emacs用語ではframe)設定
(setq default-frame-alist
      (append (list
               ;; サイズ・位置
               '(width . 160)  ; 横幅(文字数)
               '(height . 60) ; 高さ(行数)
               '(top . 0)    ; フレーム左上角 y 座標
               '(left . 0)   ; フレーム左上角 x 座標
               )
              default-frame-alist))

;; erase memubar, scrollbar
(menu-bar-mode -1)       ;画面上に出るメニュー(文字)を消す
(tool-bar-mode -1)       ;画面上に出るツールバー(アイコン画像)を消す
;(scroll-bar-mode -1)    ;画面横に出るスクロールバーを消す
(setq inhibit-startup-message t) ;スプラッシュ(起動画面)抑止

;; フォント設定
(set-default-font "Courier New-9")
(set-fontset-font (frame-parameter nil 'font)
                                    'japanese-jisx0208
                                    '("ＭＳ ゴシック" . "unicode-bmp"))
(set-face-attribute 'fixed-pitch    nil :family "東風ゴシック") ;; 固定等幅フォント
(set-face-attribute 'variable-pitch nil :family "東風ゴシック") ;; 可変幅フォント
(add-to-list 'default-frame-alist '(font . "東風ゴシック-9"))
;(set-default-font "ＭＳ ゴシック-10")

;; color
(global-font-lock-mode t)  ;font-lock use-all
(transient-mark-mode t)    ;選択したとき色がつくようにする

;; kill-ring はテキスト属性（色情報など）を保存しなくていい
;;  http://www-tsujii.is.s.u-tokyo.ac.jp/~yoshinag/tips/elisp_tips.html#yankoff
(defadvice kill-new (around my-kill-ring-disable-text-property activate)
  (let ((new (ad-get-arg 0)))
    (set-text-properties 0 (length new) nil new)
    ad-do-it))

;; タブ, 全角スペースを色つき表示する (色名は M-x list-color-displayで調べる)
;;  http://homepage1.nifty.com/blankspace/emacs/color.html
;; 　	
(defface my-face-b-1 '((t (:background "LightGray"))) nil)
(defface my-face-b-2 '((t (:background "ghost white"))) nil)
(defface my-face-u-1 '((t (:foreground "LightSkyBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-b-2 append)
     ("　" 0 my-face-b-1 append)
     ("[ \t]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;; elisp変数表示のとき途中で省略しない
(setq eval-expression-print-level nil)
(setq eval-expression-print-length nil)
