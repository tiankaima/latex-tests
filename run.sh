# assuming Ubuntu 20.04, skipping updates

# sudo apt-get update
# sudo apt-get upgrade -y
sudo apt-get install texlive-full imagemagick python3
sudo sed -i '/disable ghostscript format types/,+6d' /etc/ImageMagick-6/policy.xml
mkdir img

# .tex files are stored under src/
# each file is a standalone tikzpicture, compile them to png, store in img/ with the same name
# the png files are used in the README.md

# compile all .tex files in src/
for f in src/*.tex; do
    # get filename without extension
    filename=$(basename -- "$f")
    filename="${filename%.*}"
    # compile to pdf
    pdflatex -output-directory img/ $f
    # convert pdf to png
    convert -density 300 img/$filename.pdf -quality 90 img/$filename.png
    # remove pdf, aux, log files
    rm img/$filename.pdf
    rm img/$filename.aux
    rm img/$filename.log
done

# run python script to generate README.md
python3 generate_readme.py