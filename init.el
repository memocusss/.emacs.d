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
    ;doom-modeline
    flatland-theme
    zenburn-theme
    helm-themes
    inkpot-theme
    web-mode
    magit
    use-package
    monokai-theme
    org
    snippet
    dracula-theme
    restart-emacs
    ample-theme
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
(load-theme 'ample t)
(global-linum-mode t) ;; enable line numbers globally
;(require 'doom-modeline)
;(doom-modeline-init)
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(global-set-key (kbd "M-o") 'other-window)

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
 ("cbox" . "[ ]"))
(add-hook 'org-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (setq local-abbrev-table org-mode-abbrev-table)))

;; WEB-MODE CONFIGURATION
;; --------------------------------------
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))

(setq web-mode-enable-auto-pairing t)

(setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'")
        ("blade"  . "\\.blade\\.")
        ("html"   . "\\.html\\'")
        ("css"    . "\\.css\\'"))
      )

(add-to-list 'auto-mode-alist '("\\.api\\'" . web-mode))
(add-to-list 'auto-mode-alist '("/some/react/path/.*\\.js[x]?\\'" . web-mode))

(setq web-mode-content-types-alist
  '(("json" . "/some/path/.*\\.api\\'")
    ("xml"  . "/other/path/.*\\.api\\'")
    ("jsx"  . "/some/react/path/.*\\.js[x]?\\'")))

;; HELM CONFIGURATION
;; --------------------------------------
(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

;; NEOTREE CONFIGURATION
;; -------------------------------------
(require 'all-the-icons)
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons))

;; PYTHON CONFIGURATION
;; --------------------------------------
(elpy-enable)
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; init.el ends here
