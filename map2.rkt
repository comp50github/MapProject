#lang racket
; Purpose: given GPS coordinates of location and
; destination, calculate distance to destination.
(define (distance x1 y1 x2 y2)
  (sqrt (+ (* (- x2 x1) (- x2 x1)) 
           (* (- y2 y1) (- y2 y1)))))

; Contract: perimeter: num list -> num
; Purpose: given a list of GPS coordinates 
; calculate the perimeter of the polygon (use
; distance formula above)

; Contract: area : num list -> num
; Purpose: calculate rectangular area of 4 points

; Contract: areaPolygon : num list -> num
; Purpose:
; Given list of GPS coordinates, calculate the
; individual triangles of the polygon and sum 
; areas to return total area of shape.
; Could be used to calculate area of Tufts campus

; Contract: sinDistance: num num -> num
; Purpose
; Takes an angle and a hypotenuse and calculates
; length of opposite side of right triangle. 
; Ex: you and your friend start at Halligan and 
; walk in different directions (30 degrees apart)
; after a mile (you are the hypotenuse) how
; far away are you from your friend? 

; Contract: findLocationY: num num -> num
; Purpose
; Takes in a longitude (y position)and an error
;(how far off the longitude is from the actual
; longitude of the hidden box w/ sign in sheet).
; Passes the longitude to teachpack function 
; which returns a new error. Recursively calls
; itself with updated longitude till error = 0. 

; Contract: findLocationX: num num -> num
; Same as findLocationY except for latitude. 

;Future plans:
;Implement teachpack map GUI so student functions
; can animate icons moving over maps.

                          