;;; wclass.jl --- Functions for working with window classes.
;; Copyright 2001 by Dave Pearson <davep@davep.org>
;; $Revision: 1.2 $

;; wclass.jl is free software distributed under the terms of the GNU
;; General Public Licence, version 2. For details see the file COPYING.

;;; Commentary:
;;
;; The following functions allow you to test and work with window classes.

(defun wclass-window-class (#!optional w)
  "Get the WM class of window W.

The class of the the `input-focus' window will be returned if W isn't
supplied."
  (get-x-text-property (or w (input-focus)) 'WM_CLASS))

(defun wclass-window-class-p (w class1 class2)
  "Is window W of a given class?"
  (let ((class (wclass-window-class w)))
    (and (> (length class) 1)
         (and (string= (aref class 0) class1)
              (string= (aref class 1) class2)))))

(defun wclass-find-windows-of-class (class1 class2)
  "Find windows matching the given class."
  (delete-if-not (lambda (w)
                   (wclass-window-class-p w class1 class2))
                 (managed-windows)))

(defun wclass-find-first-window-of-class (class1 class2)
  "Find first window of given class."
  (car (sort (wclass-find-windows-of-class class1 class2)
             (lambda (x y)
               (> (window-get x 'order) (window-get y 'order))))))
