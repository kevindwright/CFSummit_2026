<cfquery name="qUsers" datasource="#application.dsn#">
    SELECT id, firstName, lastName, email
    FROM users
    WHERE active = <cfqueryparam value="#url.active#" cfsqltype="cf_sql_bit">
</cfquery>



<cfscript>
    users = queryExecute(
        "SELECT id, firstName, lastName, email FROM users WHERE active = :active",
        { active: { value: #url.active#, cfsqltype: "cf_sql_bit" } },
        { datasource: application.dsn }
    );
</cfscript>