Colorized contents - Piwi-Bash-Library
======================================

The library embeds a set of methods to construct some colorized text contents in terminal.

For a full example with custom options, see the `bin/colors-test.sh` script.

You can test colors rendering in your terminal using the `bin/colors-rendering-benchmark.sh` script.


## Foreground, background and text options

### Terminal colors

Recent terminals can use some colored texts defined in the library as an array of the corresponding
code values to build a colorization tag. These colors are, mostly:

    black white
    red green yellow blue magenta cyan grey
    lightred lightgreen lightyellow lightblue lightmagenta lightcyan lightgrey

They can be used as a text color (`foreground`) or as a `background` color with another color
for text.

### Terminal text options

In the same spirit, recent terminals also allows a set of texts options which are:

    normal bold small underline blink reverse hidden

### Library handling of these possibilities

The library defines a full set of codes that can be used for each of the above colors or
options. These codes can be used to build the final terminal colorization tag:

    \033[ TEXT OPTION ; FOREGROUND OPTION ; BACKGROUND OPTION m

Some helping methods are defined to get these full fromated tags:

-    `gettextformattag ( code )` to get a formated tag for this code,
-    `getcolorcode ( name , background=FALSE )` to get a color code by color name (`foreground`
     by default, set the second argument on `true` to get background code),
-    `getcolortag ( name , background=FALSE )` to get a color formated tag by color name (`foreground`
     by default, set the second argument on `true` to get background code),
-    `gettextoptioncode ( name )` to get a text option code by text option name,
-    `gettextoptiontag ( name )` to get a text option formated tag by text option name,
-    `gettextoptiontagclose ( name )` to get a closing text option formated tag by text option name,

You can also build a complete string colorized (fully) calling method:

    colorize "string" text_option foreground background

by text option name, color name for foreground and color name for background, which are all
optionals.


## In-text tags

A special method, which may be the most often used, is defined to allow user to write a long
text with tags and parse it to build a colorized final rendering.

For example:

    This is <bold>a text with</bold> in-text <red>tags</red> \n\
    and some <bggreen>green background <bold>and imbricated</bold></bggreen> \
    tags ...

As you can see, the rule is quite simple to build a colorized string, you just need to surround
your text between opening and closing special tags constructed as the XML tags idea: `<...>text</...>`
and fill each tag with the name of the text option to use, the color name for foreground and
the color name prefixed by `bg` for a background color.

You can also use imbricated tags (note here that the rendering is not guaranteed depending
on the user system).

To build the final colorized string, just run:

    parsecolortags "the string"


--------------

Documentation page for the [Piwi Bash Library](http://github.com/atelierspierrot/piwi-bash-library).
