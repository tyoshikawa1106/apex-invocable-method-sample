@isTest
private class ProjectNotificationActionTest {

    private static User testAdminUser = new User(Id = UserInfo.getUserId());
    
    /**
     * notificationTest1
     */
    static testMethod void notificationTest1() {

        System.runAs(testAdminUser) {
            List<Id> projectIds = new List<Id>();

            Test.startTest();

            ProjectNotificationAction.notification(projectIds);

            Test.stopTest();

            List<Event> resultEvents = [SELECT Id FROM Event LIMIT 1];
            System.assertEquals(resultEvents.isEmpty(), true);
        }
    }

    /**
     * notificationTest2
     */
    static testMethod void notificationTest2() {

        System.runAs(testAdminUser) {
            // Create Project
            Project__c project = PN_CommonTester.createProject(true);

            List<Id> projectIds = new List<Id>();
            projectIds.add(project.Id);

            Test.startTest();

            ProjectNotificationAction.notification(projectIds);

            Test.stopTest();

            List<Event> resultEvents = [SELECT Id FROM Event WHERE WhatId =: project.Id];
            System.assertEquals(resultEvents.size(), 1);

            List<EventRelation> resultEventRelations = [SELECT Id FROM EventRelation WHERE EventId =: resultEvents[0].Id];
            System.assertEquals(resultEventRelations.isEmpty(), true);
        }
    }

    /**
     * notificationTest3
     */
    static testMethod void notificationTest3() {

        System.runAs(testAdminUser) {
            // Create Project
            Project__c project = PN_CommonTester.createProject(true);
            // Create User
            User user = PN_CommonTester.createUser(UserInfo.getProfileId(), true);
            // Create ProjectMember
            ProjectMember__c projectMember = PN_CommonTester.createProjectMember(project, user, true);

            List<Id> projectIds = new List<Id>();
            projectIds.add(project.Id);

            Test.startTest();

            ProjectNotificationAction.notification(projectIds);

            Test.stopTest();

            List<Event> resultEvents = [SELECT Id FROM Event WHERE WhatId =: project.Id];
            System.assertEquals(resultEvents.size(), 1);

            List<EventRelation> resultEventRelations = [SELECT Id FROM EventRelation WHERE EventId =: resultEvents[0].Id];
            System.assertEquals(resultEventRelations.size(), 1);
        }
    }
}