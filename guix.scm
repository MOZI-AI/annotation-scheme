;;; Copyright © 2020 Ricardo Wurmus <rekado@elephly.net>
;;;
;;; This file is part of MOZI-AI Annotation Scheme
;;;
;;; MOZI-AI Annotation Scheme is free software; you can redistribute
;;; it and/or modify it under the terms of the GNU General Public
;;; License as published by the Free Software Foundation; either
;;; version 3 of the License, or (at your option) any later version.
;;;
;;; This software is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this software.  If not, see
;;; <http://www.gnu.org/licenses/>.

(use-modules (guix build-system gnu)
             (guix packages)
             ((guix licenses) #:prefix license:)
             (gnu packages autotools)
             (gnu packages guile)
             (gnu packages guile-xyz)
             (gnu packages opencog)
             (gnu packages pkg-config))

(package
  (name "guile-annotation")
  (version "0-devel")
  (source #f)
  (build-system gnu-build-system)
  (arguments
   '(#:make-flags
     '("GUILE_AUTO_COMPILE=0")))
  (native-inputs
   `(("autoconf" ,autoconf)
     ("automake" ,automake)
     ("pkg-config" ,pkg-config)))
  (inputs
   `(("agi-bio" ,agi-bio)
     ("atomspace" ,atomspace)
     ("guile" ,guile-2.2)
     ("guile-json" ,guile-json-1)))
  (home-page "https://github.com/MOZI-AI/annotation-scheme")
  (synopsis "Human Gene annotation service backend")
  (description "This project contains the Scheme code that is used
by MOZI annotation service.  It annotates Human Gene Symbols using
three databases (GO, Reactome, and Biogrid).")
  (license license:gpl3+))
