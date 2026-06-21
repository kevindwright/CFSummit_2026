
// A function that returns another function

function makeCounter( numeric startAt = 0 ) {
  local.count = startAt; // private state

  return {
    increment: function() { local.count++; },
    decrement: function() { local.count--; },
    value: function() { return local.count; }
  };
}

counter = makeCounter( 10 );
counter.increment();
counter.increment();
writeOutput( counter.value() ); // 12
counter.decrement();
writeOutput( counter.value() ); // 11

// 'Encapsulated scope'
// Closures can hold mutable state privately. 
// Here, count is inaccessible from the outside — only the returned functions can touch it.