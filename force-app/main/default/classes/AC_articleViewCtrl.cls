public with sharing class AC_articleViewCtrl {
    
    @AuraEnabled
    public static Map<String, Object> getFieldSetArticle(String articleId, String status) {  
        Set<String> fieldNames = new Set<String> {'Visible_to_public__c'};
  for(FieldSetMember fm: Schema.SObjectType.Knowledge__kav.fieldSets.requiredFields.getFields()) {
            fieldNames.add(fm.getFieldPath());
        }

        for(FieldSetMember fm: Schema.SObjectType.Knowledge__kav.fieldSets.additionalFields.getFields()) {
            fieldNames.add(fm.getFieldPath());
        }

        String queryString = 'SELECT ' + String.join(new List<String>(fieldNames), ', ') + ' FROM Knowledge__kav WHERE PublishStatus = \'' + status + '\' AND Id = \'' + articleId + '\'';
        system.debug(queryString);
        List<Knowledge__kav> article = Database.query(queryString); 
system.debug(article);
Map <String, Object> result = new Map<String, Object>();

        if(article.size()<=0) {
            return null;
        }

if(article[0].Visible_to_public__c) {
    for(FieldSetMember fm: Schema.SObjectType.Knowledge__kav.fieldSets.additionalFields.getFields()) {
                Object fieldValue = article[0].get(fm.getFieldPath());
                result.put(fm.getLabel(), fieldValue != null ? fieldValue : ' ');
       
            }
            return result;
}
 for(FieldSetMember fm: Schema.SObjectType.Knowledge__kav.fieldSets.requiredFields.getFields()) {
                Object fieldValue = article[0].get(fm.getFieldPath());
                result.put(fm.getLabel(), fieldValue != null ? fieldValue : ' ');
       
            }
 return result;
    }
}