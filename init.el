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
    company
    company-web
    emmet-mode
    all-the-icons
    beacon
    projectile
    solarized-theme
    zoom
    buffer-move
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
(ido-mode 1)
(setq ido-enable-flex-matching t)
(global-set-key (kbd "M-o") 'other-window)
(require 'all-the-icons)
(require 'yasnippet)
(yas-global-mode 1)
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(beacon-mode 1)
(load-theme 'solarized-light 't)
(set-default-font "Hack 11")

;; BUFFER MOVE CONFIGURATION
;; --------------------------------------
(global-set-key (kbd "<C-M-up>")     'buf-move-up)
(global-set-key (kbd "<C-M-down>")   'buf-move-down)
(global-set-key (kbd "<C-M-left>")   'buf-move-left)
(global-set-key (kbd "<C-M-right>")  'buf-move-right)
(setq buffer-move-stay-after-swap t)

;; ZOOM CONFIGURATION
;; --------------------------------------
(zoom-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (buffer-move zoom leuven-theme w32-browser web-mode use-package snippet restart-emacs py-autopep8 projectile neotree magit helm flycheck emmet-mode elpy ein company-web better-defaults beacon all-the-icons)))
 '(zoom-size (quote (0.618 . 0.618))))


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
(setq neo-theme 'arrow)


;; WEB-MODE CONFIGURATION
;; --------------------------------------
(require 'web-mode)
(add-hook 'web-mode-hook 'company-mode)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
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
(setq elpy-rpc-python-command "python")

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save and delete trailing whitespace
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; init.el ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
