Ukulele Songbook Latex Style
============================

Usage
-----

`\usepackage{ukesong}` to include the document

`\begin{song}` and `\end{song}` to define a song.  New songs are automatically put on to new pages

`\C{A,B,...}` takes a comma separated list of chords and formats them (A-B-...) and adds the chord diagrams to the page

`\chord{name}{description}` defines a new chord.  The description should contain `\single <string> <fret>` and `\bar <start string> <fret> <text>` which will create the chord diagram

`\note{}` will add a note in square brackets

An example song of Re: Your Brains by Jonathan Coulton is included to show usage

Limitations
-----------

This is a very early proof of concept and the library of chords consists solely of those required for the included song.  This will be expanded over time.

I'm sure the implementation is horrible and would welcome any hints for improving it.

`#` signs are special in LaTeX so cannot be used in chord names. A capital `S` will be turned into a sharp sign in the printed output.

Dependencies
------------

The following LaTeX packages are required to build the document:

* xstring
* tikz
* ifthen
* geomety
* footmisc
