@isTest
private class ProjectNotificationHelperTest {

    private static ProjectNotificationHelper helper = new ProjectNotificationHelper();
    private static User testAdminUser = new User(Id = UserInfo.getUserId());
    
    /**
     * getProjectsTest1
     */
    static testMethod void getEventsTest1() {

        System.runAs(testAdminUser) {
            List<Project__c> projects = new List<Project__c>();

            Test.startTest();

            List<Event> results = helper.getEvents(projects);

            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * getProjectsTest2
     */
    static testMethod void getEventsTest2() {

        System.runAs(testAdminUser) {
            // Create Project
            Project__c project = PN_CommonTester.createProject(true);

            List<Project__c> projects = new List<Project__c>();
            projects.add(project);

            Test.startTest();

            List<Event> results = helper.getEvents(projects);

            Test.stopTest();

            System.assertEquals(results.size(), 1);
        }
    }

    /**
     * getEventRelationsTest1
     */
    static testMethod void getEventRelationsTest1() {

        System.runAs(testAdminUser) {
            List<Event> events = new List<Event>();
            Map<Id, Project__c> projectMap = new Map<Id, Project__c>();

            Test.startTest();

            List<EventRelation> results = helper.getEventRelations(events, projectMap);

            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * getEventRelationsTest2
     */
    static testMethod void getEventRelationsTest2() {

        System.runAs(testAdminUser) {
            // Create Project
            Project__c project = PN_CommonTester.createProject(true);
            // Create User
            User user = PN_CommonTester.createUser(UserInfo.getProfileId(), true);
            // Create ProjectMember
            ProjectMember__c projectMember = PN_CommonTester.createProjectMember(project, user, true);
            // Get Project ID
            List<Id> projectIds = new List<Id>{project.Id};
            // Get Project
            List<Project__c> projects = ProjectDao.getProjects(projectIds);
            // Get Event
            List<Event> events = helper.getEvents(projects);
            // Get ProjectMap
            Map<Id, Project__c> projectMap = new Map<Id, Project__c>(projects);

            Test.startTest();

            List<EventRelation> results = helper.getEventRelations(events, projectMap);

            Test.stopTest();

            System.assertEquals(results.size(), 1);
        }
    }
}