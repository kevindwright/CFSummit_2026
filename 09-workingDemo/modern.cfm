<cfscript>
    // ============================================================
    // Modern Functional CFML: map/filter/reduce + cfthread
    // Timed with getTickCount() to show total page processing time
    // ============================================================

    pageStartTicks = getTickCount();

    // Sample data: 3 batches of order amounts (some invalid/negative on purpose)
    batches = {
        storeA: [120, 45, -10, 300, 75],
        storeB: [200, -5, 60, 90],
        storeC: [15, 250, 130, -20, 40]
    };

    // Shared structure to collect results from each thread.
    results = {};

// Fire off one cfthread per batch — this is our concurrency layer.
    // each() is the right tool here: we're iterating for a side effect
    // (spawning a thread), not transforming values into a new array.
    batches.keyArray().each(function(batchName) {

        cfthread(
            action     = "run",
            name       = "thread_#batchName#",
            batchName  = batchName,
            orders     = batches[batchName]
        ) {

            // --- Functional pipeline runs INSIDE the thread ---

            // 1) FILTER: drop invalid (negative) orders
            validOrders = arrayFilter(attributes.orders, function(amount) {
                return amount > 0;
            });

            // 2) MAP: apply a 10% loyalty discount to each order
            discountedOrders = arrayMap(validOrders, function(amount) {
                return amount * 0.9;
            });

            // 3) REDUCE: sum the discounted orders into a batch total
            batchTotal = arrayReduce(discountedOrders, function(acc, amount) {
                return acc + amount;
            }, 0);


            /*
            // --- Functional chained pipeline ---

            batchTotal = attributes.orders
                .filter(function(amount) {
                    return amount > 0;
                })
                .map(function(amount) {
                    return amount * 0.9;
                })
                .reduce(function(acc, amount) {
                    return acc + amount;
                }, 0);

            */







            // Simulate some work / I/O latency per thread
            sleep(1000);

            // Write directly into the page's variables scope —
            // cfthread bodies can read/write the enclosing variables scope.
            variables.results[attributes.batchName] = {
                valid      : validOrders,
                discounted : discountedOrders,
                total      : batchTotal
            };
        }

    });



    // Wait for all threads to finish before continuing
    cfthread(action = "join", name = "thread_storeA,thread_storeB,thread_storeC", timeout = 5000);

    // --- Final REDUCE across all batch totals ---
    batchTotals = [];
    for (batchName in results) {
        arrayAppend(batchTotals, results[batchName].total);
    }

    grandTotal = arrayReduce(batchTotals, function(acc, total) {
        return acc + total;
    }, 0);

    pageEndTicks = getTickCount();
    totalProcessingMs = pageEndTicks - pageStartTicks;

</cfscript>

    <link rel="stylesheet" href="../css/demo.css">

    <h1>Functional CFML + CFThread()</h1>
    <div class="sub">array.filter() &middot; array.map() &middot; array.reduce() &middot; concurrent batch processing</div>

    <cfoutput>
        <cfloop collection="#results#" item="batchName">
            <div class="card">
                <h2>#batchName#</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Step</th>
                            <th>Result</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Valid orders <span class="ok">filter</span></td>
                            <td>#arrayToList(results[batchName].valid)#</td>
                        </tr>
                        <tr>
                            <td>After 10% discount <span class="ok">map</span></td>
                            <td>#arrayToList(results[batchName].discounted, ", ")#</td>
                        </tr>
                        <tr>
                            <td>Batch total <span class="ok">reduce</span></td>
                            <td>#numberFormat(results[batchName].total, "0.00")#</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </cfloop>

        <div class="card">
            <h2>Grand Total</h2>
            <div>reduce(batchTotals) => #numberFormat(grandTotal, "0.00")#</div>
            <div class="note">
                Computed by reducing each batch's <code>reduce()</code> output across all
                <code>cfthread</code> threads — a reduce of reduces.
            </div>
        </div>

        <div class="card">
            <h2>Performance</h2>
            <table>
                <tbody>
                    <tr>
                        <td>Total page processing time</td>
                        <td><span class="ok time">#totalProcessingMs# ms</span></td>
                    </tr>
                </tbody>
            </table>
            <div class="note">
                Three batches each <code>sleep(1000)</code> inside their own thread.
                Because they run concurrently via <code>cfthread</code>, total time stays
                near 1000&ndash;1100ms instead of stacking to ~3000ms.
            </div>
        </div>
    </cfoutput>
