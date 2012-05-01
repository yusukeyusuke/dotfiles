;;;; -*- mode: emacs-lisp; coding: iso-2022-7bit -*-
;;;;
;;;; Copyright (C) 2001 The Meadow Team

;; Author: Koichiro Ohba <koichiro@meadowy.org>
;;      Kyotaro HORIGUCHI <horiguti@meadowy.org>
;;      Hideyuki SHIRAI <shirai@meadowy.org>
;;      KOSEKI Yoshinori <kose@meadowy.org>
;;      and The Meadow Team.


;; ;;; Mule-UCS $B$N@_Dj(B
;; ;; ftp://ftp.m17n.org/pub/mule/Mule-UCS/ $B$,(B $B%*%U%#%7%c%k%5%$%H$G$9$,!"(B
;; ;; http://www.meadowy.org/~shirai/elisp/mule-ucs.tar.gz $B$K4{CN$N%Q%C%A(B
;; ;; $B$r$9$Y$FE,MQ$7$?$b$N$,$*$$$F$"$j$^$9!#(B
;; ;; (set-language-environment) $B$NA0$K@_Dj$7$^$9(B
;; (require 'jisx0213)


;;; $BF|K\8l4D6-@_Dj(B
(set-language-environment "Japanese")


;;; IME$B$N@_Dj(B
(mw32-ime-initialize)
(setq default-input-method "MW32-IME")
(setq-default mw32-ime-mode-line-state-indicator "[--]")
(setq mw32-ime-mode-line-state-indicator-list '("[--]" "[$B$"(B]" "[--]"))
(add-hook 'mw32-ime-on-hook
	  (function (lambda () (set-cursor-height 2))))
(add-hook 'mw32-ime-off-hook
	  (function (lambda () (set-cursor-height 4))))

;; `C-o' $B$G(B IME $B$r%H%0%k$9$k$?$a$N@_Dj(B
;; $B%G%U%)%k%H$G(B `M-\' $B$^$?$O(B`$B4A;z(B'$B%-!<(B(<kanji>)$B$G$b%H%0%k$G$-$k(B
(global-set-key "\C-o" 'toggle-input-method)

;; ;;; $B%+!<%=%k$N@_Dj(B
;; ;; (set-cursor-type 'box)            ; Meadow-1.10$B8_49(B (SKK$BEy$G?'$,JQ$k@_Dj(B)
;; ;; (set-cursor-type 'hairline-caret) ; $B=DK@%-%c%l%C%H(B


;;; $B%^%&%9%+!<%=%k$r>C$9@_Dj(B
(setq w32-hide-mouse-on-key t)
(setq w32-hide-mouse-timeout 5000)


;;----$B%?%V$HA43Q%9%Z!<%9$K?'IU$1(B
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
     ("$B!!(B" 0 my-face-b-1 append)
     ("\t" 0 my-face-b-2 append)
     ("[ ]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks '(lambda ()
(if font-lock-mode
nil
(font-lock-mode t))) t)

;;; font-lock$B$N@_Dj(B
(global-font-lock-mode t)


;; ;;; TrueType $B%U%)%s%H@_Dj(B
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
;;      (w32-logfont "$B#M#S(B $B%4%7%C%/(B" 0 -16 400 0 nil nil nil 128 1 3 49))
;;     ((:char-spec japanese-jisx0208 :height 120 :weight bold)
;;      strict
;;      (w32-logfont "$B#M#S(B $B%4%7%C%/(B" 0 -16 700 0 nil nil nil 128 1 3 49)
;;      ((spacing . -1)))
;;     ((:char-spec japanese-jisx0208 :height 120 :slant italic)
;;      strict
;;      (w32-logfont "$B#M#S(B $B%4%7%C%/(B" 0 -16 400 0   t nil nil 128 1 3 49))
;;     ((:char-spec japanese-jisx0208 :height 120 :weight bold :slant italic)
;;      strict
;;      (w32-logfont "$B#M#S(B $B%4%7%C%/(B" 0 -16 700 0   t nil nil 128 1 3 49)
;;      ((spacing . -1))))))

;; (set-face-attribute 'variable-pitch nil :family "*")


;; ;;; BDF $B%U%)%s%H@_Dj(B
;;
;; ;;; ($BJ}K!$=$N(B1) Netinstall $B%Q%C%1!<%8$r;H$&J}K!(B
;; ;;; misc $B$H(B intlfonts $B%Q%C%1!<%8$rF~$l$^$9!#(B
;; ;;; .emacs$B$N@_Dj(B
;; (setq bdf-use-intlfonts16 t)
;; (setq initial-frame-alist '((font . "intlfonts16")))
;;
;; ;;; ($BJ}K!$=$N(B1') 
;; ;;; intlfonts-file-16dot-alist $B$N7A<0$G(B bdf-fontset-alist $B$r=q$-!"(B
;; ;;; $B<!$r@_Dj$9$l$PNI$$!#(B
;; ;;;  (require 'bdf)
;; ;;;  (bdf-configure-fontset "bdf-fontset" bdf-fontset-alist)
;; ;;; $B>\:Y$O(B $MEADOW/pkginfo/auto-autoloads.el $B$H(B $MEADOW/site-lisp/bdf.el $B$r(B
;; ;;; $B;2>H$N$3$H!#(B
;;
;; ;;; ($BJ}K!$=$N(B2) 
;; ;;; $B%U%)%s%H$N;XDjJ}K!$O<!$N%5%s%W%k$r;29M$K$9$k!#(B
;; ;;; normal, bold, italic, bold-itaric $B%U%)%s%H$r;XDj$9$kI,MW$"$j!#(B
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
(setFont "IPA$B%4%7%C%/(B" 8 "Anonymous" 5)
(setFont "IPA$B%4%7%C%/(B" 10 "Anonymous" 7)
(setFont "IPA$B%4%7%C%/(B" 12 "Anonymous" 9)
(setFont "IPA$B%4%7%C%/(B" 14 "Anonymous" 11)
(setFont "IPA$B%4%7%C%/(B" 16 "Anonymous" 13)
(setFont "IPA$B%4%7%C%/(B" 18 "Anonymous" 15)
(setFont "IPA$B%4%7%C%/(B" 20 "Anonymous" 17)
(setFont "IPA$B%4%7%C%/(B" 22 "Anonymous" 19)
(setFont "IPA$B%4%7%C%/(B" 24 "Anonymous" 21)

;(w32-query-get-logfont)
;eval-expression-print-level $B$H(B eval-expression-print-length $B$r(Bnil$B$K(B
;; ;;; TrueType $B%U%)%s%H@_Dj(B
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
      (w32-logfont "IPA$B%4%7%C%/(B" 0 -14 400 0 nil nil nil 128 1 3 49)
	  )
     ((:char-spec japanese-jisx0208 :height any :weight bold)
      strict
      (w32-logfont "IPA$B%4%7%C%/(B" 0 -14 700 0 nil nil nil 128 1 3 49)
      )
     ((:char-spec japanese-jisx0208 :height any :slant italic)
      strict
      (w32-logfont "IPA$B%4%7%C%/(B" 0 -14 400 0   t nil nil 128 1 3 49)
	  )
     ((:char-spec japanese-jisx0208 :height any :weight bold :slant italic)
      strict
      (w32-logfont "IPA$B%4%7%C%/(B" 0 -14 700 0   t nil nil 128 1 3 49)
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
      (w32-logfont "IPA$B%4%7%C%/(B" 0 -12 400 0 nil nil nil 128 1 3 49))
     ((:char-spec japanese-jisx0208 :height any :weight bold)
      strict
      (w32-logfont "IPA$B%4%7%C%/(B" 0 -12 700 0 nil nil nil 128 1 3 49)
      ((spacing . -1)))
     ((:char-spec japanese-jisx0208 :height any :slant italic)
      strict
      (w32-logfont "IPA$B%4%7%C%/(B" 0 -12 400 0   t nil nil 128 1 3 49))
     ((:char-spec japanese-jisx0208 :height any :weight bold :slant italic)
      strict
      (w32-logfont "IPA$B%4%7%C%/(B" 0 -12 700 0   t nil nil 128 1 3 49)
      ((spacing . -1))))))


;; $B=i4|%U%l!<%`$N@_Dj(B
(setq default-frame-alist
      (append (list '(foreground-color . "black")
;;		    '(background-color . "LemonChiffon")
;;		    '(background-color . "#FFFFFF")
;;		    '(background-color . "gray")
		    '(background-color . "white")
		    '(border-color . "black")
		    '(mouse-color . "white")
		    '(cursor-color . "black")
;;		    '(ime-font . (w32-logfont "$B#M#S(B $B%4%7%C%/(B"
;;					      0 16 400 0 nil nil nil
;;					      128 1 3 49)) ; TrueType $B$N$_(B
;;		    '(font . "bdf-fontset")    ; BDF
		    '(font . "default"); TrueType
		    '(width . 136)
		    '(height . 55)
		    '(top . 10)
		    '(left . 80))
	      default-frame-alist))


;; ;;; shell $B$N@_Dj(B

;; ;;; Cygwin $B$N(B bash $B$r;H$&>l9g(B
(setq explicit-shell-file-name "bash")
(setq shell-file-name "sh")
(setq shell-command-switch "-c") 

;; ;;; Virtually UN*X!$B$K$"$k(B tcsh.exe $B$r;H$&>l9g(B
;; (setq explicit-shell-file-name "tcsh.exe") 
;; (setq shell-file-name "tcsh.exe") 
;; (setq shell-command-switch "-c") 

;; ;;; WindowsNT $B$KIUB0$N(B CMD.EXE $B$r;H$&>l9g!#(B
;; (setq explicit-shell-file-name "CMD.EXE") 
;; (setq shell-file-name "CMD.EXE") 
;; (setq shell-command-switch "\\/c") 


;;; argument-editing $B$N@_Dj(B
(require 'mw32script)
(mw32script-init)


;; ;;; browse-url $B$N@_Dj(B
;; (global-set-key [S-mouse-2] 'browse-url-at-mouse)


;; ;;; $B0u:~$N@_Dj(B
;; ;; $B$3$N@_Dj$G(B M-x print-buffer RET $B$J$I$G$N0u:~$,$G$-$k$h$&$K$J$j$^$9(B
;; ;;
;; ;;  notepad $B$KM?$($k%Q%i%a!<%?$N7A<0$N@_Dj(B
;; (define-process-argument-editing "notepad"
;;   (lambda (x) (general-process-argument-editing-function x nil t)))
;;
;; (defun w32-print-region (start end
;; 				  &optional lpr-prog delete-text buf display
;; 				  &rest rest)
;;   (interactive)
;;   (let ((tmpfile (convert-standard-filename (buffer-name)))
;; 	   (w32-start-process-show-window t)
;; 	   ;; $B$b$7!"(Bdos $BAk$,8+$($F$$$d$J?M$O>e5-$N(B `t' $B$r(B `nil' $B$K$7$^$9(B
;; 	   ;; $B$?$@$7!"(B`nil' $B$K$9$k$H(B Meadow $B$,8G$^$k4D6-$b$"$k$+$b$7$l$^$;$s(B
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

;; ;;; fakecygpty $B$N@_Dj(B
;; ;; $B$3$N@_Dj$G(B cygwin $B$N2>A[C<Kv$rMW5a$9$k%W%m%0%i%`$r(B Meadow $B$+$i(B
;; ;; $B07$($k$h$&$K$J$j$^$9(B
;; (setq mw32-process-wrapper-alist
;;       '(("/\\(bash\\|tcsh\\|svn\\|ssh\\|gpg[esvk]?\\)\\.exe" .
;; 	  (nil . ("fakecygpty.exe" . set-process-connection-type-pty)))))

;;;

;;; C-h $B$r(B backspace $B$H$7$F;H$&!#(B
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

;;$B%D!<%k%P!<$rI=<($7$J$$(B
(tool-bar-mode 0)
(menu-bar-mode 0)
(setq elscreen-display-tab nil)
(setq elscreen-tab-display-create-screen nil)
(setq elscreen-tab-display-kill-screen nil)

;; $BFCDj$N%b!<%I$G$N$_M-8z$K$9$k(B
;; $B30It$GJT=8$5$l$?%U%!%$%k$N<+F0FI$_9~$_(B
;; VisualStudio$B$H6&DL$N%U%!%$%k$rJT=8$9$k;~MQ(B
(add-hook 'c-mode-hook 'turn-on-auto-revert-mode)

;(require 'gnuserv)
;(gnuserv-start)
;(setq gnuserv-frame (selected-frame))

;--- GNU GLOBAL(gtags) gtags.el ---
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
	   (local-set-key "\M-t" 'gtags-find-tag)     ;$B4X?t$NDj5A85$X(B
	   (local-set-key "\M-r" 'gtags-find-rtag)    ;$B4X?t$N;2>H@h$X(B
	   (local-set-key "\M-s" 'gtags-find-symbol)  ;$BJQ?t$NDj5A85(B/$B;2>H@h$X(B
	   (local-set-key "\C-t" 'gtags-pop-stack)  ;$BA0$N%P%C%U%!$KLa$k(B
	  ))
;
(global-set-key "\C-cgt" 'gtags-find-tag)    ;$B4X?t$NDj5A85$X(B
(global-set-key "\C-cgr" 'gtags-find-rtag)   ;$B4X?t$N;2>H@h$X(B
(global-set-key "\C-cgs" 'gtags-find-symbol) ;$BJQ?t$NDj5A85(B/$B;2>H@h$X(B
(global-set-key "\C-cgf" 'gtags-find-file)
(global-set-key "\C-cgp" 'gtags-find-pattern)
(global-set-key "\C-cg." 'gtags-find-tag-from-here)
(global-set-key "\C-cg*" 'gtags-pop-stack)
(global-set-key "\C-c*" 'gtags-pop-stack)    ;$BA0$N%P%C%U%!$KLa$k(B
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

;; BackSpace $B%-!<$r!V8-$/!W$7!$%$%s%G%s%HI}$O(B4$B7e(B
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


;;(defconst *dmacro-key* [?\M-t] "$B7+JV$7;XDj%-!<(B")
;;(global-set-key *dmacro-key* 'dmacro-exec)
;;(autoload 'dmacro-exec "dmacro" nil t)

;;$B9TKv$G@^$jJV$5$J$$(B
(setq truncate-lines 'f)

;;iswitchb$B$r;H$&(B
(iswitchb-mode)


;;iswitchb$B;HMQCf$KA*Br(Bbuffer$B$r(Bwindow$B$KI=<((B
(defadvice iswitchb-exhibit
  (after
   iswitchb-exhibit-with-display-buffer
   activate)
  "$BA*Br$7$F$$$k(B buffer $B$r(B window $B$KI=<($7$F$_$k!#(B"
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

;; ;; migemo$B4pK\@_Dj(B
;; (setq migemo-command "cmigemo")
;; (setq migemo-options '("-q" "--emacs"))
;; ;; migemo-dict $B$N%Q%9$r;XDj(B
;; (setq migemo-dictionary "c:/cygwin/dict/migemo-dict")
;; (setq migemo-user-dictionary nil)
;; (setq migemo-regex-dictionary nil)

;; ;; $B%-%c%C%7%e5!G=$rMxMQ$9$k(B
;; (setq migemo-use-pattern-alist t)
;; (setq migemo-use-frequent-pattern-alist t)
;; (setq migemo-pattern-alist-length 1024)
;; ;; $B<-=q$NJ8;z%3!<%I$r;XDj!%(B
;; ;; $B%P%$%J%j$rMxMQ$9$k$J$i!$$3$N$^$^$G9=$$$^$;$s(B
;; (setq migemo-coding-system 'shift_jis-unix)

;; (load-library "migemo")
;; ;; $B5/F0;~$K=i4|2=$b9T$&(B
;; (migemo-init)


;(require 'color-moccur)

;;-------------$B=&$C$?(Belisp-----------
;; $BC18l$r(B kill-ring $B$K(B save $B$9$k(B
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

;;$B%_%K%P%C%U%!$NMzNr$r<+F0J]B8(B
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;;$B1&C<$G@^$jJV$5$J$$(B
(setq truncate-lines t)
;;frame$BJ,3d;~1&C<$G@^$jJV$5$J$$(B
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
      :doc-spec '(("(gauche-refj.info)Index - $B<jB3$-$H9=J8:w0z(B" nil
                   "^ -+ [^:]+: *" "[\n ]")
                  ("(gauche-refj.info)Index - $B%b%8%e!<%k:w0z(B" nil
                   "^ -+ [^:]+: *" "[\n ]")
                  ("(gauche-refj.info)Index - $B%/%i%9:w0z(B" nil
                   "^ -+ [^:]+: *" "[\n ]")
                  ("(gauche-refj.info)Index - $BJQ?t:w0z(B" nil
                   "^ -+ [^:]+: *" "[\n ]"))
      :parse-rule "[^()`',\" \t\n]+"
      :other-modes nil)

     (info-lookup-add-help
      :mode 'inferior-scheme-mode
      :other-modes '(scheme-mode))
))

;;-------------windows---------------
 	

;; $B%-!<%P%$%s%I$rJQ99!%(B
;; $B%G%U%)%k%H$O(B C-c C-w
;; $BJQ99$7$J$$>l9g!W$O!$0J2<$N(B 3 $B9T$r:o=|$9$k(B
(setq win:switch-prefix "\C-z")
(define-key global-map win:switch-prefix nil)
(define-key global-map "\C-z1" 'win-switch-to-window)
(require 'windows)
;; $B?75,$K%U%l!<%`$r:n$i$J$$(B
(setq win:use-frame nil)
(win:startup-with-window)
(define-key ctl-x-map "C" 'see-you-again)

;;$B%9%Z!<%9$G;O$^$k%P%C%U%!$bJ]B8(B
(setq revive:ignore-buffer-pattern "^ \\*")

;;kill-summary
;;M-x kill-summary
(autoload 'kill-summary "kill-summary" nil t)

;;$B%_%K%P%C%U%!$r%$%s%/%j%a%s%?%k%5!<%A(B
(require 'minibuf-isearch)


;;isearch$B$N8!:w7k2L$K?'$rIU$1$?$^$^$K$9$k!#?'$r;D$7$?$$;~$K(BC-l
(require 'hi-lock)

(defun highlight-isearch-word ()
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (isearch-exit)
    (hi-lock-face-buffer-isearch
     (if (and (featurep 'migemo) migemo-isearch-enable-p)
         (migemo-get-pattern isearch-string)
       isearch-string))))

;;; ;;; *scratch*$B%P%C%U%!$r>C$5$J$$(B
(defun my-make-scratch (&optional arg)
  (interactive)
  (progn
    ;; "*scratch*" $B$r:n@.$7$F(B buffer-list $B$KJ|$j9~$`(B
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
          ;; *scratch* $B%P%C%U%!$G(B kill-buffer $B$7$?$iFbMF$r>C5n$9$k$@$1$K$9$k(B
          (lambda ()
            (if (string= "*scratch*" (buffer-name))
                (progn (my-make-scratch 0) nil)
              t)))
(add-hook 'after-save-hook
          ;; *scratch* $B%P%C%U%!$NFbMF$rJ]B8$7$?$i(B *scratch* $B%P%C%U%!$r?7$7$/:n$k(B
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


;;-------------$B<+:n(Belisp-------------

;; $B;~9o$rA^F~$7$F2~9T!#(B
(defun intime () (interactive) (insert (format-time-string "[%Y-%m-%d %H:%M]")))
(global-set-key [(control return)] 'intime)

;;$B%+!<%=%k0LCV$^$G%O%$%U%s$rF~NO(B
(defun inshi ()(interactive)(let ((i 0)(ppp (current-column)))
  (while (<= i ppp)
    (insert "-")
    (setq i (1+ i)))))

;;Macro:$B%+!<%=%kD>8e$NJ8;zNs(B1$B9T$r0O$&(B
(fset 'kakou
   [?/ ?* ?\C-q tab ?\C-e ?\C-q tab ?* ?/ ?\C-  ?\C-[ ?x ?i ?n ?s ?h ?i return ?\C-x ?\C-x ?\C-m ?/ ?* ?\C-e ?\C-? ?\C-? ?\C-? ?\C-? ?\C-? ?* ?/ ?\C-a ?\C-k ?\C-k ?\C-y ?\C-p ?\C-p ?\C-y ?\C-n ?\C-n])
(fset 'kakou2
   [?/ ?* ?\C-q tab ?\C-e ?\C-q tab ?* ?/ ?\C-a ?\C-k ?\C-y ?\C-m ?\C-y ?\C-m ?\C-y ?\C-a ?\C-p ?\C-p ?\C-  ?\C-e ?\C-[ ?x ?u ?n ?t ?a tab return ?\C-a ?\C-  ?\C-  ?\C-e ?\C-[ ?x ?r ?e ?p ?l ?a tab ?r ?e ?g tab return ?. return ?- return ?\C-a ?\C-n ?\C-n ?\C-  ?\C-  ?\C-e ?\C-[ ?x ?u ?n ?t ?a tab return ?\C-  ?\C-  ?\C-a ?\C-[ ?x ?r ?e ?p ?l ?a tab ?r ?e tab ?g tab return ?. return ?- return ?\C-d ?\C-? ?* ?/ ?\C-a ?\C-d ?\C-d ?/ ?* ?\C-a ?\C-p ?\C-p ?\C-d ?\C-d ?/ ?* ?\C-e ?\C-? ?\C-? ?* ?/ ?\C-n ?\C-n ?\C-f])


;;;; YaTeX ($BLnD;(B)
;; yatex-mode $B$r5/F0$5$;$k@_Dj(B
(setq auto-mode-alist 
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;; LaTeX $B%3%^%s%I!"%W%l%S%e!<%o!"%W%j%s%?$J$I$N@_Dj(B
(setq tex-command "platex"
      dvi2-command "/cygdrive/c/tex/dviout/dviout -1 -Set=!m"
      dviprint-command-format "dvipsk %s | lpr"
      YaTeX-kanji-code 1   ; (1 SJIS, 2 JIS, 3 EUC) JIS(junet-unix)$B$@$H(BOS$B0MB8$;$:$K%3%s%Q%$%k$G$-$k(B
      YaTeX-latex-message-code 'sjis  ; $B2~9T$K(B ^M $B$,$D$+$J$$$h$&$K$9$k(B
      section-name "documentclass"
      makeindex-command "mendex"
      YaTeX-use-AMS-LaTeX t   ; AMS-LaTeX$B$r;H$&(B
      YaTeX-use-LaTeX2e t     ; LaTeX2e$B$r;H$&(B
      YaTeX-use-font-lock t   ; $B?'IU$1(B
      )
;; $B<+F02~9T$rL58z(B
(add-hook 'yatex-mode-hook'(lambda ()(setq auto-fill-function nil)))


;;$B%j!<%8%g%s$rBgJ8;z$K$9$k$H$-$K3NG'(B(y/n)$B$rI=<($7$J$$(B
(put 'upcase-region 'disabled nil)

;;$B%j!<%8%g%s$N(BLine$B$r?t$($FA^F~(B
(defun count-lines-region-in (start end)
  "Print number of lines and characters in the region."
  (interactive "r")
  (insert   (int-to-string (count-lines start end))))

;;$B8=%P%C%U%!$r=(4]$G3+$/(B
(defun open-hidemaru (pos)
  (interactive "d")
  (shell-command (concat "c:/Program\\ Files/hidemaru/hidemaru.exe" " /j" (int-to-string (line-number-at-pos pos)) "," (int-to-string (+ 1 (current-column))) " '" buffer-file-name "'")))
(global-set-key "\C-c\C-o" 'open-hidemaru)

;;$B8=%j!<%8%g%s$r(B16$B?J?t$KJQ49(B
(defun dectohex ()
  (interactive )
  (insert (format "0x%03X" (string-to-int (car kill-ring)))))

(setq visible-bell t)

;(howm-menu)
;;; end of file
;;;

(put 'narrow-to-region 'disabled nil)
