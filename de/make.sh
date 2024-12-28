PATH=$PATH:/opt/homebrew/bin
echo Starting lernOS Guide Generation ...

# Variables
filename="lernOS-podcasting-guide"
chapters="./src/index.md ./src/2-0-basics.md ./src/2-1-podcasting-canvas.md ./src/2-2-format.md ./src/2-3-workflow.md ./src/2-4-0-equipment-hardware.md ./src/2-4-1-microphone-headsets.md ./src/2-4-2-audio-recorder.md ./src/2-4-3-audio-interfaces-mixer.md ./src/2-5-0-equipment-software.md ./src/2-5-1-ardour.md ./src/2-5-2-audacity.md ./src/2-5-3-audition.md ./src/2-5-4-ferrite.md ./src/2-5-5-garageband.md ./src/2-5-6-hindenburg.md ./src/2-5-7-reaper-ultraschall.md ./src/2-5-8-studio-link.md ./src/2-5-9-zencastr.md ./src/2-6-0-podhosting.md ./src/2-7-studio.md ./src/2-8-buying-suggestions.md ./src/2-9-further-information.md ./src/2-10-podcasting-glossary.md ./src/3-0-learning-pathway.md ./src/3-1-kata-get-started.md ./src/3-2-kata-podcast-examples.md ./src/3-3-kata-podcast-canvas.md ./src/3-4-kata-pilot.md ./src/3-5-kata-podcast-studio.md ./src/3-6-kata-episode-1.md ./src/3-7-kata-podcast-website.md ./src/3-8-kata-episode-2.md ./src/3-9-kata-publication.md ./src/3-10-kata-communication.md ./src/3-11-kata-podcast-clinic.md ./src/4-0-appendix.md"

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
pandoc metadata.yaml --from markdown -s --resource-path="./src" --number-sections -V lang=de-de -o $filename.docx $chapters

# Create HTML Version (html)
echo Creating HTML version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" --number-sections -V lang=de-de -o $filename.html $chapters

# Create PDF Version (pdf)
echo Creating PDF version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" --template lernos --number-sections --toc -V lang=de-de -o $filename.pdf $chapters

# Create eBook Version (epub)
echo Creating eBook version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" --number-sections --toc -V lang=de-de -o $filename.epub $chapters

# Create Slides (revealjs)
# echo Creating Presentation ...
# pandoc --from markdown -s --resource-path="./src" -t revealjs -V theme=night -s ./slides/index.md -o ../docs/de-slides/index.html