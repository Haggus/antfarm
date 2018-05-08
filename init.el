(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))

(package-initialize)

;; move custom defs out of init.el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(add-to-list 'default-frame-alist '(font . "Fira Mono-12"))
(set-face-attribute 'default t :font "Fira Mono-12")

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package gruvbox-theme
  :ensure t
  :init
  (load-theme 'gruvbox-dark-soft t))

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(use-package helm
  :ensure t
  :diminish helm-mode
  :config

  (require 'helm)
  (require 'helm-files)
  (require 'helm-config)

  (bind-key "<tab>" 'helm-execute-persistent-action helm-map)
  (bind-key [escape] 'helm-keyboard-quit helm-map)

  (helm-mode 1)

  (defun hide-cursor-in-helm-buffer ()
    "Hide cursor in helm buffers"
    (with-helm-buffer
      (setq cursor-in-non-selected-windows nil)))

  (add-hook 'helm-after-initialize-hook 'hide-cursor-in-helm-buffer)

  :bind (("C-x b" . helm-mini)
	 ("C-x C-f" . helm-find-files)
	 ("M-x" . helm-M-x)
	 :map helm-map
	 ("C-j" . helm-next-line)
	 ("C-k" . helm-previous-line)
	 :map helm-find-files-map
	 ("C-l" . helm-execute-persistent-action)
	 ("C-h" . helm-find-files-up-one-level)
	 :map helm-read-file-map
	 ("C-l" . helm-execute-persistent-action)
	 ("C-h" . helm-find-files-up-one-level)))

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  (evil-mode t))

(use-package magit
  :ensure t
  :defer t
  :bind ("C-x g" . magit-status)
  :init
  (setq magit-diff-refine-hunk 'all)
  ;; Use evil keybindings within magit
  (use-package evil-magit
    :ensure t))
