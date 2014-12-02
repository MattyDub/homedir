(require 'package)
;; This is set to nil because when I added el-get, I was getting what
;; appeared to be chicken-and-egg problems with external dependencies.
(setq package-load-list '())
;; (message "package-load-list here:")
;; (princ package-load-list)
(package-initialize 'no-activate)
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/") t)
;; (add-to-list 'package-archives
;;              '("tromey" . "http://tromey.com/elpa/") t)

;; (when (not package-archive-contents)
;;   (package-refresh-contents))

;; ;; Add in your own as you wish:
;; (defvar my-packages '(;; starter-kit
;;                       ;; starter-kit-lisp
;;                       ;; starter-kit-bindings
;;                       ;; starter-kit-ruby
;;                       clojure-mode
;;                       clojure-test-mode
;;                       nrepl
;;                       auto-complete
;;                       column-enforce-mode
;;                       ac-nrepl)
;;   "A list of packages to ensure are installed at launch.")

;; (dolist (p my-packages)
;;   (when (not (package-installed-p p))
;;     (package-install p)))

(load "~/.emacs.d/user.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(css-indent-offset 2)
 '(desktop-save t)
 '(desktop-save-mode t)
 '(js-indent-level 2)
 '(safe-local-variable-values
   (quote
    ((project-venv-name . "pims")
     (whitespace-line-column . 80)
     (lexical-binding . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-unmatched-face ((t (:foreground "#ff0000")))))
(put 'upcase-region 'disabled nil)
