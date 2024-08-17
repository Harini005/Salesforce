public with sharing class ProfileMetadata {
    private static String profileName{get; private set;}
    public static final String SYS_ADMIN = 'System Administrator';
    
    public static String getProfileName(Id profileId){
        if(String.isBlank(profileName)){
            profileName = [SELECT Name from Profile where Id=:profileId].Name;
        }
        return profileName;
    }
}