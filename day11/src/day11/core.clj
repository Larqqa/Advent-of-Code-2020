(ns day11.core
  (:gen-class))

(defn checkAdjacent [vec, width, height]
  ;; vec[x + width * y]
  (map-indexed (fn [i v]
    (let [emptySeat (atom 0)
          occupiedSeat (atom 0)
          floor (atom 0)]

      (def x (rem i width))
      (def y (int (/ i width)))

      ; (print [x y])

      (if (and (>= (- y 1) 0) (>= (- x 1) 0) )
        (if (= (vec (+ (* width (- y 1)) (- x 1))) "L" )
          (swap! emptySeat #(+ %1 1))
            (if (= (vec (+ (* width (- y 1)) (- x 1))) "#")
              (swap! occupiedSeat #(+ %1 1))
              (swap! floor #(+ %1 1)))) false)

      (if (>= (- y 1) 0)
        (if (= (vec (+ (* width (- y 1)) x)) "L" )
          (swap! emptySeat #(+ %1 1))
            (if (= (vec  (+ (* width (- y 1)) x)) "#")
              (swap! occupiedSeat #(+ %1 1))
              (swap! floor #(+ %1 1)))) false)

      (if (and (>= (- y 1) 0) (< (+ x 1) width) )
        (if (= (vec (+ (* width (- y 1)) (+ x 1))) "L" )
          (swap! emptySeat #(+ %1 1))
            (if (= (vec (+ (* width (- y 1)) (+ x 1))) "#")
              (swap! occupiedSeat #(+ %1 1))
              (swap! floor #(+ %1 1)))) false)

      (if (>= (- x 1) 0)
        (if (= (vec (+ (* width y) (- x 1))) "L" )
          (swap! emptySeat #(+ %1 1))
            (if (= (vec (+ (* width y) (- x 1))) "#")
              (swap! occupiedSeat #(+ %1 1))
              (swap! floor #(+ %1 1)))) false)

      (if (< (+ x 1) width)
        (if (= (vec (+ (* width y) (+ x 1))) "L" )
          (swap! emptySeat #(+ %1 1))
            (if (= (vec (+ (* width y) (+ x 1))) "#")
              (swap! occupiedSeat #(+ %1 1))
              (swap! floor #(+ %1 1)))) false)

      (if (and (< (+ y 1) height) (>= (- x 1) 0) )
        (if (= (vec (+ (* width (+ y 1)) (- x 1))) "L" )
          (swap! emptySeat #(+ %1 1))
            (if (= (vec (+ (* width (+ y 1)) (- x 1))) "#")
              (swap! occupiedSeat #(+ %1 1))
              (swap! floor #(+ %1 1)))) false)

      (if (< (+ y 1) height)
        (if (= (vec  (+ (* width (+ y 1)) x)) "L" )
          (swap! emptySeat #(+ %1 1))
            (if (= (vec (+ (* width (+ y 1)) x)) "#")
              (swap! occupiedSeat #(+ %1 1))
              (swap! floor #(+ %1 1)))) false)

      (if (and (< (+ y 1) height) (< (+ x 1) width) )
        (if (= (vec (+ (* width (+ y 1)) (+ x 1))) "L" )
          (swap! emptySeat #(+ %1 1))
            (if (= (vec (+ (* width (+ y 1)) (+ x 1))) "#")
              (swap! occupiedSeat #(+ %1 1))
              (swap! floor #(+ %1 1)))) false)

      ; (print [v @emptySeat @occupiedSeat])

      (if (= v ".") "."
        (if (and (= @occupiedSeat 0) (= v "L")) "#"
          (if (and (> @occupiedSeat 3) (= v "#")) "L" v)))

    )) vec))

(defn countFreqs [strList width height]
      ((def yeet (vec (checkAdjacent strList width height)))
      (def freqs (frequencies yeet))
      (println freqs)
      (countFreqs yeet width height)))


(defn checkDirectional [vec, width, height]
  ;; vec[x + width * y]
  (map-indexed (fn [i v]
    (let [emptySeat (atom 0)
          occupiedSeat (atom 0)
          floor (atom 0)]

      (def x (rem i width))
      (def y (int (/ i width)))

      ; (print [x y])

      (loop [i 1]
        (if (and (and (>= (- y i) 0) (>= (- x i) 0)) (not= (vec (+ (* width y) x)) "."))
        (do
          (def theChar (vec (+ (* width (- y i)) (- x i))))
          ; (print [y x theChar (- y i) (- x i)])

          (if (= theChar "L" )
            (swap! emptySeat #(+ %1 1))
            (if (= theChar "#")
              (swap! occupiedSeat #(+ %1 1))
              (recur (inc i)))))))

      (loop [i 1]
        (if (and (>= (- y i) 0) (not= (vec (+ (* width y) x)) "."))
        (do
          (def theChar (vec (+ (* width (- y i)) x)))
          ; (print [y x theChar (- y i) x])

          (if (= theChar "L" )
            (swap! emptySeat #(+ %1 1))
            (if (= theChar "#")
              (swap! occupiedSeat #(+ %1 1))
              (recur (inc i)))))))


      (loop [i 1]
        (if (and (and (>= (- y i) 0) (< (+ x i) width)) (not= (vec (+ (* width y) x)) "."))
        (do
          (def theChar (vec (+ (* width (- y i)) (+ x i))))
          ; (print [y x theChar (- y i) (+ x i)])

          (if (= theChar "L" )
            (swap! emptySeat #(+ %1 1))
            (if (= theChar "#")
              (swap! occupiedSeat #(+ %1 1))
              (recur (inc i)))))))


      (loop [i 1]
        (if (and (>= (- x i) 0) (not= (vec (+ (* width y) x)) "."))
        (do
          (def theChar (vec (+ (* width y) (- x i))))
          ; (print [y x theChar y (- x i)])

          (if (= theChar "L" )
            (swap! emptySeat #(+ %1 1))
            (if (= theChar "#")
              (swap! occupiedSeat #(+ %1 1))
              (recur (inc i)))))))

      (loop [i 1]
        (if (and (< (+ x i) width) (not= (vec (+ (* width y) x)) "."))
        (do
          (def theChar (vec (+ (* width y) (+ x i))))
          ; (print [y x theChar y (+ x i)])

          (if (= theChar "L" )
            (swap! emptySeat #(+ %1 1))
            (if (= theChar "#")
              (swap! occupiedSeat #(+ %1 1))
              (recur (inc i)))))))

      (loop [i 1]
        (if (and (and (< (+ y i) height) (>= (- x i) 0)) (not= (vec (+ (* width y) x)) "."))
        (do
          (def theChar (vec (+ (* width (+ y i)) (- x i))))
          ; (print [y x theChar (+ y i) (- x i)])

          (if (= theChar "L" )
            (swap! emptySeat #(+ %1 1))
            (if (= theChar "#")
              (swap! occupiedSeat #(+ %1 1))
              (recur (inc i)))))))

      (loop [i 1]
        (if (and (< (+ y i) height) (not= (vec (+ (* width y) x)) "."))
        (do
          (def theChar (vec (+ (* width (+ y i)) x)))
          ; (print [y x theChar (+ y i) x])

          (if (= theChar "L" )
            (swap! emptySeat #(+ %1 1))
            (if (= theChar "#")
              (swap! occupiedSeat #(+ %1 1))
              (recur (inc i)))))))


      (loop [i 1]
        (if (and (and (< (+ y i) height) (< (+ x i) width)) (not= (vec (+ (* width y) x)) "."))
        (do
          (def theChar (vec (+ (* width (+ y i)) (+ x i))))
          ; (print [y x theChar (+ y i) (+ x i)])

          (if (= theChar "L" )
            (swap! emptySeat #(+ %1 1))
            (if (= theChar "#")
              (swap! occupiedSeat #(+ %1 1))
              (recur (inc i)))))))

      ; (print [v @emptySeat @occupiedSeat])

      (if (= v ".") "."
        (if (and (= @occupiedSeat 0) (= v "L")) "#"
          (if (and (> @occupiedSeat 4) (= v "#")) "L" v)))

    )) vec))

(defn countFreqs2 [strList width height]
  ((def yeet (vec (checkDirectional strList width height)))
  (def freqs (frequencies yeet))
  (println freqs)
  (countFreqs2 yeet width height)))

(defn -main [& args]
  (def input (slurp (clojure.java.io/resource "input")))

  (def lines (clojure.string/split input #"\n"))

  (def width (.length (lines 1)))
  (def height (.length lines))

  (def strList
      (clojure.string/split (clojure.string/replace input #"\n" "") #""))

  ; (println (countFreqs strList width height))
  (println (countFreqs2 strList width height))

  )