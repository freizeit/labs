(ns div35under1000.core-test
  (:use clojure.test
        div35under1000.core))

(deftest abs-zero
  (testing "absolute value of zero is zero"
    (is (= (abs 0) 0))))
(deftest abs-neg-number
  (testing "absolute value of -n is n"
    (is (= (abs -1) 1))))
(deftest abs-pos-number
  (testing "absolute value of n is n"
    (is (= (abs 2) 2))))

(deftest qs-pos-gt-zero
  (testing "the sum of digits for positive numbers above zero is correct"
    (is (= (calc_qs 123) 6))))
(deftest qs-neg
  (testing "the sum of digits for -n and n is the same"
    (is (= (calc_qs -456) (calc_qs 456)))))
(deftest qs-zero
  (testing "the sum of digits for zero is zero"
    (is (= (calc_qs 0) 0))))

(deftest is5-last-digit-0
  (testing "a number ending with digit 0 is divisible by five"
    (is (= (is5 100) true))))
(deftest is5-last-digit-5
  (testing "a number ending with digit 5 is divisible by five"
    (is (= (is5 155) true))))
(deftest is5-last-digit-neither-0-nor-5
  (testing "numbers ending with a digit that's neither 0 nor 5 are not divisible by five"
    (is (= (is5 151) false))))

(deftest is3-sum-of-digits-divisible-by-3
  (testing "a number whose sum of digits is divisible by three is also divisible by three"
    (is (= (is3 10011) true))))
(deftest is3-sum-of-digits-not-divisible-by-3
  (testing "a number whose sum of digits is *not* divisible by three won't be divisible by three eithetr"
    (is (= (is3 10012) false))))

(deftest sum-35-10
  (testing "the sum of numbers under 10 and divisible by 3 or 5 is 23"
    (is (= (sum-35-nums-under-n 10) 23))))
