<cfcomponent>
    
    <cfset this.dlist=""> 
    <cfset this.depthValue=0>
    <cffunction name="getLocation" access="public">
        <cfquery name="get_location" result="locRes">
            select locationId,locationName,active,parentLocationId
            from location_list.locations WHERE active=1  
        </cfquery>
        <cfquery name="get_parent_location" dbtype="query">
            select locationId, locationName,parentLocationId
            from get_location
            where parentLocationId is null
        </cfquery>
        <cfif locRes.RecordCount GT 0 >
            <cfreturn get_parent_location>
        </cfif>
    </cffunction>

    <cffunction name="buildTree" output="true">
        <cfargument name="locationId" type="numeric" />
        <cfargument name="locationName" type="string" />
       <cfquery name="get_location" result="locRes">
            select locationId,locationName,active,parentLocationId
            from location_list.locations WHERE active=1  
        </cfquery>
        <cfquery name="LOCAL.childList" dbtype="query">
            select locationId, locationName
            from get_location
            where parentLocationId = <cfqueryparam value="#arguments.locationId#" cfsqltype="cf_sql_integer" />
        </cfquery>
        
        <li>#arguments.locationName#
        #arguments.locationId#
            <cfif LOCAL.childList.recordcount>                
                <ul>
                    <!--- Child Nodes--->
                    <cfloop query="LOCAL.childList">
                        <!--- Recursive Function --->                       
                        <cfset buildTree(locationId=LOCAL.childList.locationId, locationName=LOCAL.childList.locationName) />
                    </cfloop>
                </ul>
            </cfif>
        </li>        
    </cffunction>

    <cffunction name="sortTree" access="public" output="true">
        <cfargument name="locationId" type="numeric" />
        <cfargument name="locationName" type="string" />
       <cfquery name="get_location" result="locRes">
            select locationId,locationName,active,parentLocationId
            from location_list.locations WHERE active=1  ORDER BY locationName ASC
        </cfquery>
        <cfquery name="LOCAL.childList" dbtype="query">
            select locationId, locationName
            from get_location
            where parentLocationId = <cfqueryparam value="#arguments.locationId#" cfsqltype="cf_sql_integer" />
            ORDER BY locationName ASC
        </cfquery>
        
        <li>#arguments.locationName#        
            <cfif LOCAL.childList.recordcount>                
                <ul>
                    <!--- Child Nodes--->
                    <cfloop query="LOCAL.childList">
                        <!--- Recursive Function --->                       
                        <cfset sortTree(locationId=LOCAL.childList.locationId, locationName=LOCAL.childList.locationName) />
                    </cfloop>
                </ul>
            </cfif>
        </li>        
    </cffunction>

    <cffunction  name="printList" access="public">
        <cfquery name="get_location" result="locRes">
            select locationId,locationName,active,parentLocationId
            from location_list.locations WHERE active=1 ORDER BY locationName ASC 
        </cfquery>
        <cfquery name="get_parent_location" dbtype="query">
            select locationId, locationName,parentLocationId
            from get_location
            where parentLocationId is null ORDER BY locationName ASC 
        </cfquery>
        <cfif locRes.RecordCount GT 0 >
            <cfreturn get_parent_location>
        </cfif>
        <!---<cfquery name="sortList" result="sortRes">
            SELECT * FROM location_list.locations ORDER BY locationName
        </cfquery>
        <cfreturn sortList>--->
    </cffunction>

    <cffunction  name="parentNodes" access="public" output="true">
        <cfargument name="locationId" type="numeric" />
        <cfquery name="LOCAL.parentList" result="parRes">
            select locationId, locationName,parentLocationId
            from location_list.locations
            where locationId = <cfqueryparam value="#arguments.locationId#" cfsqltype="cf_sql_integer" />
        </cfquery>               
            <cfif LOCAL.parentList.recordcount>              
                    <!--- Child Nodes--->
                    <cfoutput query="LOCAL.parentList">                  
                        <!--- Recursive Function ---> 
                         #LOCAL.parentList.parentlocationId# 
                         <cfif parentLocationId NEQ "">                         
                            <cfset parentNodes(locationId=parentLocationId) />
                        </cfif>
                    </cfoutput>                
            </cfif>                
    </cffunction>  

    <cffunction  name="childNodes" access="public" output="true">
        <cfargument name="locationId" type="numeric" />        
        <cfset this.clist="">        
        <cfquery name="LOCAL.childList"  result="childRes">
            select locationId, locationName
            from location_list.locations
            where parentLocationId = <cfqueryparam value="#arguments.locationId#" cfsqltype="cf_sql_integer" />
        </cfquery>       
        <cfif LOCAL.childList.recordcount>      
            <!--- Child Nodes--->
            <cfoutput query="LOCAL.childList">             
                <!--- Recursive Function 
                <cfset clist=listAppend(this.clist, LOCAL.childList.locationId)/>---> 
                #LOCAL.childList.locationId# 
                <cfset childNodes(locationId=LOCAL.childList.locationId) />
            </cfoutput>                  
        </cfif>            
    </cffunction>

    <cffunction name="findDepth" access="public" output="true">
        <cfargument name="locationId" type="integer" >
        <cfargument name="depth" type="numeric" >        
        <cfquery name="LOCAL.parentNodes" result="parRes">
            select locationId, locationName,parentLocationId
            from location_list.locations
            where locationId = <cfqueryparam value="#arguments.locationId#" CFSQLType="CF_SQL_INTEGER">
        </cfquery> 
        <cfif LOCAL.parentNodes.RecordCount NEQ 0>              
            <!--- Child Nodes--->
            <cfset this.depthValue=arguments.depth+1>            
            <cfoutput query="LOCAL.parentNodes">                  
                <!--- Recursive Function --->  
                <cfif parentLocationId NEQ "">                           
                    <cfset findDepth(locationId=LOCAL.parentNodes.parentlocationId,depth=this.depthValue) >      
                </cfif>                              
            </cfoutput>  
        </cfif>
        <cfoutput>
            #this.depthValue#        
        </cfoutput> 
    </cffunction>

</cfcomponent>