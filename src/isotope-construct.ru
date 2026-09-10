PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ChEMROF: <https://w3id.org/chemrof/>
PREFIX CHEBI: <http://purl.obolibrary.org/obo/CHEBI_>

INSERT {
    ?x rdfs:subClassOf [
        owl:onProperty ChEMROF:isotope_of;
        owl:someValuesFrom ?y
    ] .
}
WHERE {
    ?atom rdfs:subClassOf [
        owl:onProperty ChEMROF:atomic_number;
        owl:hasValue ?atomic_number
    ] ;
    ?x rdfs:subClassOf ?atom .
    ?y rdfs:subClassOf ?atom .
    FILTER(?x != ?y)
}
