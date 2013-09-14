(ns even-fib.core
  (:gen-class))

(defn fib2[n]
  (take n (map first (iterate (fn [[a b]] [b (+ a b)]) [0 1]))))

(defn -main[limit]
  (let [n (Integer/parseInt limit)
        fibs (fib2 n)]
    (println "n = " n)
    (println "fibs = " fibs)
    (println (reduce + 0 fibs))))
