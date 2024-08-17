public with sharing class TaskTriggerHandler {
    public static void onBeforeDelete(){
        List<Task> oldRecords = (List<Task>)Trigger.old;
        String profileName = ProfileMetadata.getProfileName(UserInfo.getProfileId());
        
        for(Task record : oldRecords){
            if(profileName != ProfileMetadata.SYS_ADMIN)  {
                record.addError('Unable to delete the record. Please Contact your System Admin');
            }
        }
    }
}