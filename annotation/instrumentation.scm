;;; MOZI-AI Annotation Scheme
;;; Copyright © 2019 Linas Vepstas
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

(use-modules (ice-9 format))

(define (accum-time name)
"
   accum-time -- Maintain performance profile manually.

   This allows the programmer to manually instrument specific locations
   in a code base, and obtain the elapsed time spent in those regions.

   Example usage:

      (define actr (accum-time \"foo\"))
      (define bctr (accum-time \"bar\"))
      (actr #:enter? #t) ; start timing foo
      (bctr #:enter? #t) ; start timing bar
      (bctr #:enter? #f) ; stop  timing bar
      (bctr #:enter? #t) ; start timing bar
      (bctr #:enter? #f) ; stop  timing bar
      (bctr #:enter? #t) ; start timing bar
      (bctr #:enter? #f) ; stop  timing bar
      (actr #:enter? #f) ; stop  timing foo
      (actr #:report? #t) ; report foo
      (bctr #:report? #t) ; report bar

   A less abstract example, in the form of a diff:

      +      (define find-parent-ctr (accum-time \"find-parent\"))
      +
      -(define find-parent
      +(define (find-parent a b)
      +       (find-parent-ctr #:enter? #t)
      +       (let ((rv (xfind-parent a b)))
      +       (find-parent-ctr #:enter? #f)
      +       rv))
      +       
      +(define xfind-parent

   See issue https://github.com/MOZI-AI/annotation-scheme/issues/98
   for a detailed example of the data that can be obtained in this way.
"
	(let ((fname name)
			(elapsed 0)
			(calls 0)
			(start 0))
		(lambda* (#:key (enter? #f) (report? #f))
			(if report?
				(if (< 0 calls)
					(format #t 
						"Time: ~9f secs. calls: ~A avg: ~8,1f usec/call for ~A\n"
						(* 1.0e-9 elapsed)
						calls
						(/ (* 1.0e-3 elapsed) calls)
						fname)
					(format #t "Zero calls to ~A\n" fname))
				(if enter?
					(set! start (get-internal-real-time))
					(begin
						(set! elapsed (+ elapsed
							(- (get-internal-real-time) start)))
						(set! calls (+ calls 1)))))))
)

; ---------------------------------------------------------------------
; Report the average time spent in GC.
(define-public report-avg-gc-cpu-time
	(let ((last-gc (gc-stats))
			(start-time (get-internal-real-time))
			(run-time (get-internal-run-time)))
		(lambda ()
			(define now (get-internal-real-time))
			(define run (get-internal-run-time))
			(define cur (gc-stats))
			(define gc-time-taken (* 1.0e-9 (- (cdar cur) (cdar last-gc))))
			(define elapsed-time (* 1.0e-9 (- now start-time)))
			(define cpu-time (* 1.0e-9 (- run run-time)))
			(define ngc (- (assoc-ref cur 'gc-times)
				(assoc-ref last-gc 'gc-times)))
			(format #t "Elapsed: ~6f secs. Rate: ~5f gc/min %cpu-GC: ~5f%  %cpu-use: ~5f%\n"
				elapsed-time
				(/ (* ngc 60) elapsed-time)
				(* 100 (/ gc-time-taken elapsed-time))
				(* 100 (/ cpu-time elapsed-time))
			)
			(set! last-gc cur)
			(set! start-time now)
			(set! run-time run))))

(set-procedure-property! report-avg-gc-cpu-time 'documentation
"
  report-avg-gc-cpu-time - Report the average time spent in GC.

  Print statistics about how much time has been spent in garbage
  collection, and how much time spent in other computational tasks.
  Resets the stats after each call, so only the stats since the
  previous call are printed.
"
)

; --------------------------------------------------------------------
