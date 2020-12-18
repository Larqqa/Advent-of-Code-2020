;;; part2 --- Part 2 of day 18
;;; Commentary:
;;; Code:

(setq max-lisp-eval-depth 10000)
(setq max-specpdl-size 10000)
(load-file "./lib.el")

(defun part2 (filename)
"Run part 2 of day 18.
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

       ((string= char ")")
        (push char operands))

       (t (while (and operands (string= (nth 0 operands) "+"))
            (push (evaluate (pop numbers) (pop numbers) (pop operands)) numbers))
          (push char operands))))

    (while operands
      (push (evaluate (pop numbers) (pop numbers) (pop operands)) numbers))

    (push (pop numbers) sums))

  (sum-list sums))

(print (part2 "resources/input"))

;;; part2.el ends here
