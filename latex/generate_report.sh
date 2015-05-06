#!/bin/bash

export current_dir=`pwd`
export report_folder="$current_dir/report"

if [ ! -d "$report_folder" ]; then
    # Control will enter here if $DIRECTORY doesn't exist.
    mkdir $report_folder
fi

for dir in tp*
    do  mkdir -p $dir/pdf
        cp model.tex $dir/pdf/$dir.tex
        cd "$current_dir/$dir/pdf/"
        pdflatex --shell-escape $dir.tex
        cp $dir.pdf $report_folder
        cd $current_dir
        rm -r $dir/pdf
    done

