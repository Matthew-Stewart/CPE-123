#lang slideshow

;; this file generates a png image with
;; a specified height, width, and pixel size.
;; change the colors to make a different colored image

(require racket/draw)

(define clist (list "red" "orange" "yellow" "green" "blue" "purple"))
;(define clist (send the-color-database get-names))

; global vars
(define width 20)
(define height 20)
(define size 3)

(define (square n)
  (filled-rectangle n n))


;; colorizes a square p with lst (has already been split into chunks of 6)
(define (rainbow p lst)
  (map (lambda (color)
         (colorize p color))
       lst))



;; splits a list into chunks of 6
(define (split-6 n xs)
  (if (null? xs)
      '()
      (let ((first-chunk (take xs n))
            (rest (drop xs n)))
        (cons first-chunk (split-6 n rest)))))


;; calls rainbow for each square with color l in lst
(define (beauty lst) 
  (define (iter cnt)
    (cond [(= 0 cnt)
           (apply hc-append 
                  (map (lambda (l) 
                         (apply vc-append (rainbow (square size) l)))
                       lst)
                  )]
          [else 
           (vc-append 
            (apply hc-append 
                   (map (lambda (l) 
                          (apply vc-append (rainbow (square size) l)))
                        lst)
                   ) (iter (- cnt 1)))]))
  (iter height))

(displayln (length clist))


;; recusively adds a list to lst that takes the old list and puts the last object in front
(define (my-length)
  
  (define (iter lst cvc)
    (cond
      ;;true
      [(> cvc  (+ (* (length clist) width) 4)) (beauty (split-6 6 lst))]
      ;;recurses
      [else (iter (flatten (list (flatten (list (rest (take lst 6)) (first lst))) lst)) (+ cvc 1))]))
  
  ;starts the recursive call
  (iter clist 0))

(my-length)



(send (pict->bitmap (my-length))
      save-file "/tmp/rainbows.png" 'png)


