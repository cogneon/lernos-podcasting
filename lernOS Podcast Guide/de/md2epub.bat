magick -density 300 lernOS-Podcasting-Guide-de.pdf[0] ebook-cover.png
pandoc -s --epub-cover-image=ebook-cover.png -o lernOS-Podcasting-Guide-de.epub lernOS-Podcasting-Guide-de.md
ebook-convert lernOS-Podcasting-Guide-de.epub lernOS-Podcasting-Guide-de.mobi