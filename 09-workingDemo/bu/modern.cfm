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

    //writeDump(batches);
    //abort;

    // Shared structure to collect results from each thread.
    results = {};

    // Fire off one cfthread per batch — this is our concurrency layer.
    for (batchName in batches) {

        // writeDump("thread_#batchName#");
        // writeDump(batchName);
        // writeDump(batches[batchName]);


        cfthread(
            action     = "run",
            name       = "thread_#batchName#",
            batchName  = batchName,
            orders     = batches[batchName],
            resultsRef = results
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

            // Simulate some work / I/O latency per thread
            sleep(1000);

            // Store this thread's result in the shared struct
            attributes.resultsRef[attributes.batchName] = {
                valid      : validOrders,
                discounted : discountedOrders,
                total      : batchTotal
            };

        writeDump(validOrders);
        writeDump(discountedOrders);
        writeDump(batchTotal);

        }
        
    }

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

    // ============================================================
    // Output
    // ============================================================
    writeOutput("<h2>Functional CFML + CFThread()</h2>");

    for (batchName in results) {
        writeOutput("<h3>#batchName#</h3>");
        writeOutput("Valid orders: #arrayToList(results[batchName].valid)#<br>");
        writeOutput("After 10% discount (map): #arrayToList(results[batchName].discounted)#<br>");
        writeOutput("Batch total (reduce): #numberFormat(results[batchName].total, '0.00')#<br><br>");
    }

    writeOutput("<h3>Grand Total (reduce across threads)</h3>");
    writeOutput("<strong>#numberFormat(grandTotal, '0.00')#</strong><br><br>");

    writeOutput("<h3>Performance</h3>");
    writeOutput("Total page processing time: <strong>#totalProcessingMs# ms</strong>");
</cfscript>