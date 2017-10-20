# JSON for Concepts and Vocabularies - using SKOS and IKOS

IPTC maintains many Controlled Vocabularies (CV) - the [NewsCodes](https://iptc.org/standards/newscodes/) - for
- the categorization of news and sports data
- administrative purposes like registration of news providers
- support of news formats like NewsML-G2, SportsML-G2, EventsML-G2, NewsML 1

The JSON expression of Concepts and CVs is based on:
- SKOS - the W3C [Simple Knowledge Organisation System](https://www.w3.org/TR/skos-reference/)
- IKOS - the [IPTC Knowledge Organisation System](http://dev.iptc.org/IKOS)

This repository includes:

- JSON-schema: how to express CVs by a native JSON, the properties are controlled by a JSON Schema. It provides the Schema and an example.
- JSON-LD: how to express CVs by JSON-LD. It provides a @context document and an example.
