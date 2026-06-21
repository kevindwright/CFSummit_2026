component {
    // Application Settings
    this.name = "CFSummit Demo"; // Unique name for the application
    this.applicationTimeout = createTimeSpan(30, 0, 0, 0); // 30 days
    this.sessionManagement = true; // Enables session variables
    this.sessionTimeout = createTimeSpan(0, 0, 60, 0); // 1 hour
    this.DSN = "CFSummit"; // Default datasource for queries

    function onApplicationStart() {
        application.version = "1.0.0";
        return true; 
    }

    function onRequestStart(string targetPage) {
        if (structKeyExists(url, "reinit")) {
            onApplicationStart();
        }
    }

    function onRequest(string targetPage) {
        include arguments.targetPage;
    }

    function onError(any exception, string eventName) {
        writeOutput("<h2>An error occurred.</h2>");
        // Log the exception details here
    }

    function onMissingTemplate(required string targetPage) {
        location(url="/404.cfm", addToken=false);
    }
}