# vim-commentr

The commenter plugin for Vim.

## Features

- Block or inline? Commentr automagically picks the best one for you.
- Commentr can comment every single $h!t character for you. No restrictions. Comment with the full power of motions.
- Commentr is also file-type aware and properly escapes comments, so you never again have to fear of editing HTML or Vue files.
- Insert documentation, module or any other kind of comments into Rust or anywhere you want. Add your bindings for your favourite groups and configuration.
- Everything configurable with a single line.
- Does not use `setline()`.
- Lightweight.
- Impossible? Install and try out.

## Documentation

See `:help commentr`.

## Quick Usage

See `:help commentr-builtin-mappings`

## Why?

Because other comment plugins are a mess. Really. Look at the only two,
somewhat competitive commenter plugin that I know about:
[nerdcommenter](https://github.com/scrooloose/nerdcommenter) and
[tcomment](https://github.com/tomtom/tcomment_vim). Compared to them, commentr
is clean, lightweight and flexible. I tried nerdcommenter but it has some
serious defects for my usecase and as I remember I had poor experience with
motion commenting. I also wanted to try tcomment, but WTF?! When I looked at
the keybindings again WTF?! When I saw that it has separate keybindings for
inline and block-style commenting... no, no, thanks not, I just don't care
about it. Looking inside them, you can see they are both consist of about 2500
lines of Vim-script. commentr is just 1000 or even less. Ask yourself what's
that additional 1500 lines. Hacks? Workarounds?

## License

Released under the GNU General Public License version v3.0 or later.

[modeline]: # (vim: tw=78)
