;; -*- mode: lisp-interaction; syntax: elisp -*-
;;     Time-stamp: <Aug 28 2011>

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 日本語環境の設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-keyboard-coding-system 'japanese-shift-jis)
(setq default-input-method "W32-IME")
(w32-ime-initialize)

;; UTF-8⇔Legacy Encoding (EUC-JP や Shift_JIS など)をWindowsで変換
;;  http://nijino.homelinux.net/emacs/emacs23-ja.html
(coding-system-put 'euc-jp :encode-translation-table
                   (get 'japanese-ucs-cp932-to-jis-map 'translation-table))
(coding-system-put 'iso-2022-jp :encode-translation-table
                   (get 'japanese-ucs-cp932-to-jis-map 'translation-table))
(coding-system-put 'cp932 :encode-translation-table
                   (get 'japanese-ucs-jis-to-cp932-map 'translation-table))
;; charset と coding-system の優先度設定
(set-charset-priority 'ascii 'japanese-jisx0208 'latin-jisx0201
                      'katakana-jisx0201 'iso-8859-1 'cp1252 'unicode)
(set-coding-system-priority 'utf-8 'euc-jp 'iso-2022-jp 'cp932)
;; East Asian Ambiguous
(defun set-east-asian-ambiguous-width (width)
  (while (char-table-parent char-width-table)
    (setq char-width-table (char-table-parent char-width-table)))
  (let ((table (make-char-table nil)))
    (dolist (range
             '(#x00A1 #x00A4 (#x00A7 . #x00A8) #x00AA (#x00AD . #x00AE)
                      (#x00B0 . #x00B4) (#x00B6 . #x00BA) (#x00BC . #x00BF)
                      #x00C6 #x00D0 (#x00D7 . #x00D8) (#x00DE . #x00E1) #x00E6
                      (#x00E8 . #x00EA) (#x00EC . #x00ED) #x00F0 
                      (#x00F2 . #x00F3) (#x00F7 . #x00FA) #x00FC #x00FE
                      #x0101 #x0111 #x0113 #x011B (#x0126 . #x0127) #x012B
                      (#x0131 . #x0133) #x0138 (#x013F . #x0142) #x0144
                      (#x0148 . #x014B) #x014D (#x0152 . #x0153)
                      (#x0166 . #x0167) #x016B #x01CE #x01D0 #x01D2 #x01D4
                      #x01D6 #x01D8 #x01DA #x01DC #x0251 #x0261 #x02C4 #x02C7
                      (#x02C9 . #x02CB) #x02CD #x02D0 (#x02D8 . #x02DB) #x02DD
                      #x02DF (#x0300 . #x036F) (#x0391 . #x03A9)
                      (#x03B1 . #x03C1) (#x03C3 . #x03C9) #x0401 
                      (#x0410 . #x044F) #x0451 #x2010 (#x2013 . #x2016)
                      (#x2018 . #x2019) (#x201C . #x201D) (#x2020 . #x2022)
                      (#x2024 . #x2027) #x2030 (#x2032 . #x2033) #x2035 #x203B
                      #x203E #x2074 #x207F (#x2081 . #x2084) #x20AC #x2103
                      #x2105 #x2109 #x2113 #x2116 (#x2121 . #x2122) #x2126
                      #x212B (#x2153 . #x2154) (#x215B . #x215E) 
                      (#x2160 . #x216B) (#x2170 . #x2179) (#x2190 . #x2199)
                      (#x21B8 . #x21B9) #x21D2 #x21D4 #x21E7 #x2200
                      (#x2202 . #x2203) (#x2207 . #x2208) #x220B #x220F #x2211
                      #x2215 #x221A (#x221D . #x2220) #x2223 #x2225
                      (#x2227 . #x222C) #x222E (#x2234 . #x2237)
                      (#x223C . #x223D) #x2248 #x224C #x2252 (#x2260 . #x2261)
                      (#x2264 . #x2267) (#x226A . #x226B) (#x226E . #x226F)
                      (#x2282 . #x2283) (#x2286 . #x2287) #x2295 #x2299 #x22A5
                      #x22BF #x2312 (#x2460 . #x24E9) (#x24EB . #x254B)
                      (#x2550 . #x2573) (#x2580 . #x258F) (#x2592 . #x2595) 
                      (#x25A0 . #x25A1) (#x25A3 . #x25A9) (#x25B2 . #x25B3)
                      (#x25B6 . #x25B7) (#x25BC . #x25BD) (#x25C0 . #x25C1)
                      (#x25C6 . #x25C8) #x25CB (#x25CE . #x25D1) 
                      (#x25E2 . #x25E5) #x25EF (#x2605 . #x2606) #x2609
                      (#x260E . #x260F) (#x2614 . #x2615) #x261C #x261E #x2640
                      #x2642 (#x2660 . #x2661) (#x2663 . #x2665) 
                      (#x2667 . #x266A) (#x266C . #x266D) #x266F #x273D
                      (#x2776 . #x277F) (#xE000 . #xF8FF) (#xFE00 . #xFE0F) 
                      #xFFFD
                      ))
      (set-char-table-range table range width))
    (optimize-char-table table)
    (set-char-table-parent table char-width-table)
    (setq char-width-table table)))
(set-east-asian-ambiguous-width 2)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 画面設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ウィンドウ(Emacs用語ではframe)設定
(setq default-frame-alist
      (append (list
               ;; サイズ・位置
               '(width . 80)  ; 横幅(文字数)
               '(height . 46) ; 高さ(行数)
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

;; IMEのON/OFFでカーソルの色を変える
(set-cursor-color "black")
(add-hook 'w32-ime-on-hook
          (function (lambda () (set-cursor-color "LimeGreen"))))
(add-hook 'w32-ime-off-hook
          (function (lambda () (set-cursor-color "black"))))

;; elisp変数表示のとき途中で省略しない
(setq eval-expression-print-level nil)
(setq eval-expression-print-length nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 動作設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; tmp file saving directory
(setq auto-save-list-file-prefix "~/local/.emacs.d/.saves-")

;; backup.file~ location
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/local/.emacs.d"))
            backup-directory-alist))

;; 前回編集していた場所を記憶し，ファイルを開いた時にそこへカーソルを移動
(load "saveplace")
(setq-default save-place t)

;; auto-insert LAST-MODIFIED-DATE
(if (not (memq 'time-stamp write-file-hooks))
    (setq write-file-hooks
          (cons 'time-stamp write-file-hooks)))
(setq time-stamp-line-limit 40)
(setq time-stamp-format "%3b %02d %:y")
(setq system-time-locale "C")

;; beep
(setq visible-bell nil)

;; diff
(setq diff-switches "-u")

;; elisp load-path
(add-to-list 'load-path "~/.emacs.d")

;; dabbrev for japanese
(setq case-replace nil)             ;dabbrev exact (upper or lower)case
(setq dabbrev-case-fold-search nil) ;dabbrev exact case
;(load "dabbrev-ja")

;; "*Buffer List*" から動的補完する。
;;  Javaのclass名をファイルに付けたらファイルの中でも補完できるように。
(setq dabbrev-ignored-buffer-names '("*Messages*"))

;; cc-mode
(defun my-c-mode-common-hook ()
  (c-set-style "java")
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-to-list 'auto-mode-alist '("\\.c\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.pl\\'" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))

;;; js2-mode for JavaScript
;(autoload 'js2-mode "js2" nil t)
;(add-to-list 'auto-mode-alist '("\.js$" . js2-mode))

;;; actionscript-mode
;(autoload 'actionscript-mode "actionscript-mode" "Major mode for actionscript." t)
;(add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))

;;; php-mode
;(autoload 'php-mode "php-mode" nil t)
;(add-hook 'php-mode-hook
;          '(lambda () (define-abbrev php-mode-abbrev-table "ex" "extends")))
;(add-to-list 'auto-mode-alist '("\.php$" . php-mode))

;; org-mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-startup-truncated nil) ;;行の折り返し


(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)


;; URLをブラウザで開く
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "Z:/app/FirefoxPortable/FirefoxPortable.exe")



;;; Local Variables:
;;; coding: utf-8-unix
;;; End: