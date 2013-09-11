
(defun list-matching-strings (regex string-list)
  "Returns a list of strings from STRING-LIST that match the regular expression provided."
  (let (foo '())
  (dolist (elm string-list (nreverse foo))
    (if (string-match regex elm)
        (setq foo (cons elm foo))))))

;; Something about this seems wrong - like there should be a cleaner
;; way to do it than with let*.  I would just expect something more
;; functional, you know? (SEE BELOW)
;; (defun list-matching-buffers (regex)
;;   "Display a list of names of buffers matching a prompted-for regexp.
;; If no regexp is provided, it defaults to the standard behavior of
;; 'list-buffers'.  The list is displayed in a buffer named `*Buffer
;; List*'.  Note that buffers with names starting with spaces are
;; omitted."
;;   (interactive "sPattern to match: ")
;;   (if regex
;;       (let* ((buff-name-list (mapcar 'buffer-name (buffer-list)))
;;              (non-space-start (remove-if (lambda (x)(= (string-to-char x) 32)) buff-name-list)) ;32 is the char for space
;;              (matching-strings (list-matching-strings regex non-space-start)))
;;              (display-buffer (list-buffers-noselect 't (mapcar 'get-buffer matching-strings))))
;;     (list-buffers)))

;;Exploded version; took out the let*:
(defun list-matching-buffers (regex)
  "Display a list of names of currently-visited files matching a
  prompted-for regexp. If no regexp is provided, it defaults to the standard
  behavior of 'list-buffers'.  The list is displayed in abuffer named `*Buffer
  List*'.  Note that buffers with names starting with spaces are omitted.
  Uses 'remove-if' from cl-seq."
  (interactive "sPattern to match: ")
  (if regex
      (display-buffer
       (list-buffers-noselect nil
                              (mapcar
                               'get-file-buffer
                               (list-matching-strings
                                regex
                                (remove-if (lambda (x)
                                             (or
                                              (not x)
                                              (= (string-to-char x) 32))) ;32 is the char for space
                                           (mapcar 'buffer-file-name (buffer-list)))))))
    (list-buffers)))

(defun kill-matching-buffers (regex)
  "Kills buffers whose names match the regex provided.
If none match, it calls 'kill-some-buffers' instead."
  (interactive "sPattern to kill: ")
  (if regex
      (let ((buff-list (mapcar 'buffer-name (buffer-list))))
        (mapc 'kill-buffer (mapcar 'get-buffer (list-matching-strings regex buff-list))))
    (kill-some-buffers)))

(defun kill-buffers-matching-filename (regex)
  "Kills buffers whose file names match the regex provided.
If none match, it calls 'kill-some-buffers' instead."
  (interactive "sFilename pattern to kill: ")
  (if regex
      (let ((buff-list (remove 'nil (mapcar 'buffer-file-name (buffer-list)))))
        (mapc 'kill-buffer (mapcar 'get-file-buffer (list-matching-strings regex buff-list))))
    (kill-some-buffers)))

(provide 'buffhelp)
