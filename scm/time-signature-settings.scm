;;;; This file is part of LilyPond, the GNU music typesetter.
;;;;
;;;; Copyright (C) 2009--2010 Carl Sorensen <c_sorensen@byu.edu>
;;;;
;;;; LilyPond is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation, either version 3 of the License, or
;;;; (at your option) any later version.
;;;;
;;;; LilyPond is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with LilyPond.  If not, see <http://www.gnu.org/licenses/>.

;;; specify time signature default settings

;;; format:
;;;
;;; alist of
;;;   (time-signature . default-properties) entries.
;;;
;;; where default-properties is an alist containing information about the
;;; time signature.  Each default-properties set can contain the
;;; following entries:
;;;
;;;   (baseMoment . (numerator . denominator))
;;;   (beatStructure . structure-list)
;;;   (beamExceptions . (alist of beam exceptions that don't follow beats))
;;;
;;; The alist of beam exceptions has the following entries:
;;;
;;;   (end . grouping-rules)
;;;   (subdivide . grouping-rules)  (not yet implemented, reserved for future use)
;;;
;;;   grouping-rules is an alist containing (beam-type . grouping-list) entries
;;;
;;;     beam-type is (numerator . denominator)
;;;     grouping-list is a list that specifies the
;;;     number of stems of the given duration that are grouped in a beamed unit.
;;;     For an exception, the duration used is beam-type.  For measureBeats,
;;;     the duration used is baseMoment.
;;;
;;;     If an exception is specified for a given beam-type, it will apply to all
;;;     beams of shorter durations that don't have an individual exception, so
;;;     ((1 . 8) . (3 3 2))
;;;     will cause all primary beams to be broken at 3/8, 5/8, and 8/8.
;;;
;;;     ((1. 32) . (16 8 4 4))
;;;     will cause all 1/32, 1/64, and 1/128 beams to be broken at 1/2, 3/4,
;;;     7/8, and 8/8.
;;;
;;; If no values are given for baseMoment and measureBeats, default values
;;;   will be assigned:
;;;   baseMoment gets the value (ly:make-moment 1  time-signature-denominator)
;;;   beatStructure gets a list of (3 3 3 ...), where the number of entries is the
;;;     number of beats, each containing 3 base-moments, if the time
;;;     signature numerator is greater than 3 and divisible by 3, and
;;;     a list of (1 1 1 ...), where the number of entries is the
;;;     number of base moments in a measure otherwise.
;;;
;;; If no value is given for beatCombinations, no beats will be combined without
;;;   beamExceptions rules.
;;;
;;;       NOTE: numerator is kept in beam-type because of
;;;             tuplets, e.g. (2 . 24) = (2 . 3) * (1 . 8)
;;;             for eighth-note triplets.

(define-public default-time-signature-settings
  '(
    ;; in 2/2 time:
    ;;   use defaults, but end beams with 32nd notes each 1 4 beat
    ((2 . 2) .
             ((beamExceptions . ((end . (((1 . 32) . (8 8 8 8))))))))

    ;; in 2/4, 2/8 and 2/16 time:
    ;;   use defaults, so no entries are necessary

    ;; in 3 2 time:
    ;;   use defaults, but end beams with 32nd notes and higher each 1 4 beat

    ((3 . 2) .
             ((beamExceptions . ((end .  (((1 . 32) . (8 8 8 8 8 8))))))))

    ;; in 3 4 time:
    ;;   use defaults, but combine all beats into a unit if possible
    ;;
    ;;   set all beams to end on beats, but 1 8 to beam entire measure
    ;;   in order to avoid beaming every beat for entier measure, we set
    ;;   triplets back to every beat.
    ((3 . 4) .
             ((beamExceptions . ((end . (((1 . 8) . (6))
                                         ((1 . 12) . (3 3 3))))))))

    ;; in 3 8  time:
    ;;   beam entire measure together
    ((3 . 8) . ((beamExceptions . ((end . (((1 . 8) . (3))))))))

    ;; in 3 16 time:
    ;;   use defaults -- no entries necessary

    ;; in 4 2 time:
    ;;   use defaults, but end beams with 16th notes or finer each 1 4 beat
    ((4 . 2) .
             ((beamExceptions . ((end . (((1 . 16) . (4 4 4 4 4 4 4 4))))))))

    ;; in 4 4 (common) time:
    ;;   use defaults, but combine beats 1,2 and 3,4 if only 8th notes
    ;;   NOTE: Any changes here need to be duplicated in
    ;;         ly/engraver-init.ly where the default time signature is set
    ;;         are set
    ((4 . 4) .
             ((beamExceptions . ((end . (((1 . 8) . (4 4))
                                         ((1 . 12) . (3 3 3 3))))))))

    ;; in 4/8 time:
    ;;   combine beats 1 and 2, so beam in 2
    ((4 . 8) . ((beatStructure . (2 2))))

    ;; in 4/8 and 4/16 time:
    ;;   use defaults, so no entries necessary

    ;; in 6 4 time:
    ;;   use defaults, but end beams with 32nd or finer each 1/4 beat
    ((6 . 4) .
             ((beamExceptions . ((end .  (((1 . 16) . (4 4 4 4 4 4))))))))

    ;; in 6 8 time:
    ;;   use defaults, but end beams with 32nd or finer each 1 8 beat
    ((6 . 8) .
             ((beamExceptions . ((end .  (((1 . 32) . (4 4 4 4 4 4))))))))

    ;; in 6 16 time:
    ;;   use defaults, so no entry necessary

    ;; in 9 4 time:
    ;;   use defaults, but end beams with 32nd or finer each 1 4 beat
    ((9 . 4) .
             ((beamExceptions . ((end . (((1 . 32) . (8 8 8 8 8 8 8 8))))))))

    ;; in 9 8 time
    ;;   use defaults, but end beams with 32nd notes each 1 8 beat
    ((9 . 8) .
             ((beamExceptions . ((end . (((1 . 32) . (4 4 4 4 4 4 4 4 4))))))))

    ;; in 9 16 time
    ;;   use defaults, so no entry necessary

    ;; in 12 4 time:
    ;;   use defaults, but end beams with 32nd or finer notes each 1 4 beat
    ((12 . 4) .
              ((beamExceptions . ((end . (((1 . 32) . (8 8 8 8 8 8 8 8 8 8 8 8))))))))

    ;; in 12 8 time:
    ;;   use defaults, but end beams with 32nd notes each 1 8 beat
    ((12 . 8) .
              ((beamExceptions . ((end . (((1 . 32) . (4 4 4 4 4 4 4 4 4 4 4 4))))))))

    ;; in 12 16 time:
    ;;   use defaults; no entry needed

    ;; in 5 8 time:
    ;;   default: group (3 2)
    ((5 . 8) .
             ((baseMoment . (1 . 8))
              (beatStructure . (3 2))))

    ;; in 8 8 time:
    ;;   default: group (3 3 2)
    ((8 . 8) .
             ((baseMoment . (1 . 8))
              (beatStructure . (3 3 2))))

    ))  ; end of alist definition

;;;
;;;  Accessor and constructor functions
;;;

(define (get-setting my-symbol time-signature time-signature-settings)
  "Get setting @code{my-symbol} for @code{time-signature} from
@code{time-signature-settings}."
  (let ((my-time-signature-settings
          (assoc-get time-signature time-signature-settings '())))
   (assoc-get my-symbol my-time-signature-settings '())))

(define-public (make-setting base-fraction
                             beat-structure
                             beam-exceptions)
  (list
    (cons 'baseMoment base-fraction)
    (cons 'beatStructure beat-structure)
    (cons 'beamExceptions beam-exceptions)))

(define-public (base-fraction time-signature time-signature-settings)
  "Get @code{baseMoment} fraction value for @code{time-signature} from
@code{time-signature-settings}."
   (let ((return-value (get-setting 'baseMoment
                                    time-signature
                                    time-signature-settings)))
     (if (null? return-value)
         (cons 1 (cdr time-signature))
         return-value)))

(define-public (beat-structure base-fraction time-signature time-signature-settings)
  "Get beatStructure value in @code{base-fraction} units
for @code{time-signature} from
@code{time-signature-settings}."
  (define (fraction-divide numerator denominator)
    (/ (* (car numerator) (cdr denominator))
       (* (cdr numerator) (car denominator))))

  (let ((return-value (get-setting 'beatStructure
                                   time-signature
                                   time-signature-settings)))
    (if (null? return-value)
        ;; calculate default beatStructure
        (let* ((numerator (car time-signature))
               (group-size (if (and (> numerator 3)
                                    (zero? (remainder numerator 3)))
                               3
                               1))
               (beat-length (cons (* group-size (car base-fraction))
                                  (cdr base-fraction)))
               (beat-count (fraction-divide time-signature beat-length)))
          (if (integer? beat-count)
              (make-list beat-count group-size)
              '()))
        ;; use value obtained from time-signature-settings
        return-value)))

(define-public (beam-exceptions time-signature time-signature-settings)
  "Get beamExceptions value for @code{time-signature} from
@code{time-signature-settings}."
   (get-setting 'beamExceptions time-signature time-signature-settings))


;;; Functions for overriding time-signature settings
;;;

(define (override-property-setting context property setting value)
  "Like the C++ code that executes \\override, but without type
checking. "
  (begin
     (revert-property-setting context property setting)
     (ly:context-set-property!
       context
       property
       (cons (cons setting value) (ly:context-property context property)))))

(define (revert-property-setting context property setting)
  "Like the C++ code that executes \revert, but without type
checking. "

  (define (revert-member alist entry new)
    "Return ALIST, with ENTRY removed.  ALIST is not modified, instead
a fresh copy of the list-head is made."
    (cond
      ((null? alist) new)
      ((equal? (car alist) entry) (revert-member (cdr alist) entry new))
      (else (revert-member (cdr alist) entry (cons (car alist) new)))))

  (ly:context-set-property!
    context property
    (revert-member (ly:context-property context property) setting '())))

(define-public (override-time-signature-setting time-signature setting . rest)
  "Override the time signature settings for the context in @var{rest},
with the new setting alist @var{setting}. "
    (context-spec-music
      (make-apply-context
        (lambda (c) (override-property-setting
                      c
                      'timeSignatureSettings
                      time-signature
                      setting)))
      (if (and (pair? rest) (symbol? (car rest)))
          (car rest)
          'Voice)))

(define-public (score-override-time-signature-setting
                 time-signature setting)
  (override-time-signature-setting
    time-signature setting 'Score))

(define-public (revert-time-signature-setting
                  time-signature . rest)
  (context-spec-music
    (make-apply-context
      (lambda (c)
        (revert-property-setting
          c
          'timeSignatureSettings
          time-signature)))
    (if (and (pair? rest) (symbol? (car rest)))
        (car rest)
        'Voice)))
