;;;; -*- mode: emacs-lisp; coding: iso-2022-7bit -*-
;;;;
;;;; Copyright (C) 2001 The Meadow Team

;; Author: Koichiro Ohba <koichiro@meadowy.org>
;;      Kyotaro HORIGUCHI <horiguti@meadowy.org>
;;      Hideyuki SHIRAI <shirai@meadowy.org>
;;      KOSEKI Yoshinori <kose@meadowy.org>
;;      and The Meadow Team.


;; ;;; Mule-UCS の設定
;; ;; ftp://ftp.m17n.org/pub/mule/Mule-UCS/ が オフィシャルサイトですが、
;; ;; http://www.meadowy.org/~shirai/elisp/mule-ucs.tar.gz に既知のパッチ
;; ;; をすべて適用したものがおいてあります。
;; ;; (set-language-environment) の前に設定します
;; (require 'jisx0213)


;;; 日本語環境設定
(set-language-environment "Japanese")


;;; IMEの設定
(mw32-ime-initialize)
(setq default-input-method "MW32-IME")
(setq-default mw32-ime-mode-line-state-indicator "[--]")
(setq mw32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
(add-hook 'mw32-ime-on-hook
	  (function (lambda () (set-cursor-height 2))))
(add-hook 'mw32-ime-off-hook
	  (function (lambda () (set-cursor-height 4))))

;; `C-o' で IME をトグルするための設定
;; デフォルトで `M-\' または`漢字'キー(<kanji>)でもトグルできる
(global-set-key "\C-o" 'toggle-input-method)

;; ;;; カーソルの設定
;; ;; (set-cursor-type 'box)            ; Meadow-1.10互換 (SKK等で色が変る設定)
;; ;; (set-cursor-type 'hairline-caret) ; 縦棒キャレット


;;; マウスカーソルを消す設定
(setq w32-hide-mouse-on-key t)
(setq w32-hide-mouse-timeout 5000)


;;----タブと全角スペースに色付け
(defface my-face-b-1 '((t (:background "gray"))) nil)
;;(defface my-face-b-2 '((t (:background "DarkSeaGreen1"))) nil)
(defface my-face-b-2 '((t (:background "#DDFFDD"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
     ("　" 0 my-face-b-1 append)
     ("\t" 0 my-face-b-2 append)
     ("[ ]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks '(lambda ()
(if font-lock-mode
nil
(font-lock-mode t))) t)

;;; font-lockの設定
(global-font-lock-mode t)


;; ;;; TrueType フォント設定
;; (w32-add-font
;;  "private-fontset"
;;  '((spec
;;     ((:char-spec ascii :height 120)
;;      strict
;;      (w32-logfont "Courier New" 0 -13 400 0 nil nil nil 0 1 3 49))
;;     ((:char-spec ascii :height 120 :weight bold)
;;      strict
;;      (w32-logfont "Courier New" 0 -13 700 0 nil nil nil 0 1 3 49))
;;     ((:char-spec ascii :height 120 :slant italic)
;;      strict
;;      (w32-logfont "Courier New" 0 -13 400 0   t nil nil 0 1 3 49))
;;     ((:char-spec ascii :height 120 :weight bold :slant italic)
;;      strict
;;      (w32-logfont "Courier New" 0 -13 700 0   t nil nil 0 1 3 49))
;;     ((:char-spec japanese-jisx0208 :height 120)
;;      strict
;;      (w32-logfont "ＭＳ ゴシック" 0 -16 400 0 nil nil nil 128 1 3 49))
;;     ((:char-spec japanese-jisx0208 :height 120 :weight bold)
;;      strict
;;      (w32-logfont "ＭＳ ゴシック" 0 -16 700 0 nil nil nil 128 1 3 49)
;;      ((spacing . -1)))
;;     ((:char-spec japanese-jisx0208 :height 120 :slant italic)
;;      strict
;;      (w32-logfont "ＭＳ ゴシック" 0 -16 400 0   t nil nil 128 1 3 49))
;;     ((:char-spec japanese-jisx0208 :height 120 :weight bold :slant italic)
;;      strict
;;      (w32-logfont "ＭＳ ゴシック" 0 -16 700 0   t nil nil 128 1 3 49)
;;      ((spacing . -1))))))

;; (set-face-attribute 'variable-pitch nil :family "*")


;; ;;; BDF フォント設定
;;
;; ;;; (方法その1) Netinstall パッケージを使う方法
;; ;;; misc と intlfonts パッケージを入れます。
;; ;;; .emacsの設定
;; (setq bdf-use-intlfonts16 t)
;; (setq initial-frame-alist '((font . "intlfonts16")))
;;
;; ;;; (方法その1') 
;; ;;; intlfonts-file-16dot-alist の形式で bdf-fontset-alist を書き、
;; ;;; 次を設定すれば良い。
;; ;;;  (require 'bdf)
;; ;;;  (bdf-configure-fontset "bdf-fontset" bdf-fontset-alist)
;; ;;; 詳細は $MEADOW/pkginfo/auto-autoloads.el と $MEADOW/site-lisp/bdf.el を
;; ;;; 参照のこと。
;;
;; ;;; (方法その2) 
;; ;;; フォントの指定方法は次のサンプルを参考にする。
;; ;;; normal, bold, italic, bold-itaric フォントを指定する必要あり。
;; (setq bdf-font-directory "c:/Meadow/fonts/intlfonts/")
;; (w32-add-font "bdf-fontset"
;; `((spec 
;;    ;; ascii
;;    ((:char-spec ascii :height any :weight normal :slant normal)
;;     strict (bdf-font ,(expand-file-name "lt1-16-etl.bdf" bdf-font-directory)))
;;    ((:char-spec ascii :height any :weight bold :slant normal)
;;     strict (bdf-font ,(expand-file-name "lt1-16b-etl.bdf" bdf-font-directory)))
;;    ((:char-spec ascii :height any :weight normal :slant any)
;;     strict (bdf-font ,(expand-file-name "lt1-16i-etl.bdf" bdf-font-directory)))
;;    ((:char-spec ascii :height any :weight bold :slant any)
;;     strict (bdf-font ,(expand-file-name "lt1-16bi-etl.bdf" bdf-font-directory)))
;;    ;; katakana-jisx0201
;;    ((:char-spec katakana-jisx0201 :height any :weight normal :slant normal)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))
;;     ((encoding . 1-byte-set-msb))) 
;;    ((:char-spec katakana-jisx0201 :height any :weight bold :slant normal)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))
;;     ((encoding . 1-byte-set-msb))) 
;;    ((:char-spec katakana-jisx0201 :height any :weight normal :slant any)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))
;;     ((encoding . 1-byte-set-msb))) 
;;    ((:char-spec katakana-jisx0201 :height any :weight bold :slant any)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))
;;     ((encoding . 1-byte-set-msb)))
;;    ;; latin-jisx0201
;;    ((:char-spec latin-jisx0201 :height any :weight normal :slant normal)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory)))
;;    ((:char-spec latin-jisx0201 :height any :weight bold :slant normal)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory)))
;;    ((:char-spec latin-jisx0201 :height any :weight normal :slant any) 
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))) 
;;    ((:char-spec latin-jisx0201 :height any :weight bold :slant any) 
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory)))
;;    ;; japanese-jisx0208
;;    ((:char-spec japanese-jisx0208 :height any :weight normal :slant normal) 
;;     strict (bdf-font ,(expand-file-name "j90-16.bdf" bdf-font-directory)))
;;    ((:char-spec japanese-jisx0208 :height any :weight bold :slant normal)
;;     strict (bdf-font ,(expand-file-name "j90-16.bdf" bdf-font-directory))) 
;;    ((:char-spec japanese-jisx0208 :height any :weight normal :slant any)
;;     strict (bdf-font ,(expand-file-name "j90-16.bdf" bdf-font-directory)))
;;    ((:char-spec japanese-jisx0208 :height any :weight bold :slant any)
;;     strict (bdf-font ,(expand-file-name "j90-16b.bdf" bdf-font-directory))))))

(setq scheme-program-name "gosh -i")

(defun setFont (fn sz efn esz)
	     (let (fsn fss efsn )
	       (setq fsn (format "%s %d" fn sz))
		   (setq efsn (format "%s %d" efn esz))
	       (setq sz (- sz))
		   (setq esz (- esz))
	       (setq fss
		     `((spec
			((:char-spec ascii :height any)
			 strict
			 (w32-logfont ,efn 0 ,esz 400 0 nil nil nil 0 1 3 49))
			((:char-spec ascii :height any :weight bold)
			 strict
			 (w32-logfont ,efn 0 ,esz 700 0 nil nil nil 0 1 3 49)
			 ((spacing . -1)))
			((:char-spec ascii :height any :slant italic)
			 strict
			 (w32-logfont ,efn 0 ,esz 400 0   t nil nil 0 1 3 49))
			((:char-spec ascii :height any :weight bold :slant italic)
			 strict
			 (w32-logfont ,efn 0 ,esz 700 0   t nil nil 0 1 3 49)
			 ((spacing . -1)))
			((:char-spec japanese-jisx0208 :height any)
			 strict
			 (w32-logfont ,fn 0 ,sz 400 0 nil nil nil 128 1 3 49))
			((:char-spec japanese-jisx0208 :height any :weight bold)
			 strict
			 (w32-logfont ,fn 0 ,sz 700 0 nil nil nil 128 1 3 49)
			 ((spacing . -1)))
			((:char-spec japanese-jisx0208 :height any :slant italic)
			 strict
			 (w32-logfont ,fn 0 ,sz 400 0   t nil nil 128 1 3 49))
			((:char-spec japanese-jisx0208 :height any :weight bold :slant italic)
			 strict
			 (w32-logfont ,fn 0 ,sz 700 0   t nil nil 128 1 3 49)
			 ((spacing . -1))))))
	       (if (w32-list-fonts fsn)
		   (w32-change-font fsn fss)
		 (w32-add-font fsn fss))
	       ))

(setFont "MS Gothic" 8 "MS Gothic" 8)
(setFont "IPAゴシック" 8 "Anonymous" 5)
(setFont "IPAゴシック" 10 "Anonymous" 7)
(setFont "IPAゴシック" 12 "Anonymous" 9)
(setFont "IPAゴシック" 14 "Anonymous" 11)
(setFont "IPAゴシック" 16 "Anonymous" 13)
(setFont "IPAゴシック" 18 "Anonymous" 15)
(setFont "IPAゴシック" 20 "Anonymous" 17)
(setFont "IPAゴシック" 22 "Anonymous" 19)
(setFont "IPAゴシック" 24 "Anonymous" 21)

;(w32-query-get-logfont)
;eval-expression-print-level と eval-expression-print-length をnilに
;; ;;; TrueType フォント設定
(w32-add-font
  "private-fontset"
  '((spec
     ((:char-spec ascii :height any)
      strict
      (w32-logfont "Anonymous" 0 -11 400 0 nil nil nil 0 1 3 49)
	  )
     ((:char-spec ascii :height any :weight bold)
      strict
      (w32-logfont "Anonymous" 0 -11 700 0 nil nil nil 0 1 3 49)
	  )
     ((:char-spec ascii :height any :slant italic)
      strict
      (w32-logfont "Anonymous" 0 -11 400 0 t nil nil 0 1 3 49)
	  )
     ((:char-spec ascii :height any :weight bold :slant italic)
      strict
      (w32-logfont "Anonymous" 0 -11 700 0 t nil nil 0 1 3 49)
	  ((spacing . -1)))
     ((:char-spec japanese-jisx0208 :height any)
      strict
      (w32-logfont "IPAゴシック" 0 -14 400 0 nil nil nil 128 1 3 49)
	  )
     ((:char-spec japanese-jisx0208 :height any :weight bold)
      strict
      (w32-logfont "IPAゴシック" 0 -14 700 0 nil nil nil 128 1 3 49)
      )
     ((:char-spec japanese-jisx0208 :height any :slant italic)
      strict
      (w32-logfont "IPAゴシック" 0 -14 400 0   t nil nil 128 1 3 49)
	  )
     ((:char-spec japanese-jisx0208 :height any :weight bold :slant italic)
      strict
      (w32-logfont "IPAゴシック" 0 -14 700 0   t nil nil 128 1 3 49)
      ((spacing . -1))))))


(w32-add-font
  "small-fontset"
  '((spec
     ((:char-spec ascii :height any)
      strict
      (w32-logfont "Anonymous" 0 -9 400 0 nil nil nil 0 1 3 49))
     ((:char-spec ascii :height any :weight bold)
      strict
      (w32-logfont "Anonymous" 0 -9 700 0 nil nil nil 0 1 3 49))
     ((:char-spec ascii :height any :slant italic)
      strict
      (w32-logfont "Anonymous" 0 -9 400 0 t nil nil 0 1 3 49))
     ((:char-spec ascii :height any :weight bold :slant italic)
      strict
      (w32-logfont "Anonymous" 0 -9 700 0 t nil nil 0 1 3 49))
     ((:char-spec japanese-jisx0208 :height any)
      strict
      (w32-logfont "IPAゴシック" 0 -12 400 0 nil nil nil 128 1 3 49))
     ((:char-spec japanese-jisx0208 :height any :weight bold)
      strict
      (w32-logfont "IPAゴシック" 0 -12 700 0 nil nil nil 128 1 3 49)
      ((spacing . -1)))
     ((:char-spec japanese-jisx0208 :height any :slant italic)
      strict
      (w32-logfont "IPAゴシック" 0 -12 400 0   t nil nil 128 1 3 49))
     ((:char-spec japanese-jisx0208 :height any :weight bold :slant italic)
      strict
      (w32-logfont "IPAゴシック" 0 -12 700 0   t nil nil 128 1 3 49)
      ((spacing . -1))))))


;; 初期フレームの設定
(setq default-frame-alist
      (append (list '(foreground-color . "black")
;;		    '(background-color . "LemonChiffon")
;;		    '(background-color . "#FFFFFF")
;;		    '(background-color . "gray")
		    '(background-color . "white")
		    '(border-color . "black")
		    '(mouse-color . "white")
		    '(cursor-color . "black")
;;		    '(ime-font . (w32-logfont "ＭＳ ゴシック"
;;					      0 16 400 0 nil nil nil
;;					      128 1 3 49)) ; TrueType のみ
;;		    '(font . "bdf-fontset")    ; BDF
		    '(font . "default"); TrueType
		    '(width . 136)
		    '(height . 55)
		    '(top . 10)
		    '(left . 80))
	      default-frame-alist))


;; ;;; shell の設定

;; ;;; Cygwin の bash を使う場合
(setq explicit-shell-file-name "bash")
(setq shell-file-name "sh")
(setq shell-command-switch "-c") 

;; ;;; Virtually UN*X!にある tcsh.exe を使う場合
;; (setq explicit-shell-file-name "tcsh.exe") 
;; (setq shell-file-name "tcsh.exe") 
;; (setq shell-command-switch "-c") 

;; ;;; WindowsNT に付属の CMD.EXE を使う場合。
;; (setq explicit-shell-file-name "CMD.EXE") 
;; (setq shell-file-name "CMD.EXE") 
;; (setq shell-command-switch "\\/c") 


;;; argument-editing の設定
(require 'mw32script)
(mw32script-init)


;; ;;; browse-url の設定
;; (global-set-key [S-mouse-2] 'browse-url-at-mouse)


;; ;;; 印刷の設定
;; ;; この設定で M-x print-buffer RET などでの印刷ができるようになります
;; ;;
;; ;;  notepad に与えるパラメータの形式の設定
;; (define-process-argument-editing "notepad"
;;   (lambda (x) (general-process-argument-editing-function x nil t)))
;;
;; (defun w32-print-region (start end
;; 				  &optional lpr-prog delete-text buf display
;; 				  &rest rest)
;;   (interactive)
;;   (let ((tmpfile (convert-standard-filename (buffer-name)))
;; 	   (w32-start-process-show-window t)
;; 	   ;; もし、dos 窓が見えていやな人は上記の `t' を `nil' にします
;; 	   ;; ただし、`nil' にすると Meadow が固まる環境もあるかもしれません
;; 	   (coding-system-for-write w32-system-coding-system))
;;     (while (string-match "[/\\]" tmpfile)
;; 	 (setq tmpfile (replace-match "_" t nil tmpfile)))
;;     (setq tmpfile (expand-file-name (concat "_" tmpfile "_")
;; 				       temporary-file-directory))
;;     (write-region start end tmpfile nil 'nomsg)
;;     (call-process "notepad" nil nil nil "/p" tmpfile)
;;     (and (file-readable-p tmpfile) (file-writable-p tmpfile)
;; 	    (delete-file tmpfile))))
;; 
;; (setq print-region-function 'w32-print-region)

;; ;;; fakecygpty の設定
;; ;; この設定で cygwin の仮想端末を要求するプログラムを Meadow から
;; ;; 扱えるようになります
;; (setq mw32-process-wrapper-alist
;;       '(("/\\(bash\\|tcsh\\|svn\\|ssh\\|gpg[esvk]?\\)\\.exe" .
;; 	  (nil . ("fakecygpty.exe" . set-process-connection-type-pty)))))

;;;

;;; C-h を backspace として使う。
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)

;;; go next-visual-line
(global-set-key "\C-p" 'previous-window-line)
(global-set-key "\C-n" 'next-window-line)
(global-set-key [up] 'previous-window-line)
(global-set-key [down] 'next-window-line)

(defun previous-window-line (n)
  (interactive "p")
  (let ((cur-col
     (- (current-column)
        (save-excursion (vertical-motion 0) (current-column)))))
    (vertical-motion (- n))
    (move-to-column (+ (current-column) cur-col)))
  (run-hooks 'auto-line-hook)
  )

(defun next-window-line (n)
  (interactive "p")
  (let ((cur-col
     (- (current-column)
        (save-excursion (vertical-motion 0) (current-column)))))
    (vertical-motion n)
    (move-to-column (+ (current-column) cur-col)))
  (run-hooks 'auto-line-hook)
  )

(custom-set-variables
 '(initial-scratch-message ""))

;;ツールバーを表示しない
(tool-bar-mode 0)
(menu-bar-mode 0)
(setq elscreen-display-tab nil)
(setq elscreen-tab-display-create-screen nil)
(setq elscreen-tab-display-kill-screen nil)

;; 特定のモードでのみ有効にする
;; 外部で編集されたファイルの自動読み込み
;; VisualStudioと共通のファイルを編集する時用
(add-hook 'c-mode-hook 'turn-on-auto-revert-mode)

;(require 'gnuserv)
;(gnuserv-start)
;(setq gnuserv-frame (selected-frame))

;--- GNU GLOBAL(gtags) gtags.el ---
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
	   (local-set-key "\M-t" 'gtags-find-tag)     ;関数の定義元へ
	   (local-set-key "\M-r" 'gtags-find-rtag)    ;関数の参照先へ
	   (local-set-key "\M-s" 'gtags-find-symbol)  ;変数の定義元/参照先へ
	   (local-set-key "\C-t" 'gtags-pop-stack)  ;前のバッファに戻る
	  ))
;
(global-set-key "\C-cgt" 'gtags-find-tag)    ;関数の定義元へ
(global-set-key "\C-cgr" 'gtags-find-rtag)   ;関数の参照先へ
(global-set-key "\C-cgs" 'gtags-find-symbol) ;変数の定義元/参照先へ
(global-set-key "\C-cgf" 'gtags-find-file)
(global-set-key "\C-cgp" 'gtags-find-pattern)
(global-set-key "\C-cg." 'gtags-find-tag-from-here)
(global-set-key "\C-cg*" 'gtags-pop-stack)
(global-set-key "\C-c*" 'gtags-pop-stack)    ;前のバッファに戻る
;(global-set-key "\C-cg" 'gtags-mode)

(setq c-mode-hook
   '(lambda ()
       (gtags-mode 1)
;;	   (gtags-make-complete-list)
	))

;---- cygwin-mount ----
(when (and (featurep 'meadow) (locate-library "cygwin-mount"))
  (require 'cygwin-mount)
  (cygwin-mount-activate))

(setq default-tab-width 4)

;;
;; howm
;;
(setq howm-menu-lang 'ja)
(require 'howm)

;; BackSpace キーを「賢く」し，インデント幅は4桁
(add-hook 'c-mode-common-hook
     	  '(lambda ()
             (progn
               (c-toggle-hungry-state 1)
               (setq c-basic-offset 4))))

(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/backup"))
            backup-directory-alist))


(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pyw$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)


;;(defconst *dmacro-key* [?\M-t] "繰返し指定キー")
;;(global-set-key *dmacro-key* 'dmacro-exec)
;;(autoload 'dmacro-exec "dmacro" nil t)

;;行末で折り返さない
(setq truncate-lines 'f)

;;iswitchbを使う
(iswitchb-mode)


;;iswitchb使用中に選択bufferをwindowに表示
(defadvice iswitchb-exhibit
  (after
   iswitchb-exhibit-with-display-buffer
   activate)
  "選択している buffer を window に表示してみる。"
  (when (and
         (eq iswitchb-method iswitchb-default-method)
         iswitchb-matches)
    (select-window
     (get-buffer-window (cadr (buffer-list))))
    (let ((iswitchb-method 'samewindow))
      (iswitchb-visit-buffer
       (get-buffer (car iswitchb-matches))))
    (select-window (minibuffer-window))))

(add-to-list 'iswitchb-buffer-ignore "*GTAGS SELECT*")

;;uniq
(defun uniq-region (beg end)
  "Remove duplicate lines, a` la Unix uniq.
   If tempted, you can just do <<C-x h C-u M-| uniq RET>> on Unix."
  (interactive "r")
  (let ((ref-line nil))
      (uniq beg end 
	       (lambda (line) (string= line ref-line)) 
	       (lambda (line) (setq ref-line line)))))

(defun uniq-remove-dup-lines (beg end)
  "Remove all duplicate lines wherever found in a file, rather than
   just contiguous lines."
  (interactive "r")
  (let ((lines '()))
    (uniq beg end 
	     (lambda (line) (assoc line lines)) 
	     (lambda (line) (add-to-list 'lines (cons line t))))))

(defun uniq (beg end test-line add-line)
  (save-excursion
    (narrow-to-region beg end)
    (goto-char (point-min))
    (while (not (eobp))
      (if (funcall test-line (thing-at-point 'line))
	  (kill-line 1)
	(progn
	  (funcall add-line (thing-at-point 'line))
	  (forward-line))))
    (widen)))

;; ;; migemo基本設定
;; (setq migemo-command "cmigemo")
;; (setq migemo-options '("-q" "--emacs"))
;; ;; migemo-dict のパスを指定
;; (setq migemo-dictionary "c:/cygwin/dict/migemo-dict")
;; (setq migemo-user-dictionary nil)
;; (setq migemo-regex-dictionary nil)

;; ;; キャッシュ機能を利用する
;; (setq migemo-use-pattern-alist t)
;; (setq migemo-use-frequent-pattern-alist t)
;; (setq migemo-pattern-alist-length 1024)
;; ;; 辞書の文字コードを指定．
;; ;; バイナリを利用するなら，このままで構いません
;; (setq migemo-coding-system 'shift_jis-unix)

;; (load-library "migemo")
;; ;; 起動時に初期化も行う
;; (migemo-init)


;(require 'color-moccur)

;;-------------拾ったelisp-----------
;; 単語を kill-ring に save する
(defun word-kill-ring-save (count-word)
  "Save the word under cursor into kill-ring, but don't kill it."
  (interactive "p")
  (save-excursion
	(let (
		  (beg (progn (forward-sexp 1) (backward-sexp 1) (point)))
		  (end (progn (forward-sexp count-word) (point)))
		  )
	  (goto-char beg)
	  (kill-ring-save beg end)
	  )
	)
)
(global-set-key [(control shift \w)] 'word-kill-ring-save)

;;ミニバッファの履歴を自動保存
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;;右端で折り返さない
(setq truncate-lines t)
;;frame分割時右端で折り返さない
(setq truncate-partial-width-windows t)
;;-------------keybind---------------
(global-set-key [(control shift \g)] 'moccur-grep-find)

;;-------------scheme-info-bind------
(eval-after-load "info-look"
  '(progn
     (info-lookup-add-help
      :topic 'symbol
      :mode 'scheme-mode
      :regexp "[^()`',\"\t\n]+"
      :ignore-case t
      :doc-spec '(("(gauche-refj.info)Index - 手続きと構文索引" nil
                   "^ -+ [^:]+: *" "[\n ]")
                  ("(gauche-refj.info)Index - モジュール索引" nil
                   "^ -+ [^:]+: *" "[\n ]")
                  ("(gauche-refj.info)Index - クラス索引" nil
                   "^ -+ [^:]+: *" "[\n ]")
                  ("(gauche-refj.info)Index - 変数索引" nil
                   "^ -+ [^:]+: *" "[\n ]"))
      :parse-rule "[^()`',\" \t\n]+"
      :other-modes nil)

     (info-lookup-add-help
      :mode 'inferior-scheme-mode
      :other-modes '(scheme-mode))
))

;;-------------windows---------------
 	

;; キーバインドを変更．
;; デフォルトは C-c C-w
;; 変更しない場合」は，以下の 3 行を削除する
(setq win:switch-prefix "\C-z")
(define-key global-map win:switch-prefix nil)
(define-key global-map "\C-z1" 'win-switch-to-window)
(require 'windows)
;; 新規にフレームを作らない
(setq win:use-frame nil)
(win:startup-with-window)
(define-key ctl-x-map "C" 'see-you-again)

;;スペースで始まるバッファも保存
(setq revive:ignore-buffer-pattern "^ \\*")

;;kill-summary
;;M-x kill-summary
(autoload 'kill-summary "kill-summary" nil t)

;;ミニバッファをインクリメンタルサーチ
(require 'minibuf-isearch)


;;isearchの検索結果に色を付けたままにする。色を残したい時にC-l
(require 'hi-lock)

(defun highlight-isearch-word ()
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (isearch-exit)
    (hi-lock-face-buffer-isearch
     (if (and (featurep 'migemo) migemo-isearch-enable-p)
         (migemo-get-pattern isearch-string)
       isearch-string))))

;;; ;;; *scratch*バッファを消さない
(defun my-make-scratch (&optional arg)
  (interactive)
  (progn
    ;; "*scratch*" を作成して buffer-list に放り込む
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))
(add-hook 'kill-buffer-query-functions
          ;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
          (lambda ()
            (if (string= "*scratch*" (buffer-name))
                (progn (my-make-scratch 0) nil)
              t)))
(add-hook 'after-save-hook
          ;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
          (lambda ()
            (unless (member (get-buffer "*scratch*") (buffer-list))
              (my-make-scratch 1))))

(defun hi-lock-face-buffer-isearch (regexp)
  (interactive)
  (let ((face
         (hi-lock-read-face-name)))
    (or (facep face) (setq face 'rwl-yellow))
    (unless hi-lock-mode (hi-lock-mode))
    (hi-lock-set-pattern
     (list regexp (list 0 (list 'quote face) t)))))

(define-key isearch-mode-map (kbd "C-l") 'highlight-isearch-word)


;;-------------自作elisp-------------

;; 時刻を挿入して改行。
(defun intime () (interactive) (insert (format-time-string "[%Y-%m-%d %H:%M]")))
(global-set-key [(control return)] 'intime)

;;カーソル位置までハイフンを入力
(defun inshi ()(interactive)(let ((i 0)(ppp (current-column)))
  (while (<= i ppp)
    (insert "-")
    (setq i (1+ i)))))

;;Macro:カーソル直後の文字列1行を囲う
(fset 'kakou
   [?/ ?* ?\C-q tab ?\C-e ?\C-q tab ?* ?/ ?\C-  ?\C-[ ?x ?i ?n ?s ?h ?i return ?\C-x ?\C-x ?\C-m ?/ ?* ?\C-e ?\C-? ?\C-? ?\C-? ?\C-? ?\C-? ?* ?/ ?\C-a ?\C-k ?\C-k ?\C-y ?\C-p ?\C-p ?\C-y ?\C-n ?\C-n])
(fset 'kakou2
   [?/ ?* ?\C-q tab ?\C-e ?\C-q tab ?* ?/ ?\C-a ?\C-k ?\C-y ?\C-m ?\C-y ?\C-m ?\C-y ?\C-a ?\C-p ?\C-p ?\C-  ?\C-e ?\C-[ ?x ?u ?n ?t ?a tab return ?\C-a ?\C-  ?\C-  ?\C-e ?\C-[ ?x ?r ?e ?p ?l ?a tab ?r ?e ?g tab return ?. return ?- return ?\C-a ?\C-n ?\C-n ?\C-  ?\C-  ?\C-e ?\C-[ ?x ?u ?n ?t ?a tab return ?\C-  ?\C-  ?\C-a ?\C-[ ?x ?r ?e ?p ?l ?a tab ?r ?e tab ?g tab return ?. return ?- return ?\C-d ?\C-? ?* ?/ ?\C-a ?\C-d ?\C-d ?/ ?* ?\C-a ?\C-p ?\C-p ?\C-d ?\C-d ?/ ?* ?\C-e ?\C-? ?\C-? ?* ?/ ?\C-n ?\C-n ?\C-f])


;;;; YaTeX (野鳥)
;; yatex-mode を起動させる設定
(setq auto-mode-alist 
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;; LaTeX コマンド、プレビューワ、プリンタなどの設定
(setq tex-command "platex"
      dvi2-command "/cygdrive/c/tex/dviout/dviout -1 -Set=!m"
      dviprint-command-format "dvipsk %s | lpr"
      YaTeX-kanji-code 1   ; (1 SJIS, 2 JIS, 3 EUC) JIS(junet-unix)だとOS依存せずにコンパイルできる
      YaTeX-latex-message-code 'sjis  ; 改行に ^M がつかないようにする
      section-name "documentclass"
      makeindex-command "mendex"
      YaTeX-use-AMS-LaTeX t   ; AMS-LaTeXを使う
      YaTeX-use-LaTeX2e t     ; LaTeX2eを使う
      YaTeX-use-font-lock t   ; 色付け
      )
;; 自動改行を無効
(add-hook 'yatex-mode-hook'(lambda ()(setq auto-fill-function nil)))


;;リージョンを大文字にするときに確認(y/n)を表示しない
(put 'upcase-region 'disabled nil)

;;リージョンのLineを数えて挿入
(defun count-lines-region-in (start end)
  "Print number of lines and characters in the region."
  (interactive "r")
  (insert   (int-to-string (count-lines start end))))

;;現バッファを秀丸で開く
(defun open-hidemaru (pos)
  (interactive "d")
  (shell-command (concat "c:/Program\\ Files/hidemaru/hidemaru.exe" " /j" (int-to-string (line-number-at-pos pos)) "," (int-to-string (+ 1 (current-column))) " '" buffer-file-name "'")))
(global-set-key "\C-c\C-o" 'open-hidemaru)

;;現リージョンを16進数に変換
(defun dectohex ()
  (interactive )
  (insert (format "0x%03X" (string-to-int (car kill-ring)))))

(setq visible-bell t)

;(howm-menu)
;;; end of file
;;;

(put 'narrow-to-region 'disabled nil)
