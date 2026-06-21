

// Legacy
<cfif age GTE 18>
    <cfset label = "Adult">
<cfelse>
    <cfset label = "Minor">
</cfif>


// Modern
<cfscript>

    label = age >= 18 ? "Adult" : "Minor";
    
</cfscript>

//  Elvis vs ternary — they share the same symbol

//  a ?: b — Elvis: returns a if truthy, else b
//  condition ? a : b — Ternary: evaluates condition, picks branch

//  They're the same operator — context determines which form you're using.