//

orders = getOrdersReport(); // 2 seconds
revenue = getRevenueReport(); // 2 seconds
customers = getCustomerStats(); // 3 seconds
// 7 seconds total

totalRevenue = 0;

for (r in revenue) {
    totalRevenue += r.amount;
}

writeOutput("Total Revenue: #totalRevenue#<br>");


// Run in parallel
cfthread(name="orders") {
    thread.orders = getOrdersReport();
}
cfthread(name="revenue") {
    thread.revenue = getRevenueReport();
}
cfthread(name="customers") {
    thread.customers = getCustomerStats();
}

// Wait for all threads
cfthread(action="join"); 
// 3 seconds total

// Functional aggregation
totalRevenue = revenue
    .map( r => r.amount )
    .reduce( ( runningTotal, revAmount ) => runningTotal + revAmount, 0 );


writeOutput("Total Revenue: #totalRevenue#<br>");