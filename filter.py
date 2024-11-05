#!/usr/bin/env python
from panflute import *

def add_classes(elem, doc):
    # Add classes to specific elements
    if isinstance(elem, Header):
        elem.classes.append('handwritten')

    elif isinstance(elem, BlockQuote):
        elem.classes.append('torn-quote')

    elif isinstance(elem, Image):
        elem.classes.append('notebook-image')

    elif isinstance(elem, CodeBlock):
        elem.classes.append('code-block')

def main(doc=None):
    return run_filter(add_classes, doc=doc)

if __name__ == '__main__':
    main()
