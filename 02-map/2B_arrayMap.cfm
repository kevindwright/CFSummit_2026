
// Setup: array of structs 
var lineItems = [
  { id: 1, product: "Widget Pro",  qty: 3, unitPrice: 29.99 },
  { id: 2, product: "Gadget Max", qty: 1, unitPrice: 149.00 },
  { id: 3, product: "Doohickey",  qty: 5, unitPrice: 9.50  }
];

var labels = [];                                // 1. make a new collection

for (var i = 1; i <= lineItems.len(); i++) {    // 2. loop by index
  var item  = lineItems[i];                     // 3. extract item
  var total = item.qty * item.unitPrice;
  labels.append(                                // 4. push into collection
    "#item.product# x #item.qty# = $#numberFormat(total,'9.99')#"
  );
}


var labels2 = lineItems.map((item) => {
  return "#item.product# x #item.qty# = $#numberFormat(item.qty*item.unitPrice,'9.99')#";
});
