;; Packages
(require 'my-lisp)
(require 'package)
(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa"     . "http://melpa.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
(defun packages-install (packages)
  "Given a list of packages, this will install them from the standard locations."
  (let ((to-install (inverse-filter 'package-installed-p packages)))
    (when to-install
      (package-refresh-contents)
      (dolist (it to-install)
          (package-install it)
      (delete-other-windows)))))

(packages-install
 '(flx
   ido
   ido-vertical-mode
   smex
   linum-relative))

(provide 'my-packages)
