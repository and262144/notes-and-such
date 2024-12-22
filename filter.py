#!/usr/bin/env python
import panflute 

def prepare(doc):
    """Prepare the document by adding required metadata for MathJax"""
    if 'mathjax' not in doc.metadata:
        doc.metadata['mathjax'] = MetaBool(True)

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

    # Handle math elements
    elif isinstance(elem, Math):
        if elem.format == 'DisplayMath':
            elem.classes.append('math-display')
        else:
            elem.classes.append('math-inline')
            
    # Handle specific div and span elements that might contain math
    elif isinstance(elem, Div) or isinstance(elem, Span):
        if 'math' in elem.classes:
            elem.classes.append('tex2jax_process')

def finalize(doc):
    """Add any necessary final touches to the document"""
    # You could add additional processing here if needed
    pass

def main(doc=None):
    return run_filter(add_classes, prepare=prepare, finalize=finalize, doc=doc)

if __name__ == '__main__':
    main()