;; -*- mode: emacs-lisp -*-

   ;; 言語設定
   (set-language-environment "Japanese")
   ;; IME設定
   (setq default-input-method "W32-IME")
   ;; IME初期化
   (w32-ime-initialize)
   ;; IME ON/OFF時のカーソルカラー
   (add-hook 'input-method-activate-hook
             (lambda() (set-cursor-color "orange")))
   (add-hook 'input-method-inactivate-hook
             (lambda() (set-cursor-color "blue")))

   (set-keyboard-coding-system 'japanese-shift-jis)

;; y/n, yes/no の問い合わせ時に IME をオフにする
(wrap-function-to-control-ime 'y-or-n-p nil nil)
(wrap-function-to-control-ime 'yes-or-no-p nil nil)

; =======================================================================
; @ フレーム
  (setq default-frame-alist
        (append '((top                  . 28     ) ;; 配置上位置
                  (left                 . 70     ) ;; 配置左位置
                  (width                . 94     ) ;; フレーム幅
                  (height               . 40     ) ;; フレーム高
                  (line-spacing         . 0      ) ;; 文字間隔
                  (left-fringe          . 0      ) ;; 左フリンジ幅
                  (right-fringe         . 0      ) ;; 右フリンジ幅
                  (menu-bar-lines       . nil    ) ;; メニューバー
                  (tool-bar-lines       . nil    ) ;; ツールバー
                  (vertical-scroll-bars . nil    ) ;; スクロールバー
                  (cursor-type          . box    ) ;; カーソル種別
                  (foreground-color     . "black") ;; 文字色
                  (background-color     . "white") ;; 背景色
                  (cursor-color         . "blue"  ) ;; カーソル色
                  ) default-frame-alist) )
  (setq initial-frame-alist default-frame-alist)
  ;; フレームタイトルの設定
  (setq frame-title-format "NTEmacs - %b")
  ;; 起動メッセージの非表示
  (setq inhibit-startup-message t)

; =======================================================================
; @ バッファ
  ;; バッファ画面外文字の切り詰め表示
  (setq truncate-lines nil)
  ;; ウィンドウ縦分割時のバッファ画面外文字の切り詰め表示
  (setq truncate-partial-width-windows t)
  ;; 同一バッファ名にディレクトリ付与
  (require 'uniquify)
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  (setq uniquify-ignore-buffers-re "*[^*]+*")
  ;;iswitchbを使う
  (iswitchb-mode)


; =======================================================================
; @ モードライン
  ;; 行番号の表示
  (line-number-mode t)
  ;; 列番号の表示
  (column-number-mode t)
  ;; 時刻フォーマットの設定
  (setq display-time-24hr-format t)
  (setq display-time-string-forms '(24-hours ":" minutes))
  ;; 時刻の表示
  (display-time-mode t)
  ;; 不要文字列の排除
  ;; (setq-default mode-line-format
  ;;               '("-" mode-line-mule-info mode-line-modified
  ;;                 mode-line-frame-identification
  ;;                 mode-line-buffer-identification " " global-mode-string
  ;;                 " %[(" mode-name mode-line-process minor-mode-alist
  ;;                 "%n" ")%]-" (which-func-mode ("" which-func-format "-"))
  ;;                 (line-number-mode "L%l-") (column-number-mode "C%c-")
  ;;                 (-3 . "%p") "-%-"))
  (setq mode-line-frame-identification " ")
  (setq-default w32-ime-mode-line-state-indicator "[--]")
  (setq w32-ime-mode-line-state-indicator "[--]")
  (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
;; `C-o' で IME をトグルするための設定
;; デフォルトで `M-\' または`漢字'キー(<kanji>)でもトグルできる
(global-set-key "\C-o" 'toggle-input-method)

;カーソルキーで新しい行を作らない 
(setq next-line-add-newlines  nil)
; =======================================================================
; @ 配色
  ;; ;; キーワード
  ;; (set-face-foreground  'font-lock-comment-face       "blue"    )
  ;; (set-face-foreground  'font-lock-string-face        "gray1")
  ;; (set-face-foreground  'font-lock-type-face          "tomato"    )
  ;; (set-face-foreground  'font-lock-variable-name-face "orange"    )
  ;; (set-face-foreground  'font-lock-constant-face      "SkyBlue1"  )
  ;; (set-face-foreground  'font-lock-function-name-face "royalBlue1")
  ;; ;; リージョン
  ;; (set-face-foreground  'region "spring green")
  ;; (set-face-background  'region "royal blue"  )
  ;; ;; ハイライト
  ;; (set-face-foreground  'highlight "spring green")
  ;; (set-face-background  'highlight "royal blue"  )
  ;; ;; 太字
  ;; (set-face-foreground  'bold "DarkOrange")
  ;; ;; 下線文字
  ;; (set-face-background  'underline "gray30")
  ;; (set-face-underline-p 'underline nil)
  ;; ;; モードライン
  ;; (set-face-foreground  'modeline "LawnGreen"  )
  ;; (set-face-background  'modeline "forestgreen")
  ;; ;; 非アクティブ モードライン
  ;; (set-face-foreground  'mode-line-inactive "gray50")
  ;; (set-face-background  'mode-line-inactive "gray80")
  ;; (set-face-attribute   'mode-line-inactive nil :box '(:line-width -1
  ;;                                               :color "grey75"
  ;;                                               :style released-button))
  ;; ;; リンク
  ;; (set-face-foreground  'link "#6495ed")

; ======================================================================
; @ カーソル
  ;; カーソル点滅表示
  (blink-cursor-mode 0)
  ;; 非アクティブウィンドウのカーソル表示
  (setq default-cursor-in-non-selected-windows t)
  ;; スクロール時のカーソル位置の維持
  (setq scroll-preserve-screen-position t)
  ;; スクロール行数（一行ごとのスクロール）
  (setq vertical-centering-font-regexp ".*")
  (setq scroll-conservatively 35
        scroll-margin          0
        scroll-step            1)
  ;; 画面スクロール時の重複行数
  (setq next-screen-context-lines 1)
; ;; Shift + 矢印キーでのウィンドウ間のカーソル移動
 (windmove-default-keybindings)
 (setq windmove-wrap-around t)

; =======================================================================
; @ マウス
  ;; mouse-save-then-killの無効化
  (define-key global-map [down-mouse-3] nil)
  ;; マウスドラッグ時のリージョンコピー
  (setq mouse-drag-copy-region nil)
; ;; カーソル位置へのペースト
; (setq mouse-yank-at-point t)

; =======================================================================
; @ 入力制御
  ;; next-line実行時のファイル末尾への改行追加
  (setq next-line-add-newlines t)
  ;; Emacs終了時のファイル末尾への改行追加
  (setq require-final-newline nil)
; ;; 行削除時の改行削除
; (setq kill-whole-line t)
  ;; インデント時のタブ利用（あるいはスペース利用）
  (setq-default indent-tabs-mode nil)
  ;; 前行のインデントに合わせる
  (setq indent-line-function 'indent-relative-maybe)
  ;; タブ幅
  (setq-default tab-width 4)
  (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
  ;; デフォルトの作業ディレクトリ
  (cd "c:/home")
  ;; ローカル変数指定の制御
  (setq enable-local-eval nil)
; ;; カーソル位置のファイル/URLオープン
; (ffap-bindings)
; ;; 圧縮ファイルの内容表示
; (auto-compression-mode t)

; =======================================================================
; @ ハイライト
  ;; リージョンのハイライト
  (setq transient-mark-mode nil)
  ;; カーソル行のハイライト
;  (setq hl-line-face 'underline)
;  (global-hl-line-mode)
  ;; 括弧の対応表示
  (setq blink-matching-paren t)
  (show-paren-mode t)
  (setq paren-sexp-mode t)
  (set-face-background 'show-paren-match "royalBlue1")
  ;; タブ/行末スペースのハイライト
  (defface my-blank-face '((t (:background "gray60" :underline nil))) nil)
  (defvar my-blank-face 'my-blank-face)
  (defadvice font-lock-mode (before font-lock-mode-before ())
    (font-lock-add-keywords major-mode
                            '(("[\t　]" 0 my-blank-face append)
                              ("[ \t]+$"  0 my-blank-face append)
                              )))
  (ad-enable-advice 'font-lock-mode 'before 'font-lock-mode-before)
  (ad-activate 'font-lock-mode)
  ;; コピー＆ペーストのハイライト
  (defadvice yank (after ys:highlight-string activate)
    (let ((ol (make-overlay (mark t) (point))))
      (overlay-put ol 'face 'highlight)
      (sit-for 0.5)
      (delete-overlay ol)
      ))
  (defadvice yank-pop (after ys:highlight-string activate)
    (when (eq last-command 'yank)
      (let ((ol (make-overlay (mark t) (point))))
        (overlay-put ol 'face 'highlight)
        (sit-for 0.5)
        (delete-overlay ol)
        )))

; =======================================================================
; @ バックアップ
  ;; ファイルのバックアップ
  (setq make-backup-files t)
  ;; 編集中ファイルのバックアップ
  (setq auto-save-list-file-name nil)
  (setq auto-save-list-file-prefix nil)
  ;; 番号つきバックアップ
  (setq version-control t)
  ;; バックアップ世代数
  (setq kept-old-versions 5)
  (setq kept-new-versions 5)
  ;; 上書き時の警告表示
  (setq trim-versions-without-asking nil)
  ;; 古いバックアップファイルの削除
  (setq delete-old-versions t)
; ;; バックアップ先
  (setq my-backup-dir-alist "~/backup/")
  (setq backup-directory-alist
        (cons (cons "\\.*$" (expand-file-name my-backup-dir-alist))
              backup-directory-alist))


; =======================================================================
; @ 検索
; (my-time-lag "basic 検索")
; ;; 日本語文字列を検索
; (setq grep-command "lgrep -n -As ")
; (setq grep-program "lgrep")
; ;; 大文字・小文字を区別しないでサーチ
; (setq default-case-fold-search nil)
; (my-time-lag "basic 検索")

; =======================================================================
; @ プロセス
  ;; サブプロセス出力直前の強制遅延
  (setq w32-pipe-read-delay 10)
; ;; GCの頻度を減らす
; (setq gc-cons-threshold 5242880)
; ;; GCのメッセージをミニバッファに表示
; (setq garbage-collection-messages t)

; =======================================================================
; @ デバッグ
  (setq debug-on-error nil)
  (setq eval-expression-print-level nil)
  (setq eval-expression-print-length nil)
  (setq eval-expression-debug-on-error nil)
  (setq edebug-print-length 10)
  (setq edebug-print-level  10)


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

(global-set-key "\C-h" 'delete-backward-char)
(set-default-font "M+2VM+IPAG circle-12")
;(set-face-attribute 'fixed-pitch nil :family  "M+2VM+IPAG circle")
;(set-face-attribute 'variable-pitch nil :family  "M+2VM+IPAG circle")

