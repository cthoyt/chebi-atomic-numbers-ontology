PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ChEMROF: <https://w3id/chemrof/>

INSERT {
    ?x ChEMROF:isobar_of ?y .
}
WHERE {
    ?x rdfs:subClassOf ?xRestriction .
    ?xRestriction rdf:type owl:Restriction ;
        owl:onProperty ChEMROF:neutron_number ;
        owl:hasValue ?xValue .

    ?y rdfs:subClassOf ?yRestriction .
    ?yRestriction rdf:type owl:Restriction ;
        owl:onProperty ChEMROF:neutron_number ;
        owl:hasValue ?yValue .
    FILTER(?x != ?y) .
    FILTER(?xValue = ?yValue) .
}
