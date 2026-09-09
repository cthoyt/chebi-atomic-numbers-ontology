PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ChEMROF: <https://w3id.org/chemrof/>
PREFIX CHEBI: <http://purl.obolibrary.org/obo/CHEBI_>

# Example:
# CHEBI:37361 and CHEBI:37804 both ChEMROF:nucleon_number 201 .

INSERT {
    # ?x ChEMROF:isobar_of ?y .
    ?x rdfs:subClassOf [
        owl:onProperty ChEMROF:isobar_of;
        owl:someValuesFrom ?y
    ] .
}
WHERE {
    ?x rdfs:subClassOf [
        owl:onProperty ChEMROF:nucleon_number;
        owl:hasValue ?value
    ] .
    ?y rdfs:subClassOf [
        owl:onProperty ChEMROF:nucleon_number;
        owl:hasValue ?value
    ] .
    FILTER(?x != ?y)
}
