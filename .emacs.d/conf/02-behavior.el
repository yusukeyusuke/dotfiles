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

;;backup timing
(setq auto-save-timeout 15)
(setq auto-save-interval 60)

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
