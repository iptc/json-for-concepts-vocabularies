# Samples

## Simple Examples

* IKOS-sample01.json = basic example of a Concept Scheme including a few Concepts
* IKOS-JSONLD-sample01.json = the same basic example as JSON-LD enabled syntax variant. Apply this example to the JSON-LD Playground - http://json-ld.org/playground/ - and you will see how a JSON-LD processor creates RDF triples from this JSON. Note: the "@context" object in this example can be added to any JSON complying with the IKOS JSON schema.

## Mapping IPTC Knowledge Items to JSON

The XSLT file IPTCki-to-IKOS-JSONscheme-draft.xslt transforms the XML syntax of a Knowledge Item to JSON syntax of the IKOS-schema.

Two transformation examples are available:
* IPTC Media Topics, about 1100 topics in a hiearchical tree: KI-medtop.xml - KI-medtop.json 
* IPTC Scene codes, about 20 terms as a flat list: KI-scene.xml - KI-scene.json 

