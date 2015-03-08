public with sharing class ProjectNotificationAction {

    private class ProjectNotificationActionException extends Exception {}
    private static ProjectNotificationHelper helper = new ProjectNotificationHelper();

    @InvocableMethod(label='notification' description='Project Notification')
    public static void notification(List<Id> projectIds) {
        Savepoint sp = Database.setSavepoint();
        try {
            // Get Project
            List<Project__c> projects = ProjectDao.getProjects(projectIds);
            // Get Project Map
            Map<Id, Project__c> projectMap = new Map<Id, Project__c>(projects);
            // Get Create Event
            List<Event> events = helper.getEvents(projects);
            // Create Event
            insert events;
            // Get Create EventRelation
            List<EventRelation> eRelations = helper.getEventRelations(events, projectMap);
            // Create EventRelation
            insert eRelations;
        } catch (DmlException e) {
            Database.rollback(sp);
            throw new ProjectNotificationActionException(e.getDmlMessage(0));
            return;
        } catch (Exception e) {
            Database.rollback(sp);
            throw new ProjectNotificationActionException(e.getMessage());
            return;
        }
    }
}