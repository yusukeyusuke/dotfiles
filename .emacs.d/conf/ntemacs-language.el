(setq default-input-method "W32-IME")
(w32-ime-initialize)

;; IMEのON/OFFでカーソルの色を変える
(set-cursor-color "black")
(add-hook 'w32-ime-on-hook
          (function (lambda () (set-cursor-color "LimeGreen"))))
(add-hook 'w32-ime-off-hook
          (function (lambda () (set-cursor-color "black"))))
