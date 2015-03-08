public with sharing class PN_CommonTester {

    /**
     * Get Login User
     */
    public static User getLoginUser() {
        return new User(Id = UserInfo.getUserId());
    }

    /**
     * Create User
     */
    public static User createUser(Id profileId, Boolean isInsert) {
        
        User user = new User(
             LastName = 'LastName'
            ,Alias = 'Alias'
            ,Email = 'user@tester.co.jp'
            ,Username = 'user@tester.co.jp.dev'
            ,CommunityNickname = 'TestUser'
            ,EmailEncodingKey = 'ISO-2022-JP'
            ,TimeZoneSidKey = 'Asia/Tokyo'
            ,LocaleSidKey = 'ja_JP'
            ,LanguageLocaleKey = 'ja'
            ,ProfileId = profileId
        );
        
        if (isInsert) {
            insert user;
        }
        
        return user;
    }

    /**
     * Create Project
     */
    public static Project__c createProject(Boolean isInsert) {
        
        Project__c project = new Project__c(       
            Name = 'Sample Project'
        );
        
        if (isInsert) {
            insert project;
        }
        
        return project;
    }

    /**
     * Create Project Member
     */
    public static ProjectMember__c createProjectMember(Project__c project, User user, Boolean isInsert) {
        
        ProjectMember__c projectMember = new ProjectMember__c(       
             Project__c = project.Id
            ,User__c = user.Id
        );
        
        if (isInsert) {
            insert projectMember;
        }
        
        return projectMember;
    }
}