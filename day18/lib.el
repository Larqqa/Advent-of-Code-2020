;;; lib --- helper functions
;;; Commentary:
;;; Code:

(defun r-string (what with in)
"Replace a substring in a string.
WHAT WITH IN"
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal))

(defun parser (str)
"Parse string input to list of numbers and characters.
STR"
  (setq foo (r-string "(" "( " str))
  (setq bar (r-string ")" " )" foo))
  (split-string bar " "))

(defun read-lines (filePath)
"Read file into list by lines.
FILEPATH"
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

(defun sum-list (list)
"Sum a list of numbers.
LIST"
  (if list
      (+ (car list) (sum-list (cdr list))) 0))

(defun evaluate (a b c)
"Evaluate A & B with operand C.
A B C"
  (cond
   ((string= c "+") (+ a b))
   ((string= c "*") (* a b))))

;;; lib.el ends here
