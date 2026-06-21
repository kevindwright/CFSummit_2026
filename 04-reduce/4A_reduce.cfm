
<cfset total = 0>
<cfloop array="#orders#" item="order">
    <cfif order.status EQ "completed">
        <cfset total += order.total>
    </cfif>
</cfloop>


<cfscript>
total = 0;
for (order in orders) {
    if (order.status EQ "completed") {
        total += order.total;
    }
}
</cfscript>




<cfscript>

    total = orders.reduce((sum, order) => {
        return order.status EQ "completed" ? sum + order.total: sum;
    }, 0);

</cfscript>