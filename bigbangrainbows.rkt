#lang racket

(require 2htdp/image)
(require 2htdp/universe)

(define start (list (bitmap/file "/tmp/rainbows.png") 0))

(define (todraw w) (first w))

; make MOVEMENT equal to the pixel size you want to move by

(define MOVEMENT 3)

;                                     x         y                              w                             h
(define (move-down w) (above  (freeze 0         (- (image-height w) MOVEMENT)  (image-width w)               MOVEMENT                      w) 
                              (freeze 0         0                              (image-width w)               (- (image-height w) MOVEMENT) w)))

;                                     x         y                              w                             h
(define (move-left w) (beside (freeze MOVEMENT  0                              (- (image-width w) MOVEMENT)  (image-height w)              w) 
                              (freeze 0         0                              MOVEMENT                      (image-height w)              w))) 


(define (ontick w)
  (list (move-down (move-left (first w))) 0))


(big-bang start 
          [to-draw todraw]
          [on-tick ontick])
