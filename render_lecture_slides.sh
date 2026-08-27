#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")" && pwd)"

slides=(
  "teaching/STAT120/lectures/lecture_1/lecture_1_slide.qmd"
  "teaching/STAT120/lectures/lecture_2/lecture_2_slide.qmd"
  "teaching/STAT117/course_documents/all_lectures/chapter_1_slide.qmd"
  "teaching/STAT117/course_documents/all_lectures/chapter_2_slide.qmd"
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
    rm -rf "$dest/${base}_files"
    if [ -d "${base}_files" ]; then
      cp -R "${base}_files" "$dest/${base}_files"
    fi
    find . -maxdepth 1 -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.gif' \) -exec cp {} "$dest/" \;
    rm -f "$dest/$file"
  )
done
