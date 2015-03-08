public with sharing class ProjectNotificationHelper {
    
    /**
     * Constructor
     */
    public ProjectNotificationHelper() {
        
    }

    /**
     * Get Event
     */
    public List<Event> getEvents(List<Project__c> projects) {
        List<Event> events = new List<Event>();
        for (Project__c p : projects) {

            Event e = new Event(
                 OwnerId = UserInfo.getUserId()
                ,Subject = 'Project Kickoff Meeting : ' + p.Name
                ,WhatId = p.Id
                ,Location = p.KickoffMeetingLocation__c
                ,DurationInMinutes = 60
                ,ActivityDateTime = (p.KickoffMeetingDateTime__c != null)
                                        ? p.KickoffMeetingDateTime__c : DateTime.now()

            );
            // Add List
            events.add(e);
        }

        return events;
    }

    /**
     * Get EventRelation
     */
    public List<EventRelation> getEventRelations(List<Event> events, Map<Id, Project__c> projectMap) {
        List<EventRelation> eRelations = new List<EventRelation>();
        
        for (Event e : events) {
            Project__c p = new Project__c();
            if (projectMap.containsKey(e.WhatId)) {
                p = projectMap.get(e.WhatId);
            }
            for (ProjectMember__c member : p.ProjectMembers__r) {
                if (e.OwnerId != member.User__c) {
                    EventRelation er = new EventRelation(
                         EventId = e.Id
                        ,RelationId = member.User__c
                    );
                    // Add List
                    eRelations.add(er);
                }
            }
        }
        
        return eRelations;
    }
}