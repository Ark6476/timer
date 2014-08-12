;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(defpackage #:timer-asd
  (:use :cl :asdf))

(in-package :timer-asd)

(defsystem timer
  :name "timer"
  :version "0.1"
  :author "Ark"
  :serial t
  :components ((:file "package")
               (:file "timer")))

