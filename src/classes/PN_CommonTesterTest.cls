@isTest
private class PN_CommonTesterTest {

    private static User testAdminUser = PN_CommonTester.getLoginUser();
    
    /**
     * Get Test User
     */
    static testMethod void getLoginUserTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            User result = PN_CommonTester.getLoginUser();
            System.assertEquals(result.Id, UserInfo.getUserId());
            
            Test.stopTest();
        }
    }

    /**
     * Create User
     */
    static testMethod void createUserTest() {

        System.runAs(testAdminUser) {
            Id profileId = UserInfo.getProfileId();
            
            Test.startTest();
            
            // Not Insert
            User user = PN_CommonTester.createUser(profileId, false);
            System.assertEquals(String.isEmpty(user.Id), true);
            
            // Insert
            user = PN_CommonTester.createUser(profileId, true);
            System.assertEquals(String.isNotEmpty(user.Id), true);
            
            Test.stopTest();
        }
    }

    /**
     * Create Project
     */
    static testMethod void createProjectTest() {

        System.runAs(testAdminUser) {
            
            Test.startTest();
            
            // Not Insert
            Project__c project = PN_CommonTester.createProject(false);
            System.assertEquals(String.isEmpty(project.Id), true);
            
            // Insert
            project = PN_CommonTester.createProject(true);
            System.assertEquals(String.isNotEmpty(project.Id), true);
            
            Test.stopTest();
        }
    }

    /**
     * Create Project Member
     */
    static testMethod void createProjectMemberTest() {

        System.runAs(testAdminUser) {

            // Create Project
            Project__c project = PN_CommonTester.createProject(true);
            // Create User
            User user = PN_CommonTester.createUser(UserInfo.getProfileId(), true); 
            
            Test.startTest();
            
            // Not Insert
            ProjectMember__c projectMember = PN_CommonTester.createProjectMember(project, user, false);
            System.assertEquals(String.isEmpty(projectMember.Id), true);
            
            // Insert
            projectMember = PN_CommonTester.createProjectMember(project, user, true);
            System.assertEquals(String.isNotEmpty(projectMember.Id), true);
            
            Test.stopTest();
        }
    }
}