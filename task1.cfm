<cfset parent_func=createObject('component', "components.tree_function")>
<cfset parent_loc=parent_func.getLocation()>
<ul class="tree">
    <cfloop query="parent_loc">
        <cfset parent_func.buildTree(locationId=parent_loc.locationId, locationName=parent_loc.locationName) >
    </cfloop>
</ul>


