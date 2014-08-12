(in-package :cl-user)
(defpackage :ark.timer
  (:use :cl))
(in-package :ark.timer)

(defparameter *buffer-size* 0)

(defun my-command-line ()
  (or
   #+SBCL sb-ext:*posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   #+CLISP *args*
   nil))

(defun get-timer-seconds (args)
  (let ((end-index (1- (length args))))
    (do*
     ((n 0 (1+ n))
      (arg (parse-integer (nth n args) :junk-allowed T) (parse-integer (nth n args) :junk-allowed T))
      (is-num (numberp arg) (numberp arg)))
     ((or (>= n end-index)
         is-num)
      (if is-num arg 0)))))

(defun clear-buffer (buffer-size)
  (format T "~A" #\return)
  (format T "~v@{~A~:*~}" buffer-size " ")
  (format T "~A" #\return))

(defun update-screen (time-to-finish)
  (clear-buffer *buffer-size*)
  (let ((output (format nil "~A..." time-to-finish)))
    (format T output)
    (finish-output)
    (setf *buffer-size* (length output))))


(defun cli-timer (timer-seconds)
  (let ((done-time (+ timer-seconds (get-universal-time))))
    (do* ((current-time (get-universal-time) (get-universal-time))
         (time-to-finish (- done-time current-time) (- done-time current-time)))
        ((>= current-time done-time) (format T "~%Timer Finished~%") T)
      (update-screen time-to-finish)
      (sleep 1))))

;;;;;;;;;;;;;;;;;;;MAIN
(cli-timer (get-timer-seconds (my-command-line)))

