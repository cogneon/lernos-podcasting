@echo off
echo Starting lernOS Guide Generation ...

REM Required Software
REM See lernOS Core Repository

REM Variables
set filename="lernOS-Podcasting-Guide-de"
set chapters=./source/1-Vorwort.md ./source/2-Lizenz.md ./source/3-Grundlagen.md ./source/4-Lernpfad.md ./source/5-Stop-talking.md ./source/6-Anhang.md

REM Delete Old Versions
echo Deleting old versions ...
del %filename%.docx %filename%.epub %filename%.mobi %filename%.html %filename%.pdf

REM Create Microsoft Word Version (docx)
echo Creating Word version ...
pandoc metadata.yaml -s %chapters% -o %filename%.docx

REM Create HTML Version (html)
echo Creating Web version ...
pandoc metadata.yaml -s --toc %chapters% -o %filename%.html

REM Create PDF Version (pdf)
echo Creating PDF version ...
pandoc metadata.yaml --from markdown --template lernOS --number-sections -V lang=de-de %chapters% -o %filename%.pdf 

REM Create eBook Versions (epub, mobi)
echo Creating eBook versions ...
magick -density 300 %filename%.pdf[0] images/ebook-cover.jpg
magick mogrify -size 2500x2500 -resize 2500x2500 images/ebook-cover.jpg
magick mogrify -crop 1563x2500+102+0 images/ebook-cover.jpg
pandoc metadata.yaml -s --epub-cover-image=images/ebook-cover.jpg %chapters% -o %filename%.epub
ebook-convert %filename%.epub %filename%.mobi

echo Done. Check for error messages or warnings above. 

pause