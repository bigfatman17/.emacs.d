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

(require 'flymake)
(add-hook 'find-file-hook 'flymake-find-file-hook)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(add-to-list 'company-backends 'company-c-headers)
(custom-set-faces
;'(company-tooltip ((t (:background "#606060")))))
;`(company-tooltip-common ((t (:inherit font-lock-constant-face))))))
;'(company-tooltip-common ((t (:background "#e5e600")))))
;`(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
;'(company-tooltop-selection ((t (:background "#e5e600")))))
;`(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
;'(company-scrollbar-bg ((t (:background "#e5e600")))))
;`(company-tooltip ((t :background "lightgray" :foreground "black")))
'(company-tooltip ((t :background "lightgray" :foreground "black"))))

(global-set-key (kbd "M-x") 'undefined)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x r b") 'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(helm-mode 1)

(defun show-fly-err-at-point ()
  "If the cursor is sitting on a flymake error, display the
message in the minibuffer"
  (interactive)
  (let ((line-no (line-number-at-pos)))
    (dolist (elem flymake-err-info)
      (if (eq (car elem) line-no)
      (let ((err (car (second elem))))
        (message "%s" (fly-pyflake-determine-message err)))))))

(defun fly-pyflake-determine-message (err)
  "pyflake is flakey if it has compile problems, this adjusts the
message to display, so there is one ;)"
  (cond ((not (or (eq major-mode 'Python) (eq major-mode 'python-mode) t)))
    ((null (flymake-ler-file err))
     ;; normal message do your thing
     (flymake-ler-text err))
    (t ;; could not compile err
     (format "compile error, problem on line %s" (flymake-ler-line err)))))

(defadvice flymake-goto-next-error (after display-message activate compile)
  "Display the error in the mini-buffer rather than having to mouse over it"
  (show-fly-err-at-point))

(defadvice flymake-goto-prev-error (after display-message activate compile)
  "Display the error in the mini-buffer rather than having to mouse over it"
  (show-fly-err-at-point))

(defadvice flymake-mode (before post-command-stuff activate compile)
  "Add functionality to the post command hook so that if the
cursor is sitting on a flymake error the error information is
displayed in the minibuffer (rather than having to mouse over
it)"
  (set (make-local-variable 'post-command-hook)
       (cons 'show-fly-err-at-point post-command-hook))) 
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
