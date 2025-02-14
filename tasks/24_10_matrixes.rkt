(define (mat-at m i j)
  (if (= i 0)
      (if (= j 0)
          (car (car m))
          (mat-at (list (cdr (car m))) i (- j 1)))
      (mat-at (cdr m) (- i 1) j)))

(define (mat-map f m)
  (if (null? m) '()
      (cons (my-map f (car m)) (mat-map f (cdr m)))))

(define (equal-length? m rowlen)
  (if (null? m)
      #t
      (and (= (length (car m)) rowlen) (equal-length? (cdr m) rowlen))))
(define (all-number-i? row)
  (if (null? row)
      #t
      (and (number? (car row)) (all-number-i? (cdr row)))))
 (define (all-number? m)
   (if (null? m)
       #t
       (and (all-number-i? (car m)) (all-number? (cdr m)))))
(define (mat? m)
  (and (equal-length? m (length (car m))) (all-number? m)))

(define (scalmul x m)
  (define (scal y) (* x y))
  (mat-map scal m))

(define (get-first-on-each-row m)
  (if (null? m)
      '()
      (if (null? (car m))
          '()
          (cons (car (car m)) (get-first-on-each-row (cdr m))))))
(define (rem-first-el-from-each-row m)
  (if (null? m)
      '()
      (if (null? (car m))
          '()
          (cons (cdr (car m)) (rem-first-el-from-each-row (cdr m))))))
(define (transpose m)
  (if (null? m)
      '()
      (if (null? (car m))
          '()
          (cons (get-first-on-each-row m) (transpose (rem-first-el-from-each-row m))))))
  
(define (mul-row-col row col)
  (if (or (null? row) (null? col))
      0
      (+ (* (car row) (car col)) (mul-row-col (cdr row) (cdr col)))))
(define (mul-row-matrix row n)
  (if (null? n)
      '()
      (cons (mul-row-col row (get-first-on-each-row n))
            (mul-row-matrix row (rem-first-el-from-each-row n)))))
(define (rem-last-el-from-row row)
  (if (null? (cdr row))
      '()                
      (cons (car row)    
            (rem-last-el-from-row (cdr row)))))
(define (rem-last-el res)
  (if (null? res)
      '()
      (cons (rem-last-el-from-row (car res))
            (rem-last-el (cdr res)))))
(define (matmul-i m n)
  (if (or (null? m) (null? n))
      '()
      (cons (mul-row-matrix (car m) n)
            (matmul-i (cdr m) n))))
(define (matmul m n)
  (rem-last-el (matmul-i m n)))   
(define m '((1 2 3) (4 5 6)))
(define n '((7 8) (9 10) (11 12)))
(matmul m n)