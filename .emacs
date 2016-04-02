(add-to-list 'load-path "~/.emacs.d/files")
	 
(require 'my-lisp)
(require 'my-packages)
(require 'my-ido)
(require 'my-mac)
(require 'my-org)
(require 'my-keys)
;; (require 'my-erc)
(require 'my-ovc)

(load-theme 'spolsky t)
(add-to-list 'default-frame-alist
	     '(font . "DejaVu Sans Mono-14"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit outline-1 :foreground "red"))))
 '(org-level-2 ((t (:inherit outline-2 :foreground "cyan"))))
 '(org-level-3 ((t (:inherit outline-3 :foreground "#00FF22"))))
 '(org-level-4 ((t (:inherit outline-4 :foreground "#FF00FF")))))


(defun ha/folder-action-save-hook ()
  "A file save hook that will look for a script in the same
directory, called .on-save.  It will then execute that script
asynchronously."
  (interactive)
  (let* ((filename (buffer-file-name))
         (parent   (locate-dominating-file filename ".on-save"))
         (cmd      (concat parent ".on-save " filename)))
    (write-file filename nil)

    ;; Need to re-add the hook to the local file:
    (add-hook 'local-write-file-hooks 'ha/folder-action-save-hook)

    (when parent
      (async-shell-command cmd))))

(add-hook 'after-save-hook 'ha/folder-action-save-hook)
