Spinal reflex bindings template
********************************


Outline
=======

.. contents::


Features
========

Key bindings and features required for spinal reflex working!
This is template, not framework, not library.

* Setting Virtual keyborad
* Setting Key combination
* Setting Mouse gestures
* Customize for each applications (To be exact, windows)

You can customize `Main.ahk` and setting files and so on just you want.


Requirement
===========

* Windows 10
* `AutoHotkeyU64 <http://ahkscript.org/download/>`_
* `IME.ahk <http://www6.atwiki.jp/eamat/pages/17.html>`_ (bundled)


Provisioning
============

If you don't have installed AutoHotkeyU64 yet, install `here <http://ahkscript.org/download/>`_.

If you don't have run EnableUIAccess yet, install `here <http://www.autohotkey.com/board/topic/70449-enable-interaction-with-administrative-programs/>`_ 
and run ``EnableUIAccess.ahk``.


Installation
=================

Download this.

And create Settings.ini as following.

```
[FILE]
name = home
```


Usage
=================

If you want to start this script, only run ``Main.ahk``.


File Description
================

* Main.ahk
    * Main script.
    * Key mappings and mouse gestures.
* AppUtils.ahk
    * Application utility.
    * This script must be included first.
* ModeController.ahk
    * Controlls virtual keyboard mode.
    * Setting file wrapper.
* MouseGesture.ahk
    * Provides mouse gesture's command.
* MouseUtils.ahk
    * Mouse action definitions.
* Command.ahk
    * Complex command wrapper.
* keybindings (Directory)
    * Alphabets.ahk
    * Numbers.ahk
    * Others.ahk
    * Symbols.ahk
* settings (Directory)
    * Store setting files.


Licence
=================

MIT
---------

This software is released under the MIT License, see LICENSE.txt.

