# reference every png in img/ folder and generate a markdown file
# to display all the images in the folder

import os

def generate_readme():
    with open("README.md", "w") as f:
        f.write("# Images\n\n")

        # sort the images by name
        images = sorted(os.listdir("img/"))[::-1]
        for image in images:
            if image.endswith(".png"):
                f.write("## {0}\n\n![{0}](img/{0})\n\n".format(image))

                # load .tex from the same name
                tex = image[:-4] + ".tex"
                if os.path.exists("src/" + tex):
                    f.write("```tex\n")
                    with open("src/" + tex, "r") as tex_file:
                        f.write(tex_file.read())
                    f.write("\n```\n\n")

if __name__ == "__main__":
    generate_readme()