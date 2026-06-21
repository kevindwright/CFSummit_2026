<cfscript>
    salesTotal = 0;
    orderCount = 0;

    for( order in orders ) {
        salesTotal += order.total;
        orderCount++;
    }

    averageOrder = salesTotal / orderCount;
</cfscript>



<cfscript>

metrics = orders.reduce(
    function( result, order ) {

        //allows us to perform all of these calculations in a single pass.
        result.total += order.total;
        result.count++;

        return result;
    },
    {
        total = 0,
        count = 0
    }
);

metrics.average = metrics.total / metrics.count;

</cfscript>