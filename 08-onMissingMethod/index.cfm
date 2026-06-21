<cfscript>
/**
 * index.cfm
 * Demo page: run MathService through the LoggingDecorator.
 */

// 1. Create the real service
realService = new MathService();

// 2. Wrap it in the logging decorator.
//    The caller only ever talks to "service" from here on.
service = new LoggingDecorator(realService);

// 3. Call methods — the decorator intercepts every one via onMissingMethod
results = [];

calls = [
    { label: "add(3, 5)",        fn: function() { return service.add(3, 5); } },
    { label: "multiply(4, 7)",   fn: function() { return service.multiply(4, 7); } },
    { label: "subtract(10, 3)",  fn: function() { return service.subtract(10, 3); } },
    { label: "divide(20, 4)",    fn: function() { return service.divide(20, 4); } },
    { label: "divide(10, 0)",    fn: function() { return service.divide(10, 0); } }
];

for (call in calls) {
    try {
        r = call.fn();
        arrayAppend(results, { method: call.label, result: r,         ok: true });
    } catch (any e) {
        arrayAppend(results, { method: call.label, result: e.message, ok: false });
    }
}
</cfscript>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>ColdFusion Decorator Demo</title>
  <link rel="stylesheet" href="../css/demo.css">
</head>
<body>

<h1>onMissingMethod &mdash; Decorator Pattern</h1>
<p class="sub">MathService is called through LoggingDecorator. Check your ColdFusion logs for the full output.</p>

<div class="card">
  <h2>Method calls through the decorator</h2>
  <table>
    <tr><th>Call</th><th>Result</th><th>Status</th></tr>
    <cfoutput>
      <cfloop array="#results#" item="row">
        <tr>
          <td>#row.method#</td>
          <td>#row.result#</td>
          <td>
            <cfif row.ok>
              <span class="ok">&##10003; success</span>
            <cfelse>
              <span class="fail">&##10007; error caught &amp; logged</span>
            </cfif>
          </td>
        </tr>
      </cfloop>
    </cfoutput>
  </table>
  <p class="note">
    Every row above triggered <strong>onMissingMethod</strong> on LoggingDecorator.cfc.
    MathService.cfc has zero logging code of its own.
  </p>
</div>

<div class="card">
  <h2>How it works &mdash; the three steps inside onMissingMethod</h2>
  <pre>
// STEP 1 — log before
cflog(file="decorator_log", type="information",
      text="CALL  #missingMethodName#()  args=#argsJSON#");

// STEP 2 — forward to the real object using invoke()
result = invoke(variables.target, missingMethodName, missingMethodArguments);

// STEP 3 — log after (success or failure)
cflog(file="decorator_log", type="information",
      text="DONE  #missingMethodName#()  result=#result#  (#elapsed#ms)");

// on error:
cflog(file="decorator_log", type="error",
      text="FAIL  #missingMethodName#()  error=#e.message#");
rethrow;
  </pre>
</div>

<div class="card">
  <h2>Log file location</h2>
  <p style="font-size:.9rem; margin:0">
    Look for <code>decorator_log.log</code> in your ColdFusion logs directory
    (typically <code>{cf-install}/cfusion/logs/</code> on Adobe CF,
    or <code>{lucee-install}/logs/</code> on Lucee).
    Each method call writes two lines: a CALL entry and a DONE (or FAIL) entry.
  </p>
</div>

</body>
</html>
