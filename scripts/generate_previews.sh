#find . -iname "*.scad" -exec sh -c 'echo "./previews/$(basename {} .scad).png"' \;
find -name "*.scad" -exec sh -c 'openscad -o "./previews/$(basename {} .scad).png" --render --autocenter --viewall {}' \;
