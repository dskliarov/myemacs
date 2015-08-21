;; Hook up all the major and minor modes we care about
(require 'emacs-modes)
;; Explorer more popular emacs options here: http://www.emacswiki.org/emacs/PopularOptions

;;(setq custom-file "~/.emacs.d/.emacs-custom.el")
;;(load custom-file)

;; Make it look good
(require 'theme)

;; Useful?
(require 'dircolors)

;;set cursor colour
(set-cursor-color "yellow")

;;make sure ansi color character escapes are honored
(ansi-color-for-comint-mode-on)

;;Highlighting the selected line
(defface hl-line '((t (:background "gray10")))
  "Face to use for `hl-line-face'." :group 'hl-line)
(setq hl-line-face 'hl-line)
(global-hl-line-mode t) ; turn it on for all modes by default

;;Allow font sizes to scale without distorting window dimensions
(require 'face-remap+)
(global-set-key (kbd "C-<") 'text-scale-decrease)
(global-set-key (kbd "C->") 'text-scale-increase)

(when (boundp 'mouse-wheel-down-event) ; Emacs 22+
  (global-set-key (vector (list 'control mouse-wheel-down-event))
		  'text-scale-increase))

(when (boundp 'mouse-wheel-up-event) ; Emacs 22+
  (global-set-key (vector (list 'control mouse-wheel-up-event))
		  'text-scale-decrease))

;; Calms the default jumpy behavior
(require 'smooth-scrolling)

;; Display the current row and column number at the bottom of the window
(line-number-mode 1)
(column-number-mode 1)

;; Hide the hideous Emacs splash screen	 
(setq inhibit-splash-screen t)						

;; http://www.emacswiki.org/emacs/SavePlace
(require 'saveplace)
(setq-default save-place t)


;; Useful?
(setq read-file-name-completion-ignore-case nil)

(setq make-backup-files nil)            ;; More here http://www.emacswiki.org/emacs/BackupDirectory
(setq use-file-dialog nil)

;; Be a bit more Windows-friendly
;;(transient-mark-mode t) 		;; highlight text selection
;;(delete-selection-mode t) 		;; delete seleted text when typing
(cua-mode t) 				;; windows style keybind C-x, C-v, cut paste
(setq cua-auto-tabify-rectangles nil) 	;; Don't tabify after rectangle commands
(setq cua-keep-region-after-copy t) 	;; Selection remains after C-c
(transient-mark-mode 1)             	;; No region when it is not highlighted
;(global-set-key "\C-a" 'mark-whole-buffer)	;; Select All
;(global-set-key "\C-f" 'isearch-forward)
;(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
(global-set-key "\C-w" 'kill-this-buffer)

;; Visual Studio 
(show-paren-mode t) ; light-up matching parens
(global-font-lock-mode t) ; turn on syntax highlight
(global-set-key [C-f4] (lambda () (interactive) (kill-buffer nil)))

;; Setup auto highlight symbol
(require 'auto-highlight-symbol-config)
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)

(add-hook 'after-init-hook 'my-after-init-hook)
(defun my-after-init-hook ()
  ;;(require 'edts-start)
  )

;; Set up buffer switching
;;   (autoload 'cycle-buffer "cycle-buffer" "Cycle forward." t)
;;   (autoload 'cycle-buffer-backward "cycle-buffer" "Cycle backward." t)
;;   (autoload 'cycle-buffer-permissive "cycle-buffer" "Cycle forward allowing *buffers*." t)
;;   (autoload 'cycle-buffer-backward-permissive "cycle-buffer" "Cycle backward allowing *buffers*." t)
;;   (autoload 'cycle-buffer-toggle-interesting "cycle-buffer" "Toggle if this buffer will be considered." t)
;;   (global-set-key [(f9)]        'cycle-buffer-backward)
;;   (global-set-key [(f10)]       'cycle-buffer)
;;   (global-set-key [(shift f9)]  'cycle-buffer-backward-permissive)
;   (global-set-key [(shift f10)] 'cycle-buffer-permissive)

(require 'package)
;; Add the original Emacs Lisp Package Archive
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;(add-to-list 'package-archives
;             '("melpa" . "http://melpa.milkbox.net/packages/"))
;; Add the user-contributed repository
;;(add-to-list 'package-archives
;;             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)

;; ido provides a very nice auto-complete for finding files (type C-x f)
;; Learn more here: http://www.emacswiki.org/emacs/InteractivelyDoThings
(require 'ido)
(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-max-prospects 10)


(setq text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))

;; Get rid of clutter
;;(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
;;(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))


(defun find-file-save-default-directory ()
  (interactive)
  (setq saved-default-directory default-directory)
  (ido-find-file)
  (setq default-directory saved-default-directory))
(global-set-key (kbd "C-x C-f") 'find-file-save-default-directory)

(add-hook 'term-exec-hook
          (function
           (lambda ()
             (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))

;; (require 'sr-speedbar)
;; (setq speedbar-show-unknown-files t)
;; (setq speedbar-frame-parameters
;; 	  `(
;; 		(minibuffer)
;; 		(width 25)
;; 		(border-width 0)
;; 		(menu-bar-lines 0)
;; 		(tool-bar-lines 0)
;; 		(unsplittable t)
;; 		(left-fringe 0)))

;; (defun speedbar-open-and-select ()
;;   (interactive)
;;   (sr-speedbar-open)
;;   (sr-speedbar-select-window))

;; (global-set-key (kbd "C-o") 'speedbar-open-and-select)

(global-linum-mode t)

(provide 'my-config)

(global-set-key (kbd "C-c C-c") 'comment-region)

(global-set-key (kbd "C-c C-u") 'uncomment-region)

(global-set-key (kbd "C-x C-g") 'find-grep-dired)
(global-set-key (kbd "C-x /") 'ecb-activate)
(global-set-key (kbd "C-x '") 'ecb-deactivate)
(global-set-key (kbd "C-c d") 'ecb-goto-window-directories)
(global-set-key (kbd "C-c h") 'ecb-goto-window-history)
(global-set-key (kbd "C-c e") 'ecb-goto-window-edit1)
(global-set-key (kbd "C-c m") 'ecb-goto-window-methods)
(setq default-directory "~/erlang_projects")

(setq user-full-name "Dmitri Skliarov")
(setq user-login-name "dskliarov")
(setq user-mail-address "DmitriSkliarov@QuickenLoans.com")

;; {setq dired-recursive-deletes 'always}

(defun switch-buffers-between-frames ()
  "switch-buffers-between-frames switches the buffers between the two last frames"
  (interactive)
  (let ((this-frame-buffer nil)
	(other-frame-buffer nil))
    (setq this-frame-buffer (car (frame-parameter nil 'buffer-list)))
    (other-frame 1)
    (setq other-frame-buffer (car (frame-parameter nil 'buffer-list)))
    (switch-to-buffer this-frame-buffer)
    (other-frame 1)
    (switch-to-buffer other-frame-buffer)))

;; Enable EDE (Project Management) features
(global-ede-mode 1)

(load-theme 'solarized t)

(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e)) 
(setq mouse-sel-mode t)

;;; activate ecb
(setq stack-trace-on-error t)
(require 'cedet)
(require 'semantic/tag)
(require 'semantic/lex)
(semantic-mode 1)
;;(require 'ecb)
;;(require 'ecb-autoloads)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-solarized-dark)))
 '(custom-safe-themes (quote ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 '(ecb-layout-name "left15")
 '(ecb-layout-window-sizes (quote (("left15" (ecb-directories-buffer-name 0.2 . 0.69875) (ecb-history-buffer-name 0.16 . 0.265625)))))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(ecb-source-path (quote ("~/erlang_projects/redesign/Phoenix" "~/erlang_projects/qks" "~/erlang_projects/Qks_app")))
 '(ecb-tip-of-the-day nil)
 '(ecb-tree-buffer-style (quote image))
 '(ede-project-directories (quote ("/Users/dskliarov/cpp_projects/cppl"))))

;;;;;;;;;;;;;;;;;;;;;;;;
;;  
;; Resource Aware ML
;;
;; Emacs Mode
;;
;; Author: Jan Hoffmann
;;
;; Year: 2011,2012
;;

(provide 'raml-mode)

(add-to-list 'auto-mode-alist '("\\.raml\\'" . raml-mode))

(setq path-to-raml "$HOME/Library/Bin/raml")
(setq raml-output-buffer "*RAML Output*")
(setq raml-process-name "RAML")

(setq raml-verbose nil)
(setq raml-time t)
(setq raml-keep-temp-files nil)
(setq raml-max-degree 2)

(setq raml-keywords
 '())

;; define a var for your keymap, so that you can set it as local map
;; (meaning, active only when your mode is on)
(defvar raml-mode-map nil "Keymap for raml-mode")

;; assign your keyboard shortcuts
(setq raml-mode-map (make-sparse-keymap)) 
(define-key raml-mode-map (kbd "C-c C-c") 'raml-evaluate) 
(define-key raml-mode-map (kbd "C-c C-h") 'raml-analyse-heap) 
(define-key raml-mode-map (kbd "C-c C-e") 'raml-analyse-eval) 
(define-key raml-mode-map (kbd "C-c C-t") 'raml-analyse-ticks) 
(define-key raml-mode-map (kbd "C-c C-o") 'raml-analyse-overflow) 
(define-key raml-mode-map (kbd "C-c C-v") 'raml-set-verbose)
(define-key raml-mode-map (kbd "C-c C-S-k") 'raml-set-keep-temp-files)
(define-key raml-mode-map (kbd "C-c C-S-t") 'raml-set-time) 
(define-key raml-mode-map (kbd "C-c C-d") 'raml-set-max-degree) 
(define-key raml-mode-map (kbd "C-c C-k") 'raml-kill-run) 

;; the command to comment/uncomment text
(defun raml-comment-dwim (arg)
"Comment or uncomment current line or region in a smart way.
For detail, see `comment-dwim'."
   (interactive "*P")
   (require 'newcomment)
   (let ((deactivate-mark nil) (comment-start "(*") (comment-end "*)"))
     (comment-dwim arg)))

(define-derived-mode raml-mode fundamental-mode
  (setq font-lock-defaults '(raml-keywords))
  
  ;; modify the keymap
  (define-key raml-mode-map [remap comment-dwim] 'raml-comment-dwim)

  (setq mode-name "RAML")

  (use-local-map raml-mode-map)

  ;; Mathematica style comment: â€œ(* ... *)â€ 
  (modify-syntax-entry ?\( "() 1" raml-mode-syntax-table)
  (modify-syntax-entry ?\) ")( 4" raml-mode-syntax-table)
  (modify-syntax-entry ?* ". 23" raml-mode-syntax-table)
)

(defun raml-set-max-degree ()
  "Set the maximal degree."
  (interactive)
  (let* (
   (degree (read-number "Maximal degree: " 2))
   (msg (concat "The maximal degree is now " (number-to-string degree) ".") )
  )
  (setq raml-max-degree degree)
  (message msg)
  )
)

(defun raml-set-keep-temp-files ()
  "Toggle verbose output."
(interactive)
(if raml-keep-temp-files
 (progn (setq raml-keep-temp-files nil)
        (message "RAML is now deleting temporary files.") )
 (setq raml-keep-temp-files t)
 (message "RAML is now keeping temporary files.")
)
)

(defun raml-set-verbose ()
  "Toggle verbose output."
(interactive)
(if raml-verbose
 (progn (setq raml-verbose nil)
        (message "RAML is now non-verbose.") )
 (setq raml-verbose t)
 (message "RAML is now verbose.")
)
)

(defun raml-set-time ()
  "Toggle time measurement."
(interactive)
(if raml-time
 (progn (setq raml-time nil)
        (message "RAML run time counter off.") )
 (setq raml-time t)
 (message "RAML run time counter on.")
))

(defun raml-options ()
  (let* ((time (if raml-time " --time" ""))
         (verbose (if raml-verbose " --verbose" ""))
         (keepfiles (if raml-keep-temp-files " --keepfiles" ""))
        )
  (concat time verbose keepfiles)
 ))

(defun raml-analyse-heap ()
  "Analyse the current file."
(interactive)
  (let* (
    (degree (number-to-string raml-max-degree))
    (raml-action (concat "analyse heap-space " degree) )
    (file-name (buffer-file-name))
    (cmd-str (concat path-to-raml " " raml-action " " file-name " " (raml-options)))
   )
   (raml-run cmd-str)
))

(defun raml-analyse-eval ()
  "Analyse the current file."
(interactive)
  (let* (
    (degree (number-to-string raml-max-degree))
    (raml-action (concat "analyse eval-steps " degree) )
    (file-name (buffer-file-name))
    (cmd-str (concat path-to-raml " " raml-action " " file-name " " (raml-options)))
   )
   (raml-run cmd-str)
))

(defun raml-analyse-ticks ()
  "Analyse the current file."
(interactive)
  (let* (
    (degree (number-to-string raml-max-degree))
    (raml-action (concat "analyse ticks " degree) )
    (file-name (buffer-file-name))
    (cmd-str (concat path-to-raml " " raml-action " " file-name " " (raml-options)))
   )
   (raml-run cmd-str)
))

(defun raml-run (cmd-stre)
    (start-process-shell-command raml-process-name raml-output-buffer cmd-str)
;;     (shell-command cmd-str raml-output-buffer)
    (delete-other-windows)
    (split-window-vertically)
    (other-window 1)
    (switch-to-buffer raml-output-buffer)
    (clear-buffer)
    (other-window 1)
)

(defun raml-analyse-overflow ()
  "Analyse the current file."
(interactive)
  (let* (
    (degree (number-to-string raml-max-degree))
    (raml-action (concat "analyse overflow " degree) )
    (file-name (buffer-file-name))
    (cmd-str (concat path-to-raml " " raml-action " " file-name " " (raml-options)))
   )
   (raml-run cmd-str)
))

(defun raml-evaluate ()
  "Evaluate the current file."
(interactive)
  (let* (
    (raml-action (concat "evaluate") )
    (file-name (buffer-file-name))
    (cmd-str (concat path-to-raml " " raml-action " " file-name " " (raml-options)))
   )
   (raml-run cmd-str)
))

(defun clear-buffer()
 "Kill all of the text in the current buffer."
 (interactive)
 (delete-region 1 (point-max))
 (beginning-of-buffer)
)

(defun raml-kill-run ()
 "Kill the running raml execution."
 (interactive)
 (kill-process raml-process-name)
)

(require 'cc-mode)
(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

(require 'autopair)
(autopair-global-mode 1)
(setq autopair-autowrap t)

(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

(require 'ede)
(global-ede-mode)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown")))))
