(ns euler.core
  (:gen-class))

(defn p2-fib[]
  (map first (iterate (fn [[a b]] [b (+' a b)]) [0 1])))

(defn p2-main[limit]
  (let [n (Integer/parseInt limit)
        fibs (take-while #(<= % 4000000) (p2-fib))
        result (reduce + 0 (filter even? fibs))]
    (println "fibs = " fibs)
    (println "result = " result)))

(defn -main[problem &args]
  (cond
    (= problem "2-fibs") (p2-main)
    :else (println "Solved problems: 1 
