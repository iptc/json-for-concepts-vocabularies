#IKOS' native JSON - IPTC format for Concepts and Schemes

## Introduction
Concepts and schemes of concepts are key building blocks for knowledge mangement and there is a common need for data models and formats to do this properly.
IPTC, the global standards body for the news media (https://iptc.org), is facing this need as it maintains itself many Controlled Vocabularies used for news. But also its members share this need for their own vocabularies and vocabularies required for the processing of news.

For that reason IPTC has taken a few basic decisions:

- the data model should follow the W3C SKOS (Simple Knowledge Organization System) - https://www.w3.org/TR/skos-reference/

- different formats should be available:

	- the specific formats for W3C's RDF which is the background of SKOS (RDF-XML, Turtle, JSON-LD)

	- NewsML-G2 Knowledge Items and Concept Items as part of the generic IPTC XML format for news - http://www.newsml-g2.org

	- a JSON format with only low level processing requirements - and that is this **IKOS-JSON = IPTC Knowledge Organization System JSON**

For the IKOS native JSON format two JSON Schemas are available (for both are PDFs as documentation available):

- IKOS-concept-schema-0.2.json as Schema of a Concepts
- IKOS-scheme-schema-0.2.json as Schema of the Concept Scheme (equivalant to a Knowledge Item)
