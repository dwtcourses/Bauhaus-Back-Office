SELECT DISTINCT ?id ?uri ?labelLg1 ?labelLg2 ?code ?typeTerritory ?dateCreation ?dateSuppression ?hasComposition
FROM <${COG_GRAPH}>
FROM <${GEO_SIMS_GRAPH}>
 WHERE { 
		{	?uri igeo:nom ?labelLg1 ;
				 igeo:codeINSEE ?code .

			OPTIONAL {
				?evenementCreation igeo:creation ?uri ;
					               igeo:date ?dateCreation .
			}
			OPTIONAL {
				?evenementSuppression igeo:suppression ?uri ;
					                  igeo:date ?dateSuppression.
			}

			OPTIONAL {
				?uri a ?typeTerritoryUri .
				BIND(STRAFTER(str(?typeTerritoryUri),"geo#") AS ?typeTerritory)
			}
			FILTER (!BOUND(?typeTerritory) || ?typeTerritory IN ("Region","Departement","Etat"))

	} 
	UNION
	
	{
			?uri skos:prefLabel ?labelLg1 .
			?uri a 	igeo:TerritoireStatistique .
			BIND("Territoire Statistique" AS ?typeTerritory)

	}	
		UNION
	
	{
			?uri rdfs:label ?labelLg1 .
			?uri a 	igeo:TerritoireFrancais .
			BIND("Territoire Français" AS ?typeTerritory)

	}	
			
			
			BIND(REPLACE( STR(?uri) , '(.*/)(\\w.+$)', '$2' ) AS ?id)

			BIND(EXISTS{?uri geo:union ?unionFeat}||EXISTS{?uri geo:difference ?diffFeat} AS ?hasComposition)
			
<#if uriFeature != "">
			   FILTER (?uri = <${uriFeature}>)
</#if>
		
		}
ORDER BY ?code
		