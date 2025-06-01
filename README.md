# AppArmor

> A Sublime Text 3+ syntax definition for your AppArmor profiles

![Preview](https://i.imgur.com/FRRFdtr.png)

## Introduction

[AppArmor](https://apparmor.net/) is a Linux kernel module implementing a mandatory access control (MAC), which allows system administrators to confine their applications by writing intelligible plain text profiles.  
This project aims to provide a "basic" profile syntax definition for Sublime Text.

## Installation

### With Package Control

1. Open your command palette and type in : `Package Control: Install Package`
2. Browse the list or search for `AppArmor`
3. Press `Enter` and you're done !

Package Control dedicated page [here](https://packagecontrol.io/packages/AppArmor).

### Manually

1. Go to the Sublime Text packages folder (usually `$HOME/.config/sublime-text/Packages/` or `%AppData%\Sublime Text\Packages\`)
2. Clone this repository there : `git clone https://github.com/HorlogeSkynet/AppArmor.git`
3. Restart Sublime Text and... :tada:

## Usage

### Syntax

* Open your command palette and type in : `Set Syntax: AppArmor`

* Click on the bottom-right corner : `AppArmor`

* `View > Syntax > AppArmor`

### Build

* Open your command palette and type in : `Build With: AppArmor`

* Press `CTRL + B`

* `Tools > Build`

## Frequently Asked Questions

### Do you plan to support the _whole_ AppArmor syntax ?

> No, but feel free to contribute.

### Why does this syntax coloration s\*cks ?

> Well, sorry to hear that. Grammar wasn't my favorite course at school.  
> I'd be pleased to review any [issue](https://github.com/HorlogeSkynet/AppArmor/issues/new) or pull request.

### Why didn't you convert the [official Yacc parser](https://gitlab.com/apparmor/apparmor/-/blob/master/parser/parser_yacc.y) to [Sublime's definition syntax](https://www.sublimetext.com/docs/syntax.html) ?

> [It looks like](https://forum.sublimetext.com/t/convert-bnf-yacc-grammar-definition-to-syntax-package/15980) such a tool does not exist (yet ?).

### Would this plugin help me write a secure AppArmor profile for my application ?

> No, but I would advise you to read [a full set of AppArmor profiles](https://github.com/roddhjav/apparmor.d) publicly maintained by [@roddhjav](https://github.com/roddhjav).

### I've noticed you got an extensive tests suite, can I run it ?

> Of course, open the `AppArmor.sublime-syntax` file, press `CTRL + Shift + B` and choose `Build With: Syntax Tests`.
