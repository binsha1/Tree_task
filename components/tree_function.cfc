<cfcomponent>
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
        <!--- Check for any nodes that have *this* node as a parent --->
        <cfquery name="LOCAL.childList" dbtype="query">
            select locationId, locationName
            from get_location
            where parentLocationId = <cfqueryparam value="#arguments.locationId#" cfsqltype="cf_sql_integer" />
        </cfquery>
        
        <li>#arguments.locationName#
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

    <cffunction  name="printList" access="public">
        <cfquery name="sortList" result="sortRes">
            SELECT * FROM location_list.locations ORDER BY locationName
        </cfquery>
        <cfreturn sortList>
    </cffunction>

    <cffunction  name="parentNodes" access="public" output="true">
        <cfargument name="locationId" type="numeric" />
        <cfargument name="locationName" type="string" />
        <cfargument name="parId" type="integer" />
        <!--- Check for any nodes that have *this* node as a parent --->
        <cfset local.loc_list="">
        <cfquery name="LOCAL.childList" dbtype="query">
            select locationId, locationName
            from get_location
            where parentLocationId = <cfqueryparam value="#arguments.locationId#" cfsqltype="cf_sql_integer" />
        </cfquery>

        <cfset local.local_list=listAppend(local.loc_list, arguments.locationId)>
        <cfset listArray=listToArray(local.local_list)>
        <cfdump var="#local.local_list#">        
            <cfif LOCAL.childList.recordcount>              
                    <!--- Child Nodes--->
                    <cfloop query="LOCAL.childList">                  
                        <!--- Recursive Function --->                       
                        <cfset parentNodes(locationId=LOCAL.childList.locationId, locationName=LOCAL.childList.locationName,parId=5) />
                    </cfloop>                
            </cfif>
        <cfloop index="i" from="#arguments.parId#" to="#arguments.locationId#" step="1">
           <cfoutput> #local.local_list# </cfoutput>
        </cfloop>        
    </cffunction>

    <cffunction  name="childNodes" access="public" output="true">
        <cfargument name="locationId" type="numeric" />
        <cfargument name="locationName" type="string" />
        <cfargument name="chId" type="integer" />
        <!--- Check for any nodes that have *this* node as a parent --->
        <cfset local.loc_list="">
        <cfquery name="LOCAL.childList" dbtype="query">
            select locationId, locationName
            from get_location
            where parentLocationId = <cfqueryparam value="#arguments.locationId#" cfsqltype="cf_sql_integer" />
        </cfquery>

        <cfset local.local_list=listAppend(local.loc_list, arguments.locationId)>
        <cfset listArray=listToArray(local.local_list)>
        <cfdump var="#local.local_list#">
        
            <cfif LOCAL.childList.recordcount>               
                
                    <!--- Child Nodes--->
                    <cfloop query="LOCAL.childList">             
                        <!--- Recursive Function --->                       
                        <cfset childNodes(locationId=LOCAL.childList.locationId, locationName=LOCAL.childList.locationName,parId=5) />
                    </cfloop>                
            </cfif>
        <cfloop index="i" from="1" to="#arguments.chId#" step="1">
           <cfoutput> #local.local_list[i]# </cfoutput>
        </cfloop>        
    </cffunction>

    <cffunction name="findDepth" access="public" output="true">
        <cfargument name="locationId" type="numeric" />
        <cfargument name="locationName" type="string" />
        <!--- Check for any nodes that have *this* node as a parent --->
        <cfquery name="LOCAL.childList" dbtype="query">
            select locationId, locationName
            from get_location
            where parentLocationId = <cfqueryparam value="#arguments.locationId#" cfsqltype="cf_sql_integer" />
        </cfquery>
        <cfset depth=1>
        
        <li>#arguments.locationName#
        #arguments.locationId#
        
            <cfif LOCAL.childList.recordcount>                
                <ul>
                    <!--- Child Nodes--->
                    <cfloop query="LOCAL.childList">                                      
                        <!--- Recursive Function --->                       
                        <cfset findDepth(locationId=LOCAL.childList.locationId, locationName=LOCAL.childList.locationName) />
                    </cfloop>
                </ul>
            </cfif>
        </li>        
    </cffunction>

</cfcomponent>