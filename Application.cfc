
<cfcomponent output="false">
    <cfset this.name="location_tree">
    <cfset this.sessionManagement = "true" >
    <cfset this.sessionTimeout = createTimespan(0,0,30,0)>
    <cfset This.applicationtimeout=createTimespan(2,0,0,0)> 
    <cfset this.clientManagement="true">
    <cfset this.setClientCookies=true>
    <cfset this.scriptProtect="all">
    
    <cfset this.loginStorage = "session"> 
    <cfset this.datasource="location_list">   
    <cfset this.dlist=""> 
    <cffunction name="OnApplicationStart" returntype="boolean" access="public">
            
        <cfreturn true>
    </cffunction>
        
</cfcomponent>