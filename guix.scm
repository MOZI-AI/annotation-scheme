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
             (guix git-download)
             ((guix licenses) #:prefix license:)
             (gnu packages autotools)
             (gnu packages guile)
             (gnu packages guile-xyz)
             (gnu packages mes)
             (gnu packages opencog)
             (gnu packages pkg-config)
             (gnu packages texinfo))

(define-public guile-json-fork
  (let ((commit "b835684116c824ebbaea7ec0bb12d5b2b1dc9b83")
        (revision "1"))
    (package (inherit guile-json-3)
      (name "guile-json-fork")
      (version "2.9")
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://github.com/Habush/guile-json.git")
                      (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  "1ahh33hxb4bf6amq7rnzy1s3q9x4mc5hb6mrk69k5n0vid9bs2ci"))))
      (arguments
       `(#:phases
         (modify-phases %standard-phases
           (add-after 'unpack 'fix-Makefile
             (lambda _
               (substitute* "configure.ac"
                 (("GUILE_PROGS")
                  "GUILE_PKG([3.0 2.2 2.0])\nGUILE_PROGS\nGUILE_SITE_DIR"))
               (substitute* "Makefile.am"
                 (("EXTRA_DIST.*")
                  "nobase_nodist_obj_DATA = $(GOBJECTS)")
                 (("^moddir.*")
                  "\
moddir=$(datadir)/guile/site/$(GUILE_EFFECTIVE_VERSION)
objdir=$(libdir)/guile/$(GUILE_EFFECTIVE_VERSION)/site-ccache"))
               (substitute* "json/Makefile.am"
                 (("EXTRA_DIST.*")
                  "nobase_nodist_obj_DATA = $(GOBJECTS)")
                 (("^moddir.*")
                  "\
moddir=$(datadir)/guile/site/$(GUILE_EFFECTIVE_VERSION)/json
objdir=$(libdir)/guile/$(GUILE_EFFECTIVE_VERSION)/site-ccache/json")))))))
      (native-inputs
       `(("autoconf" ,autoconf)
         ("automake" ,automake)
         ,@(package-native-inputs guile-json-3))))))

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
     ("guile-json" ,guile-json-fork)))
  (home-page "https://github.com/MOZI-AI/annotation-scheme")
  (synopsis "Human Gene annotation service backend")
  (description "This project contains the Scheme code that is used
by MOZI annotation service.  It annotates Human Gene Symbols using
three databases (GO, Reactome, and Biogrid).")
  (license license:gpl3+))
