;;auto-install settings
(when (require 'auto-install nil t)
  ;; setinstall directory
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; acquire elisp name
  (auto-install-update-emacswiki-package-name t)
  ;; if you need proxy , setting here
  ;; (setq url-proxy-services '(("http". "localhost:8339")))
  ;; enable install-elisp function
  (auto-install-compatibility-setup))

(require 'color-moccur)

(setq howm-menu-lang 'ja)
(require 'howm)
(setq howm-keyword-file "~/howm/.howm-keys") ;; デフォルトは ~/.howm-keys