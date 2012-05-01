;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 動作設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; tmp file saving directory
(setq auto-save-list-file-prefix "~/local/.emacs.d/.saves-")

;; backup.file~ location
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/local/.emacs.d/backup"))
            backup-directory-alist))

;; 前回編集していた場所を記憶し，ファイルを開いた時にそこへカーソルを移動
(load "saveplace")
(setq-default save-place t)

;; beep
(setq visible-bell nil)

;; diff
(setq diff-switches "-u")

;; dabbrev for japanese
(setq case-replace nil)             ;dabbrev exact (upper or lower)case
(setq dabbrev-case-fold-search nil) ;dabbrev exact case
;(load "dabbrev-ja")

;; "*Buffer List*" から動的補完する。
;;  Javaのclass名をファイルに付けたらファイルの中でも補完できるように。
(setq dabbrev-ignored-buffer-names '("*Messages*"))
