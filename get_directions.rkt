;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname get_directions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require "./requirements/hashtable-extras.rkt")

(define-struct node [label adjacent])

;; A Node is a (make-node String [Hash-Table-of String String])
;; (make-node label adjacent) represents a node with the given label,
;; along with a hash table that contains the labels of all adjacent nodes (that there exists an edge to)
;; and the labels of the edges that connect to the respective adjacent node

;; node-template : Node -> ?

(define (node-template n)
  (... (node-label n) ... (node-adjacent n) ...))

;; Nodes for the directed graph shown at the top of the assignment
(define EX-NODE-1 (make-node "A" (make-hash (list (list "C" "north") (list "B" "north-east")))))
(define EX-NODE-2 (make-node "B" (make-hash '())))
(define EX-NODE-3 (make-node "C" (make-hash (list (list "B" "east")))))

;; Nodes for an undirected graph shaped like an L with X at the center connecting up to Y and right to Z
(define EX-NODE-4 (make-node "X" (make-hash (list (list "Y" "up") (list "Z" "right")))))
(define EX-NODE-5 (make-node "Y" (make-hash (list (list "X" "down")))))
(define EX-NODE-6 (make-node "Z" (make-hash (list (list "X" "left")))))

;; Nodes for Graph of Northeastern Map

(define FORSYTH-WAY-AND-HUNTINGTON
  (make-node "Forsyth Way and Huntington"
             (make-hash (list (list "Forsyth St and Huntington" "east")
                              (list "Forsyth Way and Hemenway" "north")))))
(define FORSYTH-WAY-AND-HEMENWAY
  (make-node "Forsyth Way and Hemenway"
             (make-hash (list (list "Forsyth Way and Huntington" "south")
                              (list "Forsyth St and Hemenway" "northeast")))))
(define FORSYTH-ST-AND-HUNTINGTON
  (make-node "Forsyth St and Huntington"
             (make-hash (list (list "Forsyth Way and Huntington" "west")
                              (list "Forsyth St and Hemenway" "north")
                              (list "Opera and Huntington" "east")))))
(define FORSYTH-ST-AND-HEMENWAY
  (make-node "Forsyth St and Hemenway"
             (make-hash (list (list "Forsyth Way and Hemenway" "southwest")
                              (list "Forsyth St and Huntington" "south")
                              (list "Hemenway and Gainsborough" "northeast")))))
(define OPERA-AND-HUNTINGTON
  (make-node "Opera and Huntington"
             (make-hash (list (list "Forsyth St and Huntington" "west")
                              (list "Opera and St Stephen" "north")))))
(define OPERA-AND-ST-STEPHEN
  (make-node "Opera and St Stephen"
             (make-hash (list (list "Opera and Huntington" "south")
                              (list "St Stephen and Gainsborough" "east")))))
(define ST-STEPHEN-AND-GAINSBOROUGH
  (make-node "St Stephen and Gainsborough"
             (make-hash (list (list "Opera and St Stephen" "west")
                              (list "Hemenway and Gainsborough" "northwest")))))
(define HEMENWAY-AND-GAINSBOROUGH
  (make-node "Hemenway and Gainsborough"
             (make-hash (list (list "St Stephen and Gainsborough" "southeast")
                              (list "Forsyth St and Hemenway" "southwest")))))

;; Nodes for My Street Graph (Northeastern Streets just east of the provided graph)
;; https://docs.google.com/drawings/d/1uPq4HCwFWZ__Pslcbmc2_e5d7DVN6wnr0JNXo2o3mrA/edit?usp=sharing

(define ST-BOTOLPH-AND-GAINSBOROUGH
  (make-node "St Botolph and Gainsborough"
             (make-hash (list (list "Huntington and Gainsborough" "north")
                              (list "Mass Ave and St Botolph" "east")))))
(define HUNTINGTON-AND-GAINSBOROUGH
  (make-node "Huntington and Gainsborough"
             (make-hash (list (list "St Botolph and Gainsborough" "south")
                              (list "Huntington and Mass Ave" "east")))))
(define MASS-AVE-AND-ST-BOTOLPH
  (make-node "Mass Ave and St Botolph"
             (make-hash (list (list "St Botolph and Gainsborough" "west")
                              (list "Huntington and Mass Ave" "north")
                              (list "St Botolph and Cumberland" "east")))))
(define HUNTINGTON-AND-MASS-AVE
  (make-node "Huntington and Mass Ave"
             (make-hash (list (list "Huntington and Gainsborough" "west")
                              (list "Huntington and Cumberland" "east")
                              (list "Mass Ave and St Stephen" "north")
                              (list "Mass Ave and St Botolph" "south")))))
(define MASS-AVE-AND-ST-STEPHEN
  (make-node "Mass Ave and St Stephen" (make-hash (list (list "Huntington and Mass Ave" "south")))))
(define HUNTINGTON-AND-CUMBERLAND
  (make-node "Huntington and Cumberland"
             (make-hash (list (list "Huntington and Mass Ave" "west")
                              (list "St Botolph and Cumberland" "south")))))
(define ST-BOTOLPH-AND-CUMBERLAND
  (make-node "St Botolph and Cumberland"
             (make-hash (list (list "Mass Ave and St Botolph" "west")
                              (list "Huntington and Cumberland" "north")))))

;; An ELGraph is a [List-of Node]
;; Contains a list of nodes that each have their respective labels & adjacent nodes/edges
;; Can be a directed or undirected graph --> the nodes will dictate this.

;; elgraph-template : ELGraph -> ?

(define (elgraph-template graph)
  (cond
    [(empty? graph) ...]
    [(cons? graph) (... (node-template (first alist)) (elgraph-template (rest alist)) ...)]))

;; Directed graph shown at the top of the assignment
(define EX-ELGRAPH-1 (list EX-NODE-1 EX-NODE-2 EX-NODE-3))

;; Undirected graph specified above (see comment above node definitions)
(define EX-ELGRAPH-2 (list EX-NODE-4 EX-NODE-5 EX-NODE-6))

;; Graph of the Northeastern streets given in the example
(define given-street-graph
  (list FORSYTH-WAY-AND-HUNTINGTON
        FORSYTH-WAY-AND-HEMENWAY
        FORSYTH-ST-AND-HUNTINGTON
        FORSYTH-ST-AND-HEMENWAY
        OPERA-AND-HUNTINGTON
        OPERA-AND-ST-STEPHEN
        ST-STEPHEN-AND-GAINSBOROUGH
        HEMENWAY-AND-GAINSBOROUGH))

;; Graph of Northeastern Streets just east of the streets from the example
;; https://docs.google.com/drawings/d/1uPq4HCwFWZ__Pslcbmc2_e5d7DVN6wnr0JNXo2o3mrA/edit?usp=sharing

(define my-street-graph
  (list ST-BOTOLPH-AND-GAINSBOROUGH
        HUNTINGTON-AND-GAINSBOROUGH
        MASS-AVE-AND-ST-BOTOLPH
        HUNTINGTON-AND-MASS-AVE
        MASS-AVE-AND-ST-STEPHEN
        HUNTINGTON-AND-CUMBERLAND
        ST-BOTOLPH-AND-CUMBERLAND))

;; driving-directions : ELGraph String String --> [List-of String]
;; Takes in a graph of streets and two strings representing
;; the starting point intersection and ending point intersection
;; (which are really just node labels in our graph of streets)
;; Outputs a list of directions from the starting intersection to the ending intersection

(define (driving-directions graph start end)
  ;; traverse : Node [List-of String] [List-of String] [List-of String]
  ;; Takes in the parent node of the adjacent nodes we are examining,
  ;; a list of unchecked adjacent nodes of this parent node, and a list of visited node labels
  ;;
  ;; Traverses through the graph in the following manner:
  ;; If all adjacent nodes were exhausted, returns an empty list since there is no path
  ;; If the end is adjacent to the current node,
  ;; returns direction from current parent node to that adjacent ending node
  ;; If a node has already been visited, moves onto the next adjacent node (to the parent node)
  ;; Otherwise, checks if a path (without reusing any visited nodes) exists from the adjacent node to the end
  ;; If so, adds a direction from parent node to the output of the recursion
  ;; with that adjacent node's respective properties as new arguments (and adds node to visited list)

  (local
   [(define (traverse parentNode uncheckedAdjacentLabels visitedLabels)
      (cond
        [(empty? uncheckedAdjacentLabels) '()]
        [(ormap (lambda (s) (string=? s end)) (hash-keys (node-adjacent parentNode)))
         (create-direction parentNode end)]
        [(member? (first uncheckedAdjacentLabels) visitedLabels)
         (traverse parentNode (rest uncheckedAdjacentLabels) visitedLabels)]
        [else
         (if (exists-route? graph visitedLabels (first uncheckedAdjacentLabels) end)
             (append (create-direction parentNode (first uncheckedAdjacentLabels))
                     (traverse (label-to-node graph (first uncheckedAdjacentLabels))
                               (hash-keys (node-adjacent
                                           (label-to-node graph (first uncheckedAdjacentLabels))))
                               (cons (first uncheckedAdjacentLabels) visitedLabels)))
             (traverse parentNode
                       (rest uncheckedAdjacentLabels)
                       (cons (first uncheckedAdjacentLabels) visitedLabels)))]))]
   (if (or (string=? start end) (not (member? start (map node-label graph))))
       '()
       (traverse (label-to-node graph start)
                 (hash-keys (node-adjacent (label-to-node graph start)))
                 (list start)))))

(check-expect
 (driving-directions given-street-graph "Forsyth Way and Huntington" "St Stephen and Gainsborough")
 '("east to Forsyth St and Huntington" "east to Opera and Huntington"
                                       "north to Opera and St Stephen"
                                       "east to St Stephen and Gainsborough"))

(check-expect
 (driving-directions given-street-graph "St Stephen and Gainsborough" "Opera and St Stephen")
 (list "west to Opera and St Stephen"))

(check-expect
 (driving-directions given-street-graph "St Stephen and Gainsborough" "Forsyth Way and Hemenway")
 (list "northwest to Hemenway and Gainsborough"
       "southwest to Forsyth St and Hemenway"
       "southwest to Forsyth Way and Hemenway"))

(check-expect (driving-directions given-street-graph "St Stephen and Gainsborough" "nowhere") '())

(check-expect (driving-directions given-street-graph "Opera and Huntington" "Opera and Huntington")
              '())

(check-expect (driving-directions given-street-graph "Opera and Huntington" "Forsyth St and Hemenway")
              (list "west to Forsyth St and Huntington" "north to Forsyth St and Hemenway"))

(check-expect
 (driving-directions given-street-graph "St Stephen and Gainsborough" "Forsyth Way and Huntington")
 (list "northwest to Hemenway and Gainsborough"
       "southwest to Forsyth St and Hemenway"
       "south to Forsyth St and Huntington"
       "west to Forsyth Way and Huntington"))

(check-expect
 (driving-directions my-street-graph "St Botolph and Gainsborough" "Mass Ave and St Stephen")
 (list "north to Huntington and Gainsborough"
       "east to Huntington and Mass Ave"
       "north to Mass Ave and St Stephen"))

(check-expect
 (driving-directions my-street-graph "St Botolph and Cumberland" "Huntington and Mass Ave")
 (list "west to Mass Ave and St Botolph" "north to Huntington and Mass Ave"))

;; create-direction : Node String -> [List-of String]
;; Takes in a parent node and a string representing the adjacent node to which directions must be outputted
;; Returns a list containing a singular string with the edge label of that adjacent node + " to " + the adjacent node
;; This singular string is the direction to that adjacent node

(define (create-direction parentNode adjLabel)
  (list (string-append (hash-ref (node-adjacent parentNode) adjLabel) " to " adjLabel)))

(check-expect (create-direction FORSYTH-WAY-AND-HUNTINGTON "Forsyth Way and Hemenway")
              (list "north to Forsyth Way and Hemenway"))
(check-expect (create-direction FORSYTH-ST-AND-HUNTINGTON "Opera and Huntington")
              (list "east to Opera and Huntington"))
(check-expect (create-direction ST-STEPHEN-AND-GAINSBOROUGH "Hemenway and Gainsborough")
              (list "northwest to Hemenway and Gainsborough"))

;; label-to-node : ELGraph String -> Node
;; Consumes a graph and the label of the desired node. Returns the node in the graph with that label.
;; Assumes that exactly one node with that label exists.

(define (label-to-node graph label)
  (first (filter (lambda (n) (string=? label (node-label n))) graph)))

(check-expect (label-to-node EX-ELGRAPH-1 "A") EX-NODE-1)
(check-expect (label-to-node EX-ELGRAPH-2 "Y") EX-NODE-5)
(check-expect (label-to-node given-street-graph "St Stephen and Gainsborough")
              ST-STEPHEN-AND-GAINSBOROUGH)

;; exists-route? : ELGraph [List-of String] String String-> Boolean
;; Returns whether there exists a path in the graph between the labels
;; making sure nodes with offlimit labels can't be visited

(define (exists-route? g offlimits start end)

  ;; is-there-route? : Node [List-of Node] -> Boolean
  ;; Traverses through the graph and searches for a viable path
  ;; by checking every adjacent node and seeing if a viable path exists there
  ;; Digs recursively until the end is one of the current node's adjacent nodes
  ;; If this never happens or we revisit a node instead, returns false
  (local [(define (is-there-route? currentNode visited)
            (cond
              [(member? currentNode visited) #false]
              [(ormap (lambda (s) (string=? s end)) (hash-keys (node-adjacent currentNode))) #true]
              [else
               (ormap (lambda (s)
                        (and (not (member? s offlimits))
                             (is-there-route? (label-to-node g s) (cons currentNode visited))))
                      (hash-keys (node-adjacent currentNode)))]))]
         (if (string=? start end) #true (is-there-route? (label-to-node g start) '()))))

(check-expect
 (exists-route? given-street-graph '() "Forsyth Way and Huntington" "St Stephen and Gainsborough")
 #true)
(check-expect
 (exists-route? given-street-graph '() "St Stephen and Gainsborough" "Forsyth Way and Hemenway")
 #true)
(check-expect
 (exists-route? given-street-graph '() "St Stephen and Gainsborough" "St Stephen and Gainsborough")
 #true)
(check-expect (exists-route? EX-ELGRAPH-1 '() "B" "A") #false)
(check-expect (exists-route? EX-ELGRAPH-1 '() "C" "A") #false)
(check-expect (exists-route? EX-ELGRAPH-1 '() "A" "C") #true)
(check-expect (exists-route? my-street-graph
                             (list "Huntington and Mass Ave")
                             "Mass Ave and St Botolph"
                             "Mass Ave and St Stephen")
              #false)
(check-expect
 (exists-route?
  my-street-graph
  (list "Huntington and Cumberland" "Mass Ave and St Botolph" "St Botolph and Cumberland")
  "St Botolph and Gainsborough"
  "Mass Ave and St Stephen")
 #true)

;; fully-connected? : Graph -> Boolean
;; Returns whether there exists a path between all points in the graph

(define (fully-connected? g)
  (andmap (lambda (n1) (andmap (lambda (n2) (exists-route? g '() (node-label n1) (node-label n2))) g))
          g))

(check-expect (fully-connected? EX-ELGRAPH-1) #false)
(check-expect (fully-connected? EX-ELGRAPH-2) #true)
(check-expect (fully-connected? given-street-graph) #true)
(check-expect (fully-connected? my-street-graph) #true)
