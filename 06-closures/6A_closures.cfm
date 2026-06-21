
// A function that returns another function
function makeGreeter( required string greeting ) {
  return function( required string name ) {
    // 'greeting' is captured from the outer scope ← closure
    return "#greeting#, #name#!";
  };
}

helloGreeter = makeGreeter( "Hello" );
holaGreeter = makeGreeter( "Hola" );

writeOutput( helloGreeter( "Alice" ) ); // Hello, Alice!
writeOutput( holaGreeter( "Bob" ) ); // Hola, Bob!

// 'captured scope'
// The inner function closes over the variable 'greeting' from its enclosing scope,
// that variable is "remembered" even after makeGreeter() returns.