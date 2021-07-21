#lang racket/gui

(require ffi/unsafe
         ffi/unsafe/define)

; Functions provided by the backend dll.
(define-ffi-definer define-backend (ffi-lib "backend.dll"))
(define-backend gl_init (_fun -> _void))
(define-backend gl_draw (_fun -> _void))
(define-backend gl_halt (_fun -> _void))

; Access the GL canvas's gl context.
(define (get-gl-context)
  (send (send canvas get-dc) get-gl-context))

; The main window.
(define frame
  (new
   (class frame% (super-new)
     (define/augment (on-close)
       (send (get-gl-context) call-as-current gl_halt)))
   [label "Racket With External OpenGL Example"]))

; The OpenGL context will be created the core profile and no depth buffer.
(define gl-config (new gl-config%))
(send gl-config set-legacy? #f)
(send gl-config set-depth-size 0)

; Callback to render the next frame.
(define (render-frame canvas ctx)
  (define gl-ctx (send ctx get-gl-context))
  (send gl-ctx call-as-current gl_draw)
  (send gl-ctx swap-buffers))

; Create the OpenGL canvas widget.
(define canvas
  (new canvas%
       [parent frame]
       [style (list 'gl 'no-autoclear)]
       [gl-config gl-config]
       [min-width 200]
       [min-height 200]
       [paint-callback render-frame]))

; Show the main window.
(send frame show #t)

; Initialize OpenGL.
(send (get-gl-context) call-as-current gl_init)
