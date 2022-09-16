<cfset parent_func=createObject('component', "components.tree_function")>
<cfset parent_loc=parent_func.getLocation()>
<cfset locationId=5>
<cfset depth=0>
<cfset res=parent_func.findDepth(locationId,depth) >
      
