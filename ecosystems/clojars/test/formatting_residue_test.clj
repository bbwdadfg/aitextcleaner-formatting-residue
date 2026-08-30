(ns aitextcleaner.formatting-residue-test
  (:require [clojure.test :refer [deftest is run-tests]]
            [aitextcleaner.formatting-residue :refer [clean-formatting-residue]]))

(deftest cleans-copied-formatting-residue
  (is (= "Hello world...\n\nNext line"
         (clean-formatting-residue "<p>Hello <span>world</span>…</p><div>Next line</div>"))))

(when (= *file* (System/getProperty "babashka.file"))
  (System/exit (if (zero? (:fail (run-tests)) ) 0 1)))
