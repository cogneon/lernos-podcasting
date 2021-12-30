PATH=$PATH:/opt/homebrew/bin
echo Starting lernOS Guide Generation ...

# Variables
filename="lernOS-Podcasting-Guide-de"
chapters="./src/index.md ./src/2-0-Grundlagen.md ./src/2-1-Podcasting-Canvas.md ./src/2-2-Format.md ./src/2-3-Workflow.md ./src/2-4-0-Hardware.md ./src/2-4-1-Mikrofone-Headsets.md ./src/2-4-2-Audio-Rekorder.md ./src/2-4-3-Audio-Interfaces-Mischpulte.md ./src/2-4-4-Audio-Processing.md ./src/2-5-0-Software.md ./src/2-5-1-Ardour.md ./src/2-5-2-Audacity.md ./src/2-5-3-Audition.md ./src/2-5-4-Ferrite.md ./src/2-5-5-Garageband.md ./src/2-5-6-Hindenburg.md ./src/2-5-7-Reaper-Ultraschall.md ./src/2-5-8-Studio-Link.md ./src/2-5-9-Zencastr.md ./src/2-6-Studio.md ./src/2-7-Literatur-Links.md ./src/3-0-Lernpfad.md ./src/3-1-Kata-Get-Started.md ./src/3-2-Kata-Podcast-Beispiele.md ./src/3-3-Kata-Podcast-Canvas.md ./src/3-4-Kata-Nullnummer.md ./src/3-5-Kata-Podcast-Studio.md ./src/3-6-Kata-Episode-1.md ./src/3-7-Kata-Podcast-Webseite.md ./src/3-8-Kata-Episode-2.md ./src/3-9-Kata-Publikation.md ./src/3-10-Kata-Kommunikation.md ./src/3-11-Kata-Podcast-Klinik.md ./src/4-0-Anhang.md"

# Delete Old Versions
echo Deleting old versions ...
rm -rf $filename.*
rm -rf ../docs/de/*
rm -ff ../docs/de-slides/index.html

# Create Web Version (mkdocs)
echo Creating Web Version ...
mkdocs build

# Create Microsoft Word Version (docx)
echo Creating Word version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --number-sections -V lang=de-de -o $filename.docx $chapters

# Create HTML Version (html)
echo Creating HTML version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --number-sections -V lang=de-de -o $filename.html $chapters

# Create PDF Version (pdf)
echo Creating PDF version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --template lernos --number-sections --toc -V lang=de-de -o $filename.pdf $chapters

# Create eBook Versions (epub, mobi)
echo Creating eBook versions ...
magick -density 300 $filename.pdf[0] src/images/ebook-cover.jpg
mogrify -size 2500x2500 -resize 2500x2500 src/images/ebook-cover.jpg
mogrify -crop 1563x2500+102+0 src/images/ebook-cover.jpg
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --epub-cover-image=src/images/ebook-cover.jpg --number-sections --toc -V lang=de-de -o $filename.epub $chapters
ebook-convert $filename.epub $filename.mobi

#Create Slides (revealjs)
echo Creating Presentation ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" -t revealjs -V theme=night -s ./slides/index.md -o ../docs/de-slides/index.html
