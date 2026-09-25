PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ChEMROF: <https://w3id.org/chemrof/>
PREFIX CHEBI: <http://purl.obolibrary.org/obo/CHEBI_>

INSERT {
    ?x rdfs:subClassOf [
        owl:onProperty ChEMROF:isodiapher_of;
        owl:someValuesFrom ?y
    ] .
}
WHERE {
    ?x rdfs:subClassOf [
        owl:onProperty ChEMROF:neutron_number;
        owl:hasValue ?n1
    ] ; rdfs:subClassOf/rdfs:subClassOf [
        owl:onProperty ChEMROF:atomic_number;
        owl:hasValue ?z1
    ] .

    ?y rdfs:subClassOf [
        owl:onProperty ChEMROF:neutron_number;
        owl:hasValue ?n2
    ] ; rdfs:subClassOf/rdfs:subClassOf [
        owl:onProperty ChEMROF:atomic_number;
        owl:hasValue ?z2
    ] .
    FILTER(?x != ?y) .
    FILTER(?n1 - ?z1 = ?n2 - ?z2) .
}
