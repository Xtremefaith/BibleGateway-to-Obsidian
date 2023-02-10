# BibleGateway-to-Obsidian
This script is forked from [selfire1's BibleGateway-to-Obsidian](https://github.com/selfire1/BibleGateway-to-Obsidian), which adapts [jgclark's wonderful BibleGateway-to-Markdown](https://github.com/jgclark/BibleGateway-to-Markdown) script to export for use in [Obsidian](https://obsidian.md/). It accompanies a [Bible Study in Obsidian Kit](https://forum.obsidian.md/t/bible-study-in-obsidian-kit-including-the-bible-in-markdown/12503?u=selfire) that gets you hands-on with using Scripture in your personal notes.

What the script does is fetch the text from [Bible Gateway](https://www.biblegateway.com/) and save it as formatted markdown file. Each chapter is saved as one file and navigation between files as well as a book-file is automatically created. All of the chapter files of a book are saved in it's numbered folder.

This script is intended to be as simple as possible to use, even if you have no idea about Scripting. If you have any questions, please reach out to me either on github or Discord (`selfire#3095`).

## Important Disclaimers
* This is not affiliated to, or approved by, BibleGateway.com. In my understanding it fits into the [conditions of usage](https://support.biblegateway.com/hc/en-us/articles/360001398808-How-do-I-get-permission-to-use-or-reprint-Bible-content-from-Bible-Gateway-?) but I make no guarantee regarding the usage of the script, it is at your own disgression.
* By default, the version is set to the [ESV](hhttps://www.esv.org). You can change the version, as long as you honour the copyright standards of different translations of the Bible (See: [BibleGateways overview](https://www.biblegateway.com/versions/)).
    * Change ESV to XXX in config.sh 
* I have little experience in scripting–through this project I taught myself bash and regex basics. If you run into issues or have a way to simplify this script, please raise an issue or reach out on Discord (`selfire#3095`).

## Installation
Here are the tools we are going to use:
* Our command line (Terminal)
* A text editor (like [Atom](https://atom.io/)).

## Setting ruby up

### Updating
In order to run the scripts, we will need to install ruby. Ruby comes pre-installed on MacOS but if you run into issues, [update to the latest version](https://stackify.com/install-ruby-on-your-mac-everything-you-need-to-get-going/).

### Downloading BibleGateway-to-Markdown.rb
Follow the instructions to download and set up [jgclark's BibleGateway-to-Markdown](https://github.com/jgclark/BibleGateway-to-Markdown).

**NOTE**: You don't need to download separate if you are cloning this repository git as it is a submodule. Please use the `--recurse-submodules` with git to download the submodules
```
git clone --recurse-submodules https://github.com/joebuhlig/BibleGateway-to-Obsidian.git
```

## Usage

### 1. Navigate to the directory in which both scripts are located.
Open terminal. Use the following command to navigate to the folder in which both scripts are located:
* `pwd` Show your current directory
* `ls` List all contents in the current directory
* `cd` Enter 'down' in a subdirectory (E.g. `cd Desktop`)
* `cd ..` Brings you 'up' one directory

### 2. Run the script
Once you are in the directory, run `bash bg2obs.sh`. This will run the bash script.

**NOTE**: Update the `config.sh` with the text editor first if you would like to adjust any settings prior to executing the command. Default settings include:
- Translation is `ESV`
- Headers is `false` - *include headers*
- Bold letters is `false` - *set the words of Jesus to bold*
- Split verses is `true` - *splits the verses into separate folders for each chapter and files for each verse*
- Master files is `true` - *creats a master file for each chapter folder (only available if split verses is `true`)

***WARNING**: During the execution of the script your clipboard will be unusable as it is used to capture the contents pulled from Bible Gateway*

### 3. (Optional) Rename Folders by Numerical Order
Run `bash rename-folders.sh` to add book numbers to the folder for sorting.

- `NOTE`: With this option, the subfolders within your translation folder (ie. `ESV`) will be updated with sequential prefixes like `01 - Genesis`, `02 - Exodus` and so on.

**There you go!** Now, just move the "ESV" folder into your Obsidian vault. You can use the provided `The Bible.md` file as an overview file. (Not setup with folder numbers)

## Translations
This script downloads the [ESV](hhttps://www.esv.org) by default. If you wish to use a different translation, open the `confg.sh` file in a text editor and follow the annotations in there (It is just changing one line). Make sure to honour copyright guidelines.
