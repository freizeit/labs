(ns even-fib.core-test
  (:use clojure.test
        even-fib.core))

(deftest fib-0
  (testing "zero element of the fibonacci sequence: zero"
    (is (= (fib 0) 0))))
(deftest fib-1
  (testing "fibonacci sequence value for 1 = 1"
    (is (= (fib 1) 1))))
(deftest fib-6
  (testing "fibonacci sequence value for 6 = 8"
    (is (= (fib 6) 8))))
