/**
 * LoggingDecorator.cfc
 * A generic logging decorator using onMissingMethod.
 *
 * HOW IT WORKS:
 *   1. Pass any CFC into init()
 *   2. This decorator stores it as variables.target
 *   3. When you call ANY method on this decorator,
 *      ColdFusion can't find it here, so it fires onMissingMethod
 *   4. onMissingMethod logs the call, delegates to the real object,
 *      then logs the result — all transparently.
 *
 * KEY IDEA: The wrapped component (MathService) is NEVER modified.
 */
component displayname="LoggingDecorator"
          hint="Wraps any CFC to add automatic method-call logging" {

    /**
     * Store the real object we are decorating.
     */
    public LoggingDecorator function init(required any targetObject) {
        variables.target  = arguments.targetObject;
        variables.logFile = "decorator_log";
        return this;
    }

    /**
     * onMissingMethod
     * ================
     * ColdFusion calls this automatically when the caller invokes
     * a method that does not exist on THIS component.
     *
     * @missingMethodName      The name of the method that was called.
     * @missingMethodArguments A struct of the arguments that were passed.
     */
    
    public any function onMissingMethod(
        required string missingMethodName,
        required struct missingMethodArguments
    ) {
        var result    = "";
        var startTime = getTickCount();
        var argsJSON  = serializeJSON(arguments.missingMethodArguments);

        // STEP 1: Log BEFORE the call
        cflog(
            file = variables.logFile,
            type = "information",
            text = "CALL  #arguments.missingMethodName#()  args=#argsJSON#"
        );

        // STEP 2: Forward to the real object, catching any errors
        try {
            result = invoke(
                variables.target,
                arguments.missingMethodName,
                arguments.missingMethodArguments
            );

            // STEP 3: Log AFTER a successful call
            var elapsed = getTickCount() - startTime;
            cflog(
                file = variables.logFile,
                type = "information",
                text = "DONE  #arguments.missingMethodName#()  result=#result#  (#elapsed#ms)"
            );

        } catch (any e) {
            // Log errors too, then re-throw so the caller still sees them
            cflog(
                file = variables.logFile,
                type = "error",
                text = "FAIL  #arguments.missingMethodName#()  error=#e.message#"
            );
            rethrow;
        }

        return result;
    }

}
