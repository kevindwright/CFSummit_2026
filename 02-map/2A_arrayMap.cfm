

<cfset lineItems = [
  { id: 1, product: "Widget Pro",  qty: 3, unitPrice: 29.99 },
  { id: 2, product: "Gadget Max", qty: 1, unitPrice: 149.00 },
  { id: 3, product: "Doohickey",  qty: 5, unitPrice: 9.50  }
]>

<cfset labels = []><!--- 1. make a new collection --->

<cfloop index="i" from="1" to="#arrayLen(lineItems)#"><!--- 2. loop by index --->
  <cfset item  = lineItems[i]><!--- 3. extract item --->
  <cfset total = item.qty * item.unitPrice>
  <cfset arrayAppend(labels,
    "#item.product# x #item.qty# = $#numberFormat(total,'9.99')#"
  )><!--- 4. push into collection --->
</cfloop>

