SELECT DISTINCT ?id ?identifiant ?labelLg1 ?labelLg2 ?type ?concept ?codeList ?range ?descriptionLg1 ?descriptionLg2 ?validationState ?created ?modified
FROM <${STRUCTURES_COMPONENTS_GRAPH}>
WHERE {
    ?component dcterms:identifier '${ID}' ;
               insee:identifiantMetier ?identifiant ;
               rdf:type ?type ;
               rdfs:label ?labelLg1 .

    OPTIONAL {
        ?component insee:validationState ?validationState
    } .

    OPTIONAL {
        ?component dcterms:created ?created
    } .
    OPTIONAL {
        ?component dcterms:modified ?modified
    } .

    OPTIONAL {
        ?component qb:concept ?conceptObject
    } .

    OPTIONAL {
        ?component qb:codeList ?codeList
    } .

    OPTIONAL {
        ?component rdfs:range ?range
    } .
    FILTER (lang(?labelLg1) = '${LG1}')
    OPTIONAL {?component rdfs:label ?labelLg2 .
    FILTER (lang(?labelLg2) = '${LG2}') } .
    OPTIONAL {?component rdfs:comment ?descriptionLg1 .
    FILTER (lang(?descriptionLg1) = '${LG1}') } .
    OPTIONAL {?component rdfs:comment ?descriptionLg2 .
    FILTER (lang(?descriptionLg2) = '${LG2}') } .

    BIND(STRAFTER(STR(?conceptObject),'concepts/definition/') AS ?concept) .
}
ORDER BY ?labelLg1