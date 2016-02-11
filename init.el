(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'cc-mode)
(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

(require 'autopair)
(autopair-global-mode 1)
(setq autopair-autowrap t)

(require 'ecb)
(require 'ecb-autoloads)
(setq ecb-layout-name "left2")
(setq ecb-show-sources-in-directories-buffer 'always)
; toggle
(global-set-key (kbd "C-x ;") 'ecb-activate)
(global-set-key (kbd "C-x '") 'ecb-deactivate)
; navigate
(global-set-key (kbd "C-x 1") 'ecb-goto-window-edit1)
(global-set-key (kbd "C-x 2") 'ecb-goto-window-directories)
(global-set-key (kbd "C-x 3") 'ecb-goto-window-sources)
(global-set-key (kbd "C-x 4") 'ecb-goto-window-compilation)

(require 'yasnippet)
(yas-global-mode 1)

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (if (derived-mode-p 'c-mode 'c++-mode)
	        (cppcm-reload-all)
	      )))

(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'c++-mode-hook
	  (lambda ()
	    (setq flycheck-clang-language-standard "c++11")
	      ))
(eval-after-load 'flycheck
    '(progn
	(set-face-attribute 'flycheck-warning nil
			    :background "yellow")
	(set-face-attribute 'flycheck-error nil
			    :background "red")))

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(add-to-list 'company-backends 'company-c-headers)
(custom-set-faces
'(company-tooltip ((t :background "lightgray" :foreground "black"))))

(global-set-key (kbd "M-x") 'undefined)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x r b") 'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(helm-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (manoj-dark)))
 '(ecb-options-version "2.40"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
