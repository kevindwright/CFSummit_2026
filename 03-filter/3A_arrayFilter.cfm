// Our data: employee records from a DB query converted to array of structs
var employees = [
  { id:1, name:"Alice",   dept:"Engineering", active:true,  salary:95000 },
  { id:2, name:"Bob",     dept:"Marketing",   active:false, salary:72000 },
  { id:3, name:"Carol",   dept:"Engineering", active:true,  salary:110000 },
  { id:4, name:"David",   dept:"HR",          active:true,  salary:68000 },
  { id:5, name:"Eve",     dept:"Engineering", active:false, salary:88000 },
  { id:6, name:"Frank",   dept:"Marketing",   active:true,  salary:79000 }
];

// --- keep only active employees ---
var activeEmployees = [];                    // 1. create empty collection

for (var i = 1; i <= employees.len(); i++) { // 2. loop by index
  if (employees[i].active == true) {         // 3. test the condition
    activeEmployees.append(employees[i]);    // 4. manually push to collection
  }
}

var activeEmployees = employees.filter((emp) => emp.active);

// Only Engineering staff
var engineers = employees.filter((emp) => emp.dept == "Engineering");

// High earners (salary above threshold)
var highEarners = employees.filter((emp) => emp.salary >= 90000);

// Active AND in Engineering — compose conditions in one callback
var activeEngineers = employees.filter((emp) =>
  emp.active && emp.dept == "Engineering"
);