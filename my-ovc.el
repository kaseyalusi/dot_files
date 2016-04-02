(defvar ha/overcloud-hosts (make-hash-table :test 'equal)
  "Table of host aliases for IPs or other actual references.")

;; (defun get-os-pw (pw) (interactive "OS Password: ") arg)

(defun ha/overcloud-hosts-get ()
  (interactive)
  ;; Run nova list command remotely on this host system, and put the
  ;; results in a temp buffer:
  (let* ((overcloud-controller "10.98.1.145")
         (default-directory    (format "/ssh:%s:" overcloud-controller))
         (tmp-buffer           "host-list"))
    (message "Populating overcloud hostname cache from %s..."
             overcloud-controller)
    ;; (pass get-os-pw)
    (shell-command "source ./krc; nova list" tmp-buffer)

    (with-current-buffer tmp-buffer
      ;; Assuming we get here, let's invalidate the cache
      (clrhash ha/overcloud-hosts)

      (goto-char (point-min))
      (while (re-search-forward (concat "^| "  ;; Look for the UUID
                                        "[0-9a-fA-F]\\{8\\}-"
                                        "[0-9a-fA-F]\\{4\\}-"
                                        "[0-9a-fA-F]\\{4\\}-"
                                        "[0-9a-fA-F]\\{4\\}-"
                                        "[0-9a-fA-F]\\{12\\} *| *")
                                nil t)
        (let* ((name-s (point))
               (name-e (progn (re-search-forward " ")
                              (1- (match-end 0))))
               (name (buffer-substring-no-properties name-s name-e))

               (addr-s (progn (re-search-forward "cedev.*=")
                              (match-end 0)))
               (addr-e (progn (re-search-forward " ")
                              (1- (match-end 0))))
               (addr (buffer-substring-no-properties addr-s addr-e)))
          (puthash name addr ha/overcloud-hosts)

          ;; Let's create some aliases for certain hosts:
          (if (string-match-p "chef" name)
              (puthash "chef" addr ha/overcloud-hosts))
          (if (string-match "^ci-sdn-\\(.*\\)" name)
              (puthash (match-string 1 name) addr ha/overcloud-hosts))
          (if (string-match "^3node-\\(.*\\)" name)
              (puthash (match-string 1 name) addr ha/overcloud-hosts)))))))

(defun eshell-oc (hostname)
  "Start an eshell experience on a virtual machine in the overcloud."
  (interactive "sHostname: ")

  ;; If our overcloud-hosts cache is empty, we need to fill it:
  (when (= 0 (hash-table-count ha/overcloud-hosts))
    (ha/overcloud-hosts-get))

  ;; The ip address is either the value from a key in our cache, or whatever we pass in:
  (let* ((ipaddr (gethash hostname ha/overcloud-hosts hostname))
         (default-directory (format "/%s:" ipaddr)))
    (message "Connecting to %s at %s ... %s"
             hostname ipaddr default-directory)
    (shell (format "*shell:%s*" hostname))))

(provide 'my-ovc)
