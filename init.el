;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    ein
    elpy
    flycheck
    material-theme
    py-autopep8
    helm
    all-the-icons
    neotree
    web-mode
    magit
    use-package
    org
    snippet
    restart-emacs
    powerline
    company
    company-web
    emmet-mode
    all-the-icons
    beacon
    atom-one-dark-theme
    projectile
    ))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------
(require 'better-defaults)
(setq inhibit-startup-message t) ;; hide the startup message
(setq inhibit-startup-echo-area-message t)
(global-linum-mode t)
(load-theme 'atom-one-dark t)
(require 'powerline)
(powerline-default-theme)
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(global-set-key (kbd "M-o") 'other-window)
(require 'all-the-icons)
(require 'yasnippet)
(yas-global-mode 1)
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(beacon-mode 1)

;; HELM CONFIGURATION
;; --------------------------------------
(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

;; ORG MODE CONFIGURATION
;; -------------------------------------
(require 'org)
(require 'snippet)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

(define-abbrev-table 'org-mode-abbrev-table())
(snippet-with-abbrev-table
 'org-mode-abbrev-table
 ("cbox" . "- [ ] "))
(add-hook 'org-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (setq local-abbrev-table org-mode-abbrev-table)))

;; NEOTREE CONFIGURATION
;; -------------------------------------
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons))

;; WEB-MODE CONFIGURATION
;; --------------------------------------
(require 'web-mode)
(add-hook 'web-mode-hook 'company-mode)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))

(setq web-mode-style-padding 2)
(setq web-mode-script-padding 2)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-enable-current-column-highlight t)
(setq web-mode-enable-current-element-highlight t)

;; EMMET-MODE CONFIGURATION
;; -------------------------------------
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(add-hook 'web-mode-hook 'emmet-mode)

;; COMPANY CONFIGURATION
;; --------------------------------------
(require 'company)
(defun my-web-mode-hook ()
  (set (make-local-variable 'company-backends) '(company-css company-web-html company-yasnippet company-files))
  )
(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'emmet-mode-hook 'company-mode)
(add-hook 'web-mode-hook 'company-mode)
(add-hook 'css-mode-hook 'company-mode)

;; PYTHON CONFIGURATION
;; --------------------------------------
(elpy-enable)
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")
(setq elpy-rpc-python-command "/usr/bin/python")

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save and delete trailing whitespace
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "adf5275cc3264f0a938d97ded007c82913906fc6cd64458eaae6853f6be287ce" default)))
 '(package-selected-packages
   (quote
    (atom-one-dark-theme beacon web-mode use-package snippet restart-emacs py-autopep8 powerline neotree material-theme magit helm flycheck emmet-mode elpy ein company-web better-defaults all-the-icons))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
