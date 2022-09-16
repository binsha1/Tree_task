<cfset parent_func=createObject('component', "components.tree_function")>
<cfset res=parent_func.printList()>
<ul class="tree">
    <cfloop query="res">
        <cfset parent_func.sortTree(locationId=res.locationId, locationName=res.locationName) />
    </cfloop>
</ul>
