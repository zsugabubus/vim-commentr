# vim-commentr

The bestest commenter plugin for Vim you have ever dreamed about.

## Features

- Block or inline? WTF?! What is it? The Stone Age? Who the f@#k cares?  **Commentr _knows_ what's the best for you**.
- Need to comment out something in the middle of the line, or a whole indention level? Not a problem. Be even more productive and comment with the full power of **motions**. Insert comments above, below, left, right, anywhere you want.
- Fear of opening Markdown, HTML, Vue files because they contain multiple syntax elements? Good news, commentr is here to save you. It's f*cking **syntax aware** and does **proper comment (un)escapes**.
- Get bored and feel like you need custom styled comments? Add your **custom comment types and bindings**. Insert documentation or module comments to Rust and C/C++ code out of box. Anyway, you will surely find what you need among the more thousand builtin filetypes.
- **One-liner filetype configuration** that's compatible with `'commentstring'`. In reality, it's an extension to `&comments`. You can even change that it `'modeline'` and commentr will use that.
- **Sexy as hell**: Parses `''comments'` for middle parts of three-piece comments.
- Do you still use other silly commenter plugin? What are you waiting for? Install!

## Installation

These are just here, because it's cool.

```vim
" vim-plug
Plug 'zsugabubus/vim-commentr'

" vundle or similar
Plugin 'zsugabubus/vim-commentr'

" neobundle
NeoBundle 'zsugabubus/vim-commentr'
```

## Documentation

See `:help commentr`.

## Quick Usage

See `:help commentr-builtin-mappings`

## ToDo List

- [ ] Think out the hook system. Please help with ideas.
- [ ] Stabilize escape sequences, escpecially for "c/cpp".
- [ ] Improve comment ranker.
- [ ] Test, test, test.
- [ ] Add better support for dot operator.
- [ ] Better documentation.

###### (Oh, sh!t. No ticks? Keep calm, I removed ready tasks.)

## License

Released under the GNU General Public License version v3.0 or later.

[modeline]: # (vim: tw=78)
