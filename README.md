INTRODUCTION
============

Vim 8's most anticipated feature is undoubtedly the `:smile` command. This
command increases the happiness of Vim users, and by doing so increases their
productivity.

However, not everyone can enjoy this new functionality. Some developers are
stuck with old Linux distributions that have old Vim builds, and can't upgrade
to Vim 8. Others use Neovim, which heartlessly refuses to port the `:smile`
command.

This plugin implements the `:smile` command in Vimscript, so that everyone can
enjoy it. It also extends the mechanism to allow plugin authors to create their
own smiles.

If you are able to use a recent Vim build that supports `:smile` you should
prefer the native implementation as it is more performant.


USAGE
=====

Use the `:Smile` command to show a smile and increase your happiness. Use
`:Smile type-of-smile` to show a specific smile. `:Smile smile` is the same
as `:Smile`.


CREATE YOUR OWN SMILES
======================

To create your own smile, create in one of the directories listed in
`runtimepath` a directory named "autoload/smile/resource/"(if it does not
already exist), and put in their a file with the `.sml` extension.  The file
format is as follows:

 - First line - the name of the default highlight group. This will be the
   highlight group of all characters that don't have a special highlight group
   specified.

 - A list of special hightlight groups. Each line will consist of a highlight
   group name, a single space, and a list of unseparated characters. These
   characters will be highlight with that highlight group.  Take care to not
   separate the characters with commas or spaces or anything.  or the
   separator character will also be highlighted.

 - A blank line. This marks the end of the header.

 - The ASCII art of the smile itself.

To use your smile, run `:Smile` with the name of the file minus the extension
as the argument.
For example, if your file is "autoload/smile/resource/hello.sml", run:
```vimscript
:Smile hello
```
