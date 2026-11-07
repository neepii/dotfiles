(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tab-bar-mode t)

(ido-mode t)
(ido-everywhere)
(winner-mode t)
(setq ido-auto-merge-work-directories-length -1)

(set-face-attribute 'default nil :height 60)
(set-frame-font "JetBrainsMonoNL Nerd Font Propo" nil t)
(fringe-mode 0)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package yasnippet
  :ensure t
  :config (yas-global-mode 1))
(require 'smex)
(require 'standard-themes)
(require 'use-package)
(use-package format-all
  :ensure t
  :hook ((c++-mode . format-all-mode)
         (python-mode . format-all-mode)
         (rust-mode . format-all-mode))
  :config
  (add-to-list 'exec-path "/home/neepi/.rye/shims")
  (setq format-all-formatters
        '(("Python" (black))
          ("Rust" (rustfmt))))
  (add-hook 'before-save-hook #'format-all-buffer))

(load-theme 'standard-dark t)
(yas-global-mode 1)
(smex-initialize)
(global-set-key (kbd "M-o") 'vterm)
(global-set-key (kbd "C-;") 'replace-regexp)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(setq initial-buffer-choice "~/.emacs")
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-offset 4)
(setq go-basic-offset 4)
(global-set-key (kbd "<f5>") 'recompile)
(global-set-key (kbd "<f6>") 'compile)

(global-set-key (kbd "C-c C->") 'mc/mark-all-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-e") 'mc/edit-lines)
;; (add-to-list 'mc/unsupported-minor-modes 'flyspell-mode)

(global-set-key (kbd "M-n") 'flymake-goto-next-error)
(global-set-key (kbd "M-p") 'flymake-goto-prev-error)

;; colorize compiliation buffer
(require 'ansi-color)
(add-hook 'compilation-filter-hook #'ansi-color-compilation-filter)


;; org
(use-package org
  :ensure t
  :config
  (global-set-key (kbd "C-c l") #'org-store-link)
  (global-set-key (kbd "C-c a") #'org-agenda)
  (global-set-key (kbd "C-c c") #'org-capture))

;; format-all

(setq-default c-default-style '((java-mode . "java") (awk-mode . "awk") (other . "bsd")))
(setq-default format-all-formatters
      '(("C++" (clang-format))
        ("C" (clang-format))
        ("OCaml" (ocamlformat))
        ("Python" (black))
        ("Tuareg" (ocamlformat))
        ("Verilog" (verihogg-format))))

;; reverse-im
(use-package reverse-im
  :ensure t
  :demand t
  :custom
  (reverse-im-input-methods '("russian-computer"))
  :config
  (reverse-im-mode t))

;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; git changes highlights

(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode))

;; direnv
(use-package direnv
  :ensure t
  :config (direnv-mode))

;; dap mode
(use-package dape
  :ensure t
  :config
  (dape-breakpoint-global-mode 1)  
  (setq dape-buffer-window-arrangement 'right)
  (repeat-mode 1)
  (setq dape-verbose t)
  (setq dape-request-timeout 5))


(with-eval-after-load 'dape
  (add-to-list 'dape-configs
               `(cpptools
                 command "lldb-dap"
                 command-cwd "."
                 :cwd "."
                 :program dape-find-program
                 :args []
                 :setupCommands [( :description "Enable pretty-printing for gdb"
                                  :text "-enable-pretty-printing"
                                  :ignoreFailures "true" )]
                 :stopAtEntry "false"
                 :cwd default-directory)))


(global-set-key (kbd "<f9>") 'dape)         ;; Start debugging
(global-set-key (kbd "<f10>") 'dape-next)
(global-set-key (kbd "<f11>") 'dape-step-in)
(global-set-key (kbd "<f12>") 'dape-quit)

(use-package repeat
  :config
  (repeat-mode 1))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "Welcome back")
  (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content t)  
  (setq dashboard-items '((projects . 10)))
  (setq dashboard-startup-banner `logo)
  (setq dashboard-footer-messages '(""))
  (setq dashboard-projects-backend 'projectile)
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))))

(use-package projectile
  :ensure t
  :config
  (projectile-mode 1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package treemacs-nerd-icons
  :after (treemacs)
  :config
  (treemacs-nerd-icons-config))

(use-package treemacs
  :ensure t
  :config
  (setq treemacs-width 20)
  (setq treemacs-width-is-locked nil)
  :bind
  (:map global-map)
      ("M-0"       . treemacs-select-window))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t
  :config
  (treemacs-projectile))

;; transient

(setq package-install-upgrade-built-in t)

(use-package transient
  :ensure t)

;; rust
(use-package rust-mode
  :ensure t)

;; smtlib
(use-package z3-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.z3\\'" . z3-mode)))

;; remove backup files
(setq make-backup-files nil)
(setq backup-directory-alist            '((".*" . "~/.Trash")))


;; lsps

(setq read-process-output-max (* 3 1024 1024))
(setq gc-cons-threshold (* 100 1024 1024))

(use-package eglot
  :ensure t
  :config
  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-hook 'c++-mode-hook 'eglot-ensure)
  (add-hook 'go-mode-hook 'eglot-ensure)
  (add-hook 'tuareg-mode-hook 'eglot-ensure)
  (add-hook 'haskell-mode-hook 'eglot-ensure)
  (add-hook 'rust-mode-hook 'eglot-ensure)
  (add-hook 'python-mode-hook 'eglot-ensure)
  (add-to-list 'eglot-server-programs '((c++-mode) "clangd"))
  (add-to-list 'eglot-server-programs '((c-mode) "clangd"))
  (add-to-list 'eglot-server-programs '((tuareg-mode) "ocamllsp"))
  (add-to-list 'eglot-server-programs '((go-mode) "gopls"))
  (add-to-list 'eglot-server-programs '((verilog-mode) "veriblels"))
  (add-to-list 'eglot-server-programs '((python-mode) "pylsp"))
  (add-to-list 'eglot-server-programs '((rust-mode) "rust-analyzer")))
  ;; (add-to-list 'eglot-server-programs '((haskell-mode) "haskell-language-server-9.10.3"))


;; unbinds
(global-unset-key (kbd "C-x m"))

;; custom things
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; ocaml
;; Configure Flymake for verbose diagnostics
(use-package flymake
  :ensure t
  :pin gnu
  :config
  (setq flymake-diagnostic-format-alist
        '((t . (origin code message)))))

;; Configure neocaml
(use-package neocaml
  :ensure t)

;; Configure OCaml-eglot
(use-package ocaml-eglot
  :ensure t
  :after neocaml
  :hook
  (neocaml-base-mode . ocaml-eglot-mode)
  (ocaml-eglot-mode . eglot-ensure)
  (ocaml-eglot-mode . (lambda () (add-hook #'before-save-hook #'eglot-format nil t)))
  :config
  (setq ocaml-eglot-syntax-checker 'flymake))

;; Additional modes configuration
(use-package opam-switch-mode
  :ensure t
  :hook
  (neocaml-base-mode . opam-switch-mode))


;; global hi-lock mode
(global-hi-lock-mode 1)

(setq hi-lock-file-patterns-policy (lambda (dummy) t))

(with-eval-after-load 'hi-lock
  (highlight-phrase "\\bTODO\\b" 'hi-yellow))
(put 'scroll-left 'disabled nil)

;; nerdiest config part you will ever seen

;; (defun my/automated-task ()
;;   (interactive)      ; 1. Allow the user to trigger this manually via M-x
;;   (save-excursion    ; 2. Take a snapshot of where the cursor is *right now*
    
;;     ;; -----------------------------------------------------------------
;;     ;; [Your core automation code runs here]
;;     ;; It might jump to line 1, modify every line, and end up on line 800
;;     ;; -----------------------------------------------------------------
    
;;     )                ; 3. Teleport the cursor instantly back to step 2's snapshot
;;   )

(defun my/renumber-requirements ()
  "Automatically scans the buffer and renumbers headlines starting with FR-XXX."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((counter 1))
      (while (re-search-forward "^\\(.*\\) \\(\\w\\w\\)-[0-9]\\{3\\}" nil t)
        (replace-match (format "\\1 \\2-%03d" counter))
        (setq counter (1+ counter)))
      (message "Successfully renumbered requirements up to FR-%03d!" (1- counter)))))
    
