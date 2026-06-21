
component output=false {
    property name='DSN' inject='coldbox:setting:appDSN';

    // ##############################################################
    // init
    // ##############################################################
    function init() {
        return this;
    }

    // ##############################################################
    // getAllPatients
    // ##############################################################
    remote query function getAllPatients(required numeric practiceID) output=false hint="returns a query of patients" {

        //cfsetting(showDebugOutput = "no");

        // Get all patients
        qryPatients=QueryExecute(
            "SELECT * FROM tblPatients where practiceID = CASE ? WHEN 1 THEN practiceID ELSE ? END",
            [{ value = session.isAdmin, cfsqltype = "cf_sql_integer" }, 
            { value = arguments.practiceID, cfsqltype = "cf_sql_integer" } ],
            {datasource="DSN"});

        return qryPatients;
    }

}