(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))

(package-initialize)

;; move custom defs out of init.el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(add-to-list 'default-frame-alist '(font . "Fira Mono-12"))
(set-face-attribute 'default t :font "Fira Mono-12")

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package zenburn-theme
  :ensure t
  :init
  (load-theme 'zenburn t))

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(use-package evil
  :ensure t
  :init
  (evil-mode))
