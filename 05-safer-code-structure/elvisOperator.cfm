

<cfif isDefined("user.name") AND len(user.name)>
    <cfset displayName = user.name>
<cfelse>
    <cfset displayName = "Guest">
</cfif>

<cfscript>

    if (structKeyExists(user, "name")) {
        displayName = user.name;
    } else {
        displayName = "Guest";
    }

</cfscript>


<cfscript>

    displayName = user.name ?: "Guest";
    //Elvis operator returns the left side if truthy, otherwise the right side
</cfscript>

