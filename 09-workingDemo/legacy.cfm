<cfscript>
    // ============================================================
    // Legacy CFML
    // ============================================================

    pageStartTicks = getTickCount();

    // Sample data: 3 batches of order amounts (some invalid/negative on purpose)
    batches = {
        storeA: [120, 45, -10, 300, 75],
        storeB: [200, -5, 60, 90],
        storeC: [15, 250, 130, -20, 40]
    };

    // Create structure to collect results
    results = {};

    // Process each batch one at a time, in order
    for (batchName in batches) {

        orders = batches[batchName];

        // --- Manual loop pipeline runs INLINE, sequentially ---

        // 1) "FILTER" by hand: loop through, check condition, append if valid
        validOrders = [];
        for (i = 1; i lte arrayLen(orders); i = i + 1) {
            amount = orders[i];
            if (amount > 0) {
                arrayAppend(validOrders, amount);
            }
        }

        // 2) "MAP" by hand: loop through, transform, build new array
        discountedOrders = [];
        for (i = 1; i lte arrayLen(validOrders); i = i + 1) {
            arrayAppend(discountedOrders, validOrders[i] * 0.9);
        }

        // 3) "REDUCE" by hand: loop through, accumulate into a single variable
        batchTotal = 0;
        for (i = 1; i lte arrayLen(discountedOrders); i = i + 1) {
            batchTotal = batchTotal + discountedOrders[i];
        }

        // Simulate some work / I/O latency per batch
        sleep(1000);

        // Store this batch's result
        results[batchName] = {
            valid      : validOrders,
            discounted : discountedOrders,
            total      : batchTotal
        };
    }

    // --- Final "reduce" across all batch totals---
    grandTotal = 0;
    for (batchName in results) {
        grandTotal = grandTotal + results[batchName].total;
    }

    pageEndTicks = getTickCount();
    totalProcessingMs = pageEndTicks - pageStartTicks;

    for (batchName in results) {

        // building a display list
        validList = "";
        for (i = 1; i lte arrayLen(results[batchName].valid); i = i + 1) {
            validList = validList & results[batchName].valid[i];
            if (i lt arrayLen(results[batchName].valid)) {
                validList = validList & ", ";
            }
        }

        discountedList = "";
        for (i = 1; i lte arrayLen(results[batchName].discounted); i = i + 1) {
            discountedList = discountedList & numberFormat(results[batchName].discounted[i], "0.00");
            if (i lt arrayLen(results[batchName].discounted)) {
                discountedList = discountedList & ", ";
            }
        }
    }

</cfscript>

    <link rel="stylesheet" href="../css/demo.css">

    <h1>Legacy CFML</h1>
    <div class="sub">manual looping</div>

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
                            <td width="50%">Valid orders <span class="ok">Manual Loop</span></td>
                            <td width="50%">#arrayToList(results[batchName].valid)#</td>
                        </tr>
                        <tr>
                            <td width="50%">After 10% discount <span class="ok">Manual Loop</span></td>
                            <td width="50%">#arrayToList(results[batchName].discounted, ", ")#</td>
                        </tr>
                        <tr>
                            <td width="50%">Batch total <span class="ok">Manual Loop</span></td>
                            <td width="50%">#numberFormat(results[batchName].total, "0.00")#</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </cfloop>

        <div class="card">
            <h2>Grand Total</h2>
            <div>#numberFormat(grandTotal, "0.00")#</div>
            <div class="note">
                Manually calculated
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
                They run sequentialy, stacking to ~3000ms.
            </div>
        </div>
    </cfoutput>