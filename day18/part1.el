;;; part1 --- part 1 of day 18
;;; Commentary:
;;; Code:

(setq max-lisp-eval-depth 10000)
(setq max-specpdl-size 10000)
(load-file "./lib.el")

(defun part1 (filename)
"Run part 1 of day 18.
FILENAME"
  (setq sums '())

  (dolist (line (read-lines filename))
    (setq numbers '())
    (setq operands '())

    (dolist (char (reverse (parser line)))
      (cond
       ((> (string-to-number char) 0)
        (push (string-to-number char) numbers))

       ((string= char "(")
        (while (not (string= (nth 0 operands) ")"))
          (push (evaluate (pop numbers) (pop numbers) (pop operands)) numbers))
        (pop operands))

       (t (push char operands))))

    (while operands
      (push (evaluate (pop numbers) (pop numbers) (pop operands)) numbers))

    (push (pop numbers) sums))

  (sum-list sums))

(print (part1 "resources/input"))

;;; part1.el ends here
