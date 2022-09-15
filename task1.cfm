<!---<cfquery name="get_location" >
    select locationId,locationName,active,parentLocationId
    from location_list.locations    
</cfquery>

<cfquery name="get_parent_location" dbtype="query">
    select locationId, locationName,parentLocationId
    from get_location
    where parentLocationId is null
</cfquery>

<ul class="tree">
    <cfloop query="get_parent_location">
        <cfset buildTree(locationId=get_parent_location.locationId, locationName=get_parent_location.locationName) />
    </cfloop>
</ul>---->

<cfset parent_func=createObject('component', "components.tree_function")>
<cfset parent_loc=parent_func.getLocation()>
<ul class="tree">
    <cfloop query="parent_loc">
        <cfset parent_func.buildTree(locationId=parent_loc.locationId, locationName=parent_loc.locationName) />
    </cfloop>
</ul>
<!----
<cffunction name="buildTree" output="true">
    <cfargument name="locationId" type="numeric" />
    <cfargument name="locationName" type="string" />
    <!--- Check for any nodes that have *this* node as a parent --->
    <cfquery name="LOCAL.qFindChildren" dbtype="query">
        select locationId, locationName
        from get_location
        where parentLocationId = <cfqueryparam value="#arguments.locationId#" cfsqltype="cf_sql_integer" />
    </cfquery>
    <li>#arguments.locationName#
        <cfif LOCAL.qFindChildren.recordcount>
            <!--- We have another list! --->
            <ul>
                <!--- We have children, so process these first --->
                <cfloop query="LOCAL.qFindChildren">
                    <!--- Recursively call function --->
                    <cfset buildTree(locationId=LOCAL.qFindChildren.locationId, locationName=LOCAL.qFindChildren.locationName) />
                </cfloop>
            </ul>
        </cfif>
    </li>
</cffunction>---->

