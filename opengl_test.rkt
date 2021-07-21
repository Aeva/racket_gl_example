#lang racket/gui
(require ffi/unsafe
         ffi/unsafe/define)
(define-ffi-definer define-backend (ffi-lib "backend.dll"))

(define-backend gl_init (_fun -> _void))
(define-backend gl_draw (_fun -> _void))

(define frame (new frame% [label "Hail Eris"]))
(define gl-config (new gl-config%))
(send gl-config set-legacy? #f)
(send gl-config set-depth-size 0)

(define (present canvas ctx)
  (define gl-ctx (send ctx get-gl-context))
  (send gl-ctx call-as-current gl_draw)
  (send gl-ctx swap-buffers))
  
(define canvas
  (new canvas%
       [parent frame]
       [style (list 'gl 'no-autoclear)]
       [gl-config gl-config]
       [min-width 200]
       [min-height 200]
       [paint-callback present]))

(send frame show #t)
(let ([gl-ctx (send (send canvas get-dc) get-gl-context)])
  (send gl-ctx call-as-current gl_init))
