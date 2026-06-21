
// Legacy — verbose deeply nested null guards
<cfscript>

    if ( isDefined("order") 
    && isObject(order.customer) 
    && isDefined("order.customer.address") ) {
        city = order.customer.address.city;
    } else {
        city = "Unknown";
    }

</cfscript>


<cfscript>

    city = order?.customer?.address?.city ?: "Unknown";

</cfscript>
    //One line. Reads like plain English. 
    //If any link in the chain is null, the whole expression returns null, and the Elvis operator catches it.
