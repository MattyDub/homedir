;(set-default-font "-outline-Envy Code R-normal-r-normal-normal-13-97-96-96-c-*-iso8859-1")
(setq debug-on-error t)

;;;stops emacs from wrapping long lines:
(setq default-truncate-lines t)

;;; Max line length:
(set-fill-column 100)

;; env PATH
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))


;; Place downloaded elisp files in this directory. You'll then be able
;; to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; 
;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")

;; Stuff from ~/.emacs.d/vendor:
(require 'buffhelp)
(require 'efuncs)

;; shell scripts
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")

;; Uncomment this to increase font size
;; (set-face-attribute 'default nil :height 140)
(load-theme 'tomorrow-night-bright t)

;; Flyspell often slows down editing so it's turned off
(remove-hook 'text-mode-hook 'turn-on-flyspell)

;;Key bindings
(global-font-lock-mode 1) ;needs to have positive arg; no arg just toggles
(global-set-key "\C-c\C-g" 'goto-line)
(global-set-key "\C-cf" 'find-function-at-point)
(global-set-key (kbd "<f3>") 'grep-find)
(global-set-key (kbd "<f4>") 'lgrep)
(column-number-mode 1)
(global-set-key "\C-x\C-b" 'list-matching-buffers) ;overrides list-buffers

;; Clojure
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(setq nrepl-history-file "~/.emacs.d/nrepl-history")
(setq nrepl-popup-stacktraces t)
(setq nrepl-popup-stacktraces-in-repl t)
(add-hook 'nrepl-connected-hook
          (defun pnh-clojure-mode-eldoc-hook ()
            (add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
            (add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
            (nrepl-enable-on-existing-clojure-buffers)))
(add-hook 'nrepl-mode-hook 'subword-mode)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)

;; hippie expand - don't try to complete with file names
(setq hippie-expand-try-functions-list (delete 'try-complete-file-name hippie-expand-try-functions-list))
(setq hippie-expand-try-functions-list (delete 'try-complete-file-name-partially hippie-expand-try-functions-list))

(setq ido-use-filename-at-point nil)

;; Save here instead of littering current directory with emacs backup files
(setq backup-directory-alist `(("." . "~/.saves")))

(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode nil)

;;nxml stuff:
(add-to-list 'auto-mode-alist '("\\.xml\\'" . nxml-mode))

;helper functions:
(defun bf-pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
      (nxml-mode)
      (goto-char begin)
      (while (search-forward-regexp "\>[ \\t]*\<" nil t)
        (backward-char) (insert "\n"))
      (indent-region begin end))
    (message "Ah, much better!"))

(defun nxml-where ()
      "Display the hierarchy of XML elements the point is on as a path."
      (interactive)
      (let ((path nil))
        (save-excursion
          (save-restriction
            (widen)
            (while (condition-case nil
                       (progn
                         (nxml-backward-up-element) ; always returns nil
                         t)
                     (error nil))
              (setq path (cons (xmltok-start-tag-local-name) path)))
            (message "/%s" (mapconcat 'identity path "/"))))))

;; org-mode
(add-to-list 'auto-mode-alist'("\\.org$" . org-mode))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;;SQL stuff
(add-to-list 'auto-mode-alist '("\\.pkb$" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.pks$" . sql-mode))

;; Workaround the annoying warnings:
;;    Warning (mumamo-per-buffer-local-vars):
;;    Already 'permanent-local t: buffer-file-name
(when (and (>= emacs-major-version 24)
           (>= emacs-minor-version 2))
  (eval-after-load "mumamo"
    '(setq mumamo-per-buffer-local-vars
           (delq 'buffer-file-name mumamo-per-buffer-local-vars))))

; nxhtml:
;; (load "/Users/matthewwyatt/.emacs.d/vendor/nxhtml/autostart")

;; pymacs/ropemacs stuff:
(add-to-list 'load-path "~/.emacs.d/vendor/Pymacs")
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-autoload "pymacs")

(defun load-ropemacs ()
  "Load pymacs and ropemacs"
  (interactive)
  (require 'pymacs)
  (pymacs-load "ropemacs" "rope-")
  ;; Automatically save project python buffers before refactorings
  (setq ropemacs-confirm-saving 'nil))

(global-set-key "\C-xpl" 'load-ropemacs)
(require 'dash)
(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
(setq venv-location "/Users/matthewwyatt/.virtualenvs/")

(add-hook 'python-mode-hook (lambda ()
                              (hack-local-variables)
                              (venv-workon project-venv-name)))
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t) 
;; (setq jedi:setup-keys t)
(setq python-environment-virtualenv '("/usr/local/bin/virtualenv" "--system-site-packages" "--quiet"))

;(require 'recentf)
;(recentf-mode 1)

;; rainbow delimiters
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

(server-start)

;; This is on purpose:
(put 'downcase-region 'disabled nil)

(add-hook 'nxml-mode-hook
          '(lambda ()
             (auto-fill-mode -1)
             (define-key nxml-mode-map "\C-c\C-c"
               'nxml-complete)))

(add-hook 'nxhtml-mode-hook
          '(lambda ()
             (auto-fill-mode -1)))

;; syntax is:
;; (add-hook <hook name> <function> <append> <local>)
(add-hook 'emacs-lisp-mode-hook 'turn-off-auto-fill t nil)

(add-hook 'python-mode-hook 'turn-off-auto-fill)

(add-hook 'sql-mode-hook 'turn-off-auto-fill)

(add-hook 'js-mode-hook 'turn-off-auto-fill t nil)

(add-hook 'sgml-mode-hook 'turn-off-auto-fill t nil)
(add-hook 'html-mode-hook 'turn-off-auto-fill t nil)

(define-skeleton bs-dj-tbl
  "Creates a bootstrap table with Django template stuff"
  "iterable singular: "
  "<table class=\"table table-condensed table-bordered\">\n"
  "  <thead>\n"
  "  <tr>\n"
  "    <th>" _ "</th>\n"
  "  </tr>\n"
  "  </thead>\n"
  "  <tbody>\n"
  "  {% for " str | " foo" " in " str | "foo" "s %}\n"
  "    <tr>\n"
  "      <td></td>\n"
  "    </tr>\n"
  "  {% endfor %}\n"
  "  </tbody>\n"
  "</table>\n")

(global-linum-mode 1)
