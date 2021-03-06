Editor
======

Sets key bindings.

Settings
--------

### Key bindings

To enable key bindings, add the following to *zpreztorc*, and replace 'bindings'
with 'emacs' or 'vi'.

    zstyle ':prezto:module:editor' key-bindings 'bindings'

### Dot Expansion

To enable the auto conversion of .... to ../.., add the following to
*zpreztorc*.

    zstyle ':prezto:module:editor' dot-expansion 'yes'

### Select-word-style

To configure the treatment of words by editing functions like
backward-kill-word, add the following to zpreztorc.

  zstyle ':prezto:module:editor' select-word-style 'style'

where 'style' can be: 'bash', 'normal', 'shell', 'whitespace', or 'default'
('default' means the same as 'normal'). See the documentation for zshcontrib
for details.


Theming
-------

To indicate when the editor is in the primary keymap (emacs or viins), add
the following to your `theme_prompt_setup` function.

    zstyle ':prezto:module:editor:info:keymap:primary' format '>>>'

To indicate when the editor is in the primary keymap (emacs or viins) insert
mode, add the following to your `theme_prompt_setup` function.

    zstyle ':prezto:module:editor:info:keymap:primary:insert' format 'I'

To indicate when the editor is in the primary keymap (emacs or viins) overwrite
mode, add the following to your `theme_prompt_setup` function.

    zstyle ':prezto:module:editor:info:keymap:primary:overwrite' format 'O'

To indicate when the editor is in the alternate keymap (vicmd), add the
following to your `theme_prompt_setup` function.

    zstyle ':prezto:module:editor:info:keymap:alternate' format '<<<'

To indicate when the editor is completing, add the following to your
`theme_prompt_setup` function.

    zstyle ':prezto:module:editor:info:completing' format '...'

Then add `$editor_info[context]`, where context is *keymap*, *insert*, or
*overwrite*, to `$PROMPT` or `$RPROMPT` and call `editor-info` in the
`prompt_name_preexec` hook function.

Authors
-------

*The authors of this module should be contacted via the [issue tracker][1].*

  - [Sorin Ionescu](https://github.com/sorin-ionescu)

[1]: https://github.com/sorin-ionescu/oh-my-zsh/issues

