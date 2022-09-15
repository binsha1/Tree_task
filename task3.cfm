<cfset parent_func=createObject('component', "components.tree_function")>
<cfset res=parent_func.printList()>
<h3>List In Alpabetical Order</h3>
<table>
    <thead>
        <tr>
            <th>Location Id</th>
            <th>Location Name</th>
            <th>Active </th>
            <th>Parent Location Id </th>
        </tr>        
    <thead>
    <tbody>
        <cfoutput query="res">     
            <tr>                   
                <td>#locationId#</td>
                <td>#locationName#</td>
                <td>#active#</td>
                <td>#parentLocationId#</td>           
            </tr>
        </cfoutput>
    </tbody>
</table>