(defun filter (condp lst)
  "Emacs Lisp doesn’t come with a ‘filter’ function to keep
elements that satisfy a conditional and excise the elements that
do not satisfy it. One can use ‘mapcar’ to iterate over a list
with a conditional, and then use ‘delq’ to remove the ‘nil’
values."
  (delq nil
        (mapcar (lambda (x) (and (funcall condp x) x)) lst)))


(defun inverse-filter (condp lst)
  "A filter function, but returns a list of the entries that
don't match the predicate."
  (delq nil
        (mapcar (lambda (x) (and (not (funcall condp x)) x)) lst)))


;; Not a function, but whatever
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(provide 'my-lisp)
