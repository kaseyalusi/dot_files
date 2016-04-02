;; ido
(require 'flx)
(require 'ido)
(require 'ido-vertical-mode)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(require 'smex)
(smex-initialize)

(global-set-key (kbd "C-q") 'toggle-comment-on-line)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-z") 'smex)  ;; Zap to char isn't so helpful
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(ido-mode 1)
(ido-vertical-mode 1)

(provide 'my-ido)
