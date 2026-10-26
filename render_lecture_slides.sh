#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")" && pwd)"

slides=(
  "teaching/STAT120/lectures/lecture_1/lecture_1_slide.qmd"
  "teaching/STAT120/lectures/lecture_2/lecture_2_slide.qmd"
  "teaching/STAT120/lectures/lecture_3/lecture_3_slide.qmd"
  "teaching/STAT120/lectures/lecture_4/lecture_4_slide.qmd"
  "teaching/STAT120/lectures/lecture_5/lecture_5_slide.qmd"
  "teaching/STAT120/lectures/lecture_6/lecture_6_slide.qmd"
  "teaching/STAT120/lectures/lecture_7/lecture_7_slide.qmd"
  "teaching/STAT120/lectures/lecture_8/lecture_8_slide.qmd"
  "teaching/STAT120/lectures/lecture_9/lecture_9_slide.qmd"
  "teaching/STAT120/lectures/lecture_10/lecture_10_slide.qmd"
  "teaching/STAT117/course_documents/all_lectures/chapter_1_slide.qmd"
  "teaching/STAT117/course_documents/all_lectures/chapter_2_slide.qmd"
  "teaching/STAT117/course_documents/all_lectures/chapter_3_slide.qmd"
  "teaching/STAT117/course_documents/all_lectures/chapter_4_slide.qmd"
  "teaching/STAT117/course_documents/all_lectures/chapter_5_slide.qmd"
  "teaching/STAT117/course_documents/all_lectures/chapter_6_slide.qmd"
  "teaching/DATA352/course_documents/all_lectures/Lecture_1.qmd"
  "teaching/DATA352/course_documents/all_lectures/Lecture_2.qmd"
  "teaching/DATA352/course_documents/all_lectures/Lecture_3.qmd"
  "teaching/DATA352/course_documents/all_lectures/Lecture_4.qmd"
  "teaching/DATA352/course_documents/all_lectures/Lecture_5.qmd"
  "teaching/DATA352/course_documents/all_lectures/Lecture_6.qmd"
  "teaching/DATA352/course_documents/all_lectures/Lecture_7.qmd"
  "teaching/DATA352/course_documents/all_lectures/Lecture_8.qmd"
  "teaching/DATA352/course_documents/all_lectures/Lecture_9.qmd"
)

for rel in "${slides[@]}"; do
  dir="$(dirname "$rel")"
  file="$(basename "$rel")"
  base="${file%.qmd}"

  (
    cd "$root/$dir"
    quarto render "$file" --to revealjs

    dest="$root/docs/$dir"
    mkdir -p "$dest"
    cp "$base.html" "$dest/$base.html"
    if [ -f "$base.css" ]; then
      cp "$base.css" "$dest/$base.css"
    fi
    rm -rf "$dest/${base}_files"
    if [ -d "${base}_files" ]; then
      cp -R "${base}_files" "$dest/${base}_files"
    fi
    find . -maxdepth 1 -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.gif' \) -exec cp {} "$dest/" \;
    rm -f "$dest/$file"

    if [ "$rel" = "teaching/DATA352/course_documents/all_lectures/Lecture_6.qmd" ]; then
      cp "Incubation period paper.pdf" nCoV_simple.csv nCoV-IDD-data-dictionary.xlsx "$dest/"
      mkdir -p "$root/docs/teaching/DATA352/course_documents/code"
      cp "$root/teaching/DATA352/course_documents/code/L6_code.R" \
        "$root/docs/teaching/DATA352/course_documents/code/L6_code.R"
    fi
  )
done
