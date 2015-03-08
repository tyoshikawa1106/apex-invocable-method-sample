@isTest
private class ProjectDaoTest {

    private static User testAdminUser = new User(Id = UserInfo.getUserId());
    
    /**
     * getProjectsTest1
     */
    static testMethod void getProjectsTest1() {

        System.runAs(testAdminUser) {
            List<Id> projectIds = new List<Id>();

            Test.startTest();

            List<Project__c> results = ProjectDao.getProjects(projectIds);

            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * getProjectsTest2
     */
    static testMethod void getProjectsTest2() {

        System.runAs(testAdminUser) {
            // Create Project
            Project__c project = PN_CommonTester.createProject(true);

            List<Id> projectIds = new List<Id>();
            projectIds.add(project.Id);

            Test.startTest();

            List<Project__c> results = ProjectDao.getProjects(projectIds);

            Test.stopTest();

            System.assertEquals(results.size(), 1);
            System.assertEquals(results[0].ProjectMembers__r.size(), 0);
        }
    }

    /**
     * getProjectsTest3
     */
    static testMethod void getProjectsTest3() {

        System.runAs(testAdminUser) {
            // Create Project
            Project__c project = PN_CommonTester.createProject(true);
            // Create User
            User user = PN_CommonTester.createUser(UserInfo.getProfileId(), true);
            // Create ProjectMember
            ProjectMember__c projectMember = PN_CommonTester.createProjectMember(project, user, true);
            System.assertEquals(projectMember.Project__c, project.Id);

            List<Id> projectIds = new List<Id>();
            projectIds.add(project.Id);

            Test.startTest();

            List<Project__c> results = ProjectDao.getProjects(projectIds);

            Test.stopTest();

            System.assertEquals(results.size(), 1);
            System.assertEquals(results[0].ProjectMembers__r.size(), 1);
        }
    }
}