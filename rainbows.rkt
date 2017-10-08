#lang slideshow

;; this file generates a png image with
;; a specified height, width, and pixel size.
;; change the colors to make a different colored image

(require racket/draw)

(define clist (list "red" "orange" "yellow" "green" "blue" "purple"))
;(define clist (send the-color-database get-names))

; the more colors you use, the smaller width and height should be
(define width 20)
(define height 20)
(define pixel-size 3)

(define clen (length clist))

(define (square n)
  (filled-rectangle n n))


;; colorizes a square p with lst (has already been split into chunks of 6)
(define (rainbow p lst)
  (map (lambda (color)
         (colorize p color))
       lst))


;; splits a list into chunks of size n
(define (split-n n xs)
  (if (null? xs)
      '()
      (let ((first-chunk (take xs n))
            (rest (drop xs n)))
        (cons first-chunk (split-n n rest)))))


;; calls rainbow for each square with color l in lst
(define (beauty lst)
  (define (iter count)
    (cond [(<= count 0)
           (apply hc-append
                  (map (lambda (l)
                         (apply vc-append (rainbow (square pixel-size) l)))
                       lst))]
          [else
           (vc-append
            (apply hc-append
                   (map (lambda (l)
                          (apply vc-append (rainbow (square pixel-size) l)))
                        lst))
            (iter (sub1 count)))]))
  (iter (sub1 height)))


;; recusively adds a list to lst that takes the old list and puts the last object in front
(define (my-length)

  (define (iter lst cvc)
    (cond
      ;;true
      [(> cvc  (+ (* clen (sub1 width)) (sub1 clen)))
       (beauty (split-n clen lst))]
      ;;recurses
      [else
       (iter (flatten (list (rest (take lst clen))
                            (first lst)
                            lst))
             (add1 cvc))]))

  ;starts the recursive call
  (iter (reverse clist) 1))


(define image (my-length))
image


(send (pict->bitmap image)
      save-file "/tmp/rainbows.png" 'png)
