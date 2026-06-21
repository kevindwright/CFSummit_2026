
// A function that returns another function

taxRate = 0.08; // captured by the closure below
prices = [ 10.00, 25.00, 4.50 ];

withTax = arrayMap( prices, function( price ) {
  return dollarFormat( price * ( 1 + taxRate ) ); // closes over taxRate
});

writeDump( withTax ); // [ "$10.80", "$27.00", "$4.86" ]

// 'Callback'
// Closures pair naturally with CFML's higher-order collection functions 
// Anywhere CFML accepts a function as an argument - Map(), Filter(), etc