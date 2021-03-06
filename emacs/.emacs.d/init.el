(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                 (not (gnutls-available-p))))
    (proto (if no-ssl "http" "https")))
    (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
    (when (< emacs-major-version 24)
      (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)


;; Redifine some keys.

(global-set-key (kbd "C-x j") 'save-buffer)


;; Save backup files to /tmp

(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

;; gui related stuff.

					; no menubar
(menu-bar-mode -1)
					; disable scrollbar
(toggle-scroll-bar -1)
					; disable toolbar
(tool-bar-mode -1)
					; no welcome page
(setq inhibit-startup-message t)

;; lsp settings
(setq gc-cons-threshhold 10000000)
(setq lsp-enable-semantic-highlighting t)

;; rust related settings.

(setq lsp-rust-analyzer-server-command "rust-analyzer")
(add-hook 'before-save-hook (lambda () (when (eq 'rust-mode major-mode)
                                           (lsp-format-buffer))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(glsl-mode dap-mode lsp-mode company rust-mode use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
