;; add load path automatically.
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "elisp" "conf" "public_repos")

(require 'init-loader)
(init-loader-load "~/.emacs.d/conf")






;; keyset
(global-set-key "\C-h" 'backward-delete-char) ;C-h as BackSpace
(global-set-key "\M-?" 'help-for-help)        ;M-? as help

(cd "~")                            ;start on home directory
(setq-default indent-tabs-mode nil) ;When pushing [TAB],  input WhiteSpaces.

;; distinguishing Emacsen
(cond
 ((and (featurep 'meadow) (= emacs-major-version 22))
  (load (concat user-emacs-directory "init.meadow3.el")))
 ((and (equal system-type 'windows-nt) (= emacs-major-version 23) (= emacs-minor-version 3))
  (load (concat user-emacs-directory "init.ntemacs23.3.el")))
 ((and (equal system-type 'windows-nt) (= emacs-major-version 23) (= emacs-minor-version 1))
  (load (concat user-emacs-directory "init.ntemacs23.1.el")))
 ((and (equal system-type 'windows-nt) (= emacs-major-version 22))
  (load (concat user-emacs-directory "init.ntemacs22.el")))
 ((= emacs-major-version 23)
  (load (concat user-emacs-directory "init.emacs23.el")))
 ((= emacs-major-version 22)
  (load (concat user-emacs-directory "init.emacs22.el")))
 ((= emacs-major-version 21)
  (load (concat user-emacs-directory "init.emacs21.el")))
)

;; end of file
