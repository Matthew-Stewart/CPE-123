#lang racket

(require 2htdp/image)
(require 2htdp/universe)


;; make sure you run rainbows.rkt before running this program
(define start (bitmap/file "/tmp/rainbows.png"))
(define w (image-width start))
(define h (image-height start))

(define (todraw world) world)

; make M equal to the pixel size you want to move by

(define M 2)

;                                         x        y        w        h        image
(define (move-down world) (above  (freeze 0        (- h M)  w        M        world)
                                  (freeze 0        0        w        (- h M)  world)))

;                                         x        y        w        h        image
(define (move-left world) (beside (freeze M        0        (- w M)  h        world)
                                  (freeze 0        0        M        h        world)))


(define (ontick world)
  (move-down (move-left world)))


(big-bang start
          [to-draw todraw]
          [on-tick ontick])
