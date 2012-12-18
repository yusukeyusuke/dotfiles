;;; anything
;; (auto-install-batch "anything")

;; (when (require 'anything-startup nil t)
;;   (setq
;;    ;; delay for display candidate(0.5)
;;    anything-idle-delay 0.3
;;    ;; delay for input idle(0.1)
;;    anything-input-idle-delay 0.2
;;    ;; numbers of candidate(50)
;;    anything-candidate-number-limit 100
;;    ;; quick update for many candidates
;;    anything-quick-update t
;;    ;; set candidate shortcut alphabet
;;    anything-enable-shortcuts 'alphabet)

;;   (require 'anything-match-plugin nil t)

;;   (when (and (executable-find "cmigemo")
;;              (require 'migemo nil t))
;;     (require 'anything-migemo nil t))

;;   (when (require 'anything-complete nil t)
;;     (anything-lisp-complete-symbol-set-timer 150))

;;   (require 'anything-show-completion nil t)

;;   (when (require 'auto-istall nil t)
;;     (require 'anything-auto-install nil t))

;;   (when (require 'descbinds-anything nil t)
;;     (descbinds-anything-install)))


;; (define-key global-map (kbd "M-y") 'anything-show-kill-ring)

;; ;; need color-moccur.el
;; (when (require 'anything-c-moccur nil t)
;;   (setq
;;    ;; idle delay setting for anything-c-moccur
;;    anything-c-moccur-anything-idle-delay 0.1
;;    ;; highlight buffor infomation
;;    anything-c-moccur-higligt-info-line-flag t
;;    ;;
;;    anything-c-moccur-enable-auto-look-flag t
;;    ;;
;;    anything-c-moccur-enable-initial-pattern t)

;;   (global-set-key (kbd "C-M-o") 'anything-c-moccur-occur-by-moccur))

  
  


