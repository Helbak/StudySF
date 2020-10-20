@IsTest
private class AC_articleViewCtrlTest {
   
    @testSetup
   static void createMockArticle() {
    User user = [SELECT Id FROM User  LIMIT 1];
    Knowledge__kav unvisible = new Knowledge__kav(
        Title = 'Mock Title of Unvisible Article',
        UrlName = 'MockUrlNameOfUnvisibleArticle',
        Summary = 'Mock Summary of Unvisible Article',
        Visible_to_public__c = false,
        IsVisibleInPkb = true,
        IsVisibleInCsp = true,
        IsVisibleInPrm = true
    );
    insert unvisible;

    Knowledge__kav visible = new Knowledge__kav(
        Title = 'Mock Title of Visible Article',
        UrlName = 'MockUrlNameOfVisibleArticle',
        Summary = 'Mock Summary of Visible Article',
        Visible_to_public__c = true,
        IsVisibleInPkb = true,
        IsVisibleInCsp = true,
        IsVisibleInPrm = true
    );
    insert visible;
   } 
  
   @IsTest
   private static void testSetArticle() {
    Knowledge__kav unvisible = [SELECT Id FROM Knowledge__kav WHERE Title = 'Mock Title of Unvisible Article' LIMIT 1];
    Knowledge__kav visible = [SELECT Id FROM Knowledge__kav WHERE Title = 'Mock Title of Visible Article' LIMIT 1];

        integer amountFieldsInRequiredSet = Schema.SObjectType.Knowledge__kav.fieldSets.requiredFields.getFields().size();
        integer amountFieldsInAdditionalSet = Schema.SObjectType.Knowledge__kav.fieldSets.additionalFields.getFields().size();
       
        Test.startTest();

        Map <String, Object> requiredMap = AC_articleViewCtrl.getFieldSetArticle(unvisible.Id, 'Draft');
        Integer amountFieldsInRequiredMap = requiredMap.size();

        Map <String, Object>  additionalMap = AC_articleViewCtrl.getFieldSetArticle(visible.Id, 'Draft');
        Integer amountFieldsInAdditionalMap = additionalMap.size();
       
        Map <String, Object>  emptylMap = AC_articleViewCtrl.getFieldSetArticle('aaaaaaaaaaaaaaa', 'Draft');
        
        Test.stopTest();        
        System.assertEquals(amountFieldsInRequiredSet, amountFieldsInRequiredMap);
        System.assertEquals(amountFieldsInAdditionalSet, amountFieldsInAdditionalMap);
        System.assertEquals(requiredMap.get('Title'), 'Mock Title of Unvisible Article');
        System.assertEquals(additionalMap.get('Title'), 'Mock Title of Visible Article');
        System.assertEquals(requiredMap.get('Text__c'), null);
        System.assertEquals(additionalMap.get('Text__c'), null);
        System.assertEquals(emptylMap, null);
    }
}
