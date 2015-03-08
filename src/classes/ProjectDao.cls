public with sharing class ProjectDao {

    /**
     * Get Project
     */
    public static List<Project__c> getProjects(List<Id> projectIds) {
        return [
            SELECT
                 Id
                ,Name
                ,KickoffMeetingLocation__c
                ,KickoffMeetingDateTime__c
                ,(SELECT Id,User__c FROM ProjectMembers__r)
            FROM
                Project__c
            WHERE
                Id IN: projectIds
        ];
    }
}