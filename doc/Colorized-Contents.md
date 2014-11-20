Colorized contents - Piwi-Bash-Library
======================================

The library embeds a set of methods to construct some colorized text contents in terminal.

For a full example with custom options, see the `demo/colors-test.sh` script.

You can test colors rendering in your terminal using the `demo/colors-rendering-benchmark.sh` script.


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

-    `get_text_format_tag ( code )` to get a formated tag for this code,
-    `get_color_code ( name , background=FALSE )` to get a color code by color name (`foreground`
     by default, set the second argument on `true` to get background code),
-    `get_color_tag ( name , background=FALSE )` to get a color formated tag by color name (`foreground`
     by default, set the second argument on `true` to get background code),
-    `get_text_option_code ( name )` to get a text option code by text option name,
-    `get_text_option_tag ( name )` to get a text option formated tag by text option name,
-    `get_text_option_tag_close ( name )` to get a closing text option formated tag by text option name,

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
your text between opening and closing special tags constructed as XML tags `<...>text</...>`
and fill each tag with the name of the text option to use, the color name for foreground and
the color name prefixed by `bg` for a background color.

You can also use imbricated tags (note here that the rendering is not guaranteed depending
on user's system).

To build the final colorized string, just run:

    parse_color_tags "the string"

If your string is contained in a bash variable, you HAVE to surround the variable name between
doubel quotes like:

    parse_color_tags "$MYSTRING"

If your string is contained in a bash variable, you HAVE to surround the variable name between
doubel quotes like:

    parsecolortags "$MYSTRING"


--------------

Documentation page for the [Piwi Bash Library](http://github.com/atelierspierrot/piwi-bash-library).

**(c) 2013-2014 [Les Ateliers Pierrot](http://www.ateliers-pierrot.fr/)** - Paris, France - Some rights reserved.

This documentation is licensed under the [Creative Commons - Attribution - Share Alike - Unported - version 3.0](http://creativecommons.org/licenses/by-sa/3.0/) license.
