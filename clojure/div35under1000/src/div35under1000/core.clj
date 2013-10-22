(ns div35under1000.core
  (:gen-class))

(require 'clojure.set)

(defn abs
  "absolute value of a number n"
  [n]
  (if (> n 0) n (* n -1)))

(defn calc_qs
  "Calculate the sum of digits of a number n"
  [n]
  (let [digits (str (abs n))]
    (reduce + 0 (map #(- (int %) 48) digits))))

(defn is5
  "true if a number is cleanly divisible by five, false otherwise"
  [n]
  (let [lastd (first (reverse (str n)))]
    (or (= lastd \0) (= lastd \5))))

(defn is3
  "true if a number is cleanly divisible by three, false otherwise"
  [n]
  (let [qs (calc_qs n)]
    (= (rem qs 3) 0)))

(defn sum-35-nums-under-n
  "The sum of numbers that are divisible by 3 or 5 and less than n"
  [n]
  (let [all_nums (range 1 n)
        n3s (set (filter is3 all_nums))
        n5s (set (filter is5 all_nums))
        nums (clojure.set/union n3s n5s)]
    (reduce + 0 nums)))

(defn rem-based-sum-35-nums-under-n
  "The sum of numbers divisible by 3 or 5 and less than n based on division"
  [n]
  (let [nums (range 1 n)
        div3or5s (take-while #(or (= (rem % 3) 0) (= (rem % 5) 0)) nums)]
    (reduce + 0 div3or5s)))

(defn -main[limit method-selector]
  (let [n (Integer/parseInt limit)]
    (println "n = " n)
    (if (boolean method-selector)
      (println (sum-35-nums-under-n n))
      (println (rem-based-sum-35-nums-under-n n)))))
