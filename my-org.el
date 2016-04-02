(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit outline-1 :foreground "red"))))
 '(org-level-2 ((t (:inherit outline-2 :foreground "cyan"))))
 '(org-level-3 ((t (:inherit outline-3 :foreground "#00FF22"))))
 '(org-level-4 ((t (:inherit outline-4 :foreground "#FF00FF")))))

(setq org-src-fontify-natively t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (R . t)
   (ruby . t)
   (ditaa . t)
   (dot . t)
   (octave . t)
   (sqlite . t)
   (perl . t)
   ))

(provide 'my-org)
