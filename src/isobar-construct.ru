@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix ChEMROF: <https://w3id/chemrof/> .

CONSTRUCT {
    ?x ChEMROF:isobar_of ?y .
}
WHERE {
    ?x rdfs:subClassOf [
        rdf:type owl:Restriction ;
        owl:onProperty ChEMROF:neutron_number ;
        owl:hasValue ?n
    ] .
    ?y rdfs:subClassOf [
        rdf:type owl:Restriction ;
        owl:onProperty ChEMROF:neutron_number ;
        owl:hasValue ?n
    ] .
    FILTER(?x != ?y)
}
