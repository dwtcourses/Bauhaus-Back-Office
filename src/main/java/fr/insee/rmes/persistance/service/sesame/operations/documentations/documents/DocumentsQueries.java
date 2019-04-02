package fr.insee.rmes.persistance.service.sesame.operations.documentations.documents;

import java.util.HashMap;
import java.util.Map;

import org.openrdf.model.Resource;
import org.openrdf.model.URI;

import fr.insee.rmes.config.Config;
import fr.insee.rmes.exceptions.RmesException;
import fr.insee.rmes.persistance.service.sesame.utils.FreeMarkerUtils;

public class DocumentsQueries {
	
	static Map<String,Object> params ;
	
	
	public static String getDocumentsQuery(String idSims, String idRubric) throws RmesException {
		if (params==null) {initParams();}
		params.put("idSims", idSims);
		params.put("idRubric", idRubric);
		return  buildRequest("getDocumentsQuery.ftlh", params);
	}
	
	public static String getDocumentUriQuery(URI url, Resource graph) throws RmesException {
		Map<String, Object> root = new HashMap<>();
		root.put("url", url);
		root.put("graph", graph);
		return  buildRequest("getDocumentUriFromUrlQuery.ftlh", params);
	}
	
	public static String lastDocumentID() throws RmesException {
        return buildRequest("lastDocumentID.ftlh", null);
	}	
	

	private static void initParams() {
		params = new HashMap<>();
		params.put("LG1", Config.LG1);
		params.put("LG2", Config.LG2);
	}
	
	
	private static String buildRequest(String fileName, Map<String, Object> params) throws RmesException  {
		return FreeMarkerUtils.buildRequest("operations/documentations/documents/", fileName, params);
	}
	
	
	 private DocumentsQueries() {
		 throw new IllegalStateException("Utility class");
	 }


}