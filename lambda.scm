(define (curry fn . args)
    (lambda rest (apply fn (append args rest))))

(define (pipe arg1 . curries)
    (let rec-loop ((result1 arg1)
                   (curry-list curries))
        (if (null? curry-list)
            result1
            (rec-loop ((car curry-list) result1) (cdr curry-list)))))
