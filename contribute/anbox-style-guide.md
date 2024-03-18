
(style-guide)=
# Anbox Cloud Documentation Style Guide

Anbox Cloud documentation’s navigational structure, style, and content follows the Diátaxis systematic framework for technical documentation authoring. So the information is categorised into tutorials, how-to guides, reference material, and explanatory text. See [Diátaxis](https://diataxis.fr/).

This product-specific style guide lists any extra guidelines or deviations from the [Ubuntu style guide](https://docs.ubuntu.com/styleguide/en).

## Format

Anbox Cloud documentation is written in a combination of MyST and Markdown syntax.

## General

* Write inclusively and assume a friendly tone rather than an overly formal one.
* Use monospace format for:
    * Inline code and code blocks
    * File names: “manifest.yaml”
    * References to utilities/programs: “like python3 or curl”
    * File and directory paths: “in the /example/dir directory”
    * Command options: “the --force command option”
* Avoid long sentences. If it is a complex statement, try and break it down into multiple sentences.While the Canonical copy style guide has guidance about hyphens when joining words, it does not elaborate much on prefixes.
* Use bold and italics very sparingly. UI controls can be bold.
* Use single spaces between sentences.
* Use angle brackets to indicate variables.
* All extra whitespace should be removed, especially at the end of lines.

## Section titles

* Insert a blank line after a section title.
* Do not skip heading levels when creating sections.
* Avoid using multiple section titles sequentially without any text between them.
* Avoid manual HTML anchors, links to section titles can be picked up from the automatic page-level TOC on the right.

## Admonishments

While admonishments can be useful to convey important information, they can be a distraction when used often. So before adding an admonishment, assess if the content really belongs in one.

Keeping the types of admonishments to a minimum could be simplistic and also reduce cognitive overload on the reader. Stick to the following types of admonishments:

* Note
* Important
* Tip
* Caution

## Language

### Oxford/Serial Comma

The [Canonical copy style guide](https://docs.google.com/document/d/1AX-kSNztuAmShEoohe8L3LNLRnSKF7I0qkZGNeoGOok/edit#) discourages the use of the oxford/serial comma but there's still a lot of debate around it. The Anbox Cloud documentation does not restrict the usage of oxford comma because at worst, it can be annoying and can be construed as a practice of USA style of writing. However, there are places where not using it leads to ambiguous statements and sometimes, statements that have a whole different meaning.

In summary, the Anbox Cloud docs do not use the oxford comma in an attempt to adhere to the Canonical style guide as much as possible but exceptions are allowed for the sake of technical accuracy.

### Hyphens for Prefixes

Use hyphens when the starting letter of a word is in capital case or starts with a vowel. In other cases, do not hyphenate and use it as a single word.

    **Note:** You might be required to add such words to the wordlist as spellcheck could flag these words.

**Example:**
* Pre-employment
* Preconfigure

## Terminology

* It’s always “Anbox Cloud Appliance” when used in full form and “appliance” when used generically.
* Always use product name in full form with capitalisation - "Anbox Cloud".
* Within the context of Anbox Cloud, such as AMS, you can use the term "Anbox images" or "Anbox instances". When documenting about LXD images or containers that contain Anbox specific configuration from a big picture point of view,such as the architecture, use the term as "LXD images" or "LXD containers". When there is scope for ambiguity, elaborate and use as "LXD images with Anbox Cloud configuration".

## Images and screenshots

While images and screenshots are very helpful in visual appeal and getting the message across to the readers, they can be hard to maintain and cause overhead if they change too often. So use images or screenshots only when they:

* Do not change often requiring updates for every release.
* Explain the concept better than text or it should strongly reinforce the concept explained in the text.
* Add to the reader’s understanding rather than just providing a step by step visual of the user interface.
* Break the monotony of continuous text information when trying to accomplish a tough procedure.

Simple images can be made using an image editor of your choice or you can use [diagrams.net](https://www.diagrams.net).

## Redirects

Add redirects whenever a filepath changes as it affects the URL of the page.




