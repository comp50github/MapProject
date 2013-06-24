#lang racket
;;------------------ Map Project: Part A --------------------------

;; Problem 1:
;; A deluge of musicians and philosophers mistakenly show up at
;; Halligan Hall for a conference on harmonically tonal metaphysics
;; and are cluttering the halls and inundating the labs. They must
;; be moved but Green Cab as replaced all its cabs with camel
;; caravans to cut carbon emissions. Use the design recepie to write
;; a fucntion to calculate how many camels must be called to
;; Halligan given some number of musicians and some number of
;; philosophers. Remember that each musician needs 7 camels 
;; (for all their instruments) while each philosopher needs 
;; only 2 camels. 

;; Ideal student answer:

;; Contract: length-of-caravan : number number -> number

;; Purpose: to compute the total number of camels needed to carry
;; away some number of musicians and some number of philosophers

;; Example: (length-of-caravan 5 9) should produce 53

;;Definiton :
(define (length-of-caravan musicians philosophers)
   (+ (* 2 philosophers)
      (* 7 musicians)))

;; A more advanced student answer handles negative input:
(define (better-length-of-caravan musicians philosophers)
  (cond
    [(< musicians 0) 'Cannot_have_a_negative_number_of_musicians]
    [(< philosophers 0) 'Cannot_have_a_negative_number_of_philosophers]
    [else (+ (* 2 philosophers)
             (* 7 musicians))])
  )

;;Tests: 
(length-of-caravan 1 2)
;;expected value
11

(better-length-of-caravan 1 -5)
;; expected value
'Cannot_have_a_negative_number_of_philosophers

;;Problem 2:
;;Camels are curious creatures, and they like to travel in packs of 19.
;;And Green cab wont send any camels unless there are at least
;; enough people for 1 full caravan. Partially full caravans a fine as 
;; long as the total number called for is greater than one. If more than
;; 10 caravans are needed, the Gobi Caravan Company will have to be 
;; called because Green cab doesn't have that many camels. Use the design
;;recepie and your caravan length function to write a function that 
;; returns how many caravans should be called, or if Gobi Caravan should
;; be called, or if some Comp 50 students are needed to join the caravan
;; because it is too small. 

;; Ideal student answer: 

;; Contract: how-many-caravans : number number -> number

;; Purpose: to compute how many caravans of 19 camels should be called
;; for any given party of musicians and philosophers

;; Example: (how-many-caravans 10 10) should produce 5

;;Definition:
(define (how-many-caravans musicians philosophers)
  (cond
    [(< (better-length-of-caravan musicians philosophers) 19) 
         'Some_Comp50_students_are_needed_for_the_adventure!]
    [(> (better-length-of-caravan musicians philosophers) 190)
        'We_need_more_camels!_Call_the_Gobi_Caravan_Company]
    [else (/ (better-length-of-caravan musicians philosophers) 19)]))

;; A better student answer returns a whole number for caravans needed:
(define (better-how-many-caravans musicians philosophers)
  (cond 
     [(< (better-length-of-caravan musicians philosophers) 19) 
         'Some_Comp50_students_are_needed_for_the_adventure!]
    [(> (better-length-of-caravan musicians philosophers) 190)
        'We_need_more_camels!_Call_the_Gobi_Caravan_Company]
    [(= 0 (- (/ (better-length-of-caravan musicians philosophers) 19)
             (quotient (better-length-of-caravan musicians philosophers)
                       19)
             ))
     (/ (better-length-of-caravan musicians philosophers) 19)]
    [(< 0 (- (/ (better-length-of-caravan musicians philosophers) 19)
             (quotient (better-length-of-caravan musicians philosophers)
                       19)
             ))
     (+ 1 (quotient (better-length-of-caravan musicians philosophers) 
                    19))]))
             

;; Tests 
(how-many-caravans 1 1)
;;expected value
'Some_Comp50_students_are_needed_for_the_adventure!

(how-many-caravans 10 10)
;; expected value
4 14/19

(better-how-many-caravans 10 10)
;; expected value
5

(how-many-caravans 100 10)
;; expected value
'We_need_more_camels!_Call_the_Gobi_Caravan_Company

;; Problem 3
;; Suddenly a fell wind gusts down from the north a wraps Tufts in
;; a raging blizzard. Luckily, all Medford Bactrians are descendants
;; of nomadic Mongolian snow camels and don't mind the cold. But the
;; musicians and philosophers do. In fact each has a certain temperature
;; at which she/he will not turn to ice. Each also has a certain
;; number of hours he/she can wait inside for warmer weather before 
;; being late to her/his next destination. A student is sent to write 
;; all this down but it gets too complicated. By now 32 feet of snow have
;; fallen and the camels will need snowshoes. Fortunetly some conference
;; members brought Bactrian-snowshoes with them, but some did not. Use
;; the design recepie to create a structure for each traveler that holds
;; five pieces of data: musician/philosopher, hours delay, 
;; freezing point, True/False (snowshoes), # camels needed. Then write a 
;; function to decrease the # camels needed for a traveler by 1 if the 
;; traveler is carrying showshoes as these will be worn rather than
;; carried. 

;; Ideal student answer:

;;Data Analysis Definitions: 
(define-struct traveler (m/p hrs freeze shoes camels))
;; A traveler is a structure: (make-traveler m h f s c) where 
;; m is a symbol, h and f are numbers, s is a boolean, and c is a number.

;; Contract: update-luggage : traveler -> traveler

;; Purpose: to create a traveler structure with a new number of camels 
;; needed if the traveler has snowshoes. 

;;Examples:
;; (update-luggage (make-traveler musician 5 30 #t 7))
;; = 
;; (make-traveler musician 5 30 #f 6)
;; (update-luggage (make-traveler philosopher 19 9 #f 2))
;; = 
;; (make-traveler philosopher 19 9 #f 2))

;; Template:
;; process-traveler : traveler -> ???
;; (define (process-traveler a-traveler)
;; ... (traveler-m/p a-traveler) ...
;; ... (traveler-hrs a-traveler) ...
;; ... (traveler-freeze a-traveler) ...
;; ... (traveler-shoes  a-traveler) ...
;; ... (traveler-camels a-traveler) ...)

;; Definition:
(define (update-luggage a-traveler)
  (cond
    [(and #t (traveler-shoes a-traveler))
     (make-traveler (traveler-m/p a-traveler) 
                    (traveler-hrs a-traveler)
                    (traveler-freeze a-traveler)
                    #f
                    (- (traveler-camels a-traveler) 1))]
    [else a-traveler]))

;; Tests
(update-luggage (make-traveler 'philosopher 6 20 #t 2))
;; expected value
(make-traveler 'philosopher 6 20 #f 1)

(update-luggage (make-traveler 'musician 1 25 #f 7))
;; expected value
(make-traveler 'musician 1 25 #f 7)

;;------------------------Part B --------------------------------
 
;; foldr over list of structures to determine, for a given group of 
;; musicians and philosophers - whats the highest freezing point of the
;; group, the shortest wait time, the updated total number of camels etc.

;; other functional functions and exercises

;;-----------------------Part C------------------------------------

;; write a teach pack for a geographic map of tufts and have students do
;; a treausre hunt over it / write functions that visually send caravans
;; to different places...



;;lowest_temperature #camels_needed #have_snowshoes? #longest_delay_hrs

