(ns aitextcleaner.formatting-residue
  (:require [clojure.string :as str]))

(def ^:private block-tag
  #"(?i)</?(?:address|article|blockquote|br|div|li|p|pre|section)\b[^>]*>")
(def ^:private html-tag #"<[^>]*>")

(defn clean-formatting-residue [text]
  (when-not (string? text)
    (throw (IllegalArgumentException. "text must be a string")))
  (-> text
      (str/replace block-tag "\n")
      (str/replace html-tag "")
      (str/replace "&amp;" "&")
      (str/replace "&lt;" "<")
      (str/replace "&gt;" ">")
      (str/replace "&quot;" "\"")
      (str/replace #"&#39;|&apos;" "'")
      (str/replace "&nbsp;" " ")
      (str/replace "“" "\"")
      (str/replace "”" "\"")
      (str/replace "‘" "'")
      (str/replace "’" "'")
      (str/replace "–" "-")
      (str/replace "—" "-")
      (str/replace "…" "...")
      (str/replace #"[ \t]+\n" "\n")
      (str/replace #"\n{3,}" "\n\n")
      str/trim))
