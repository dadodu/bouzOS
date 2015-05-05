% shopt -s nullglob; for file in ../*.asm; do echo "\\asmcode[label=\\Author - ${file:3}]{$file}
\\newpage"; done;
