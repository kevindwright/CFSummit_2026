
// Our data: employee records from a DB query converted to array of structs
var employees = [
  { id:1, name:"Alice",   dept:"Engineering", active:true,  salary:95000 },
  { id:2, name:"Bob",     dept:"Marketing",   active:false, salary:72000 },
  { id:3, name:"Carol",   dept:"Engineering", active:true,  salary:110000 },
  { id:4, name:"David",   dept:"HR",          active:true,  salary:68000 },
  { id:5, name:"Eve",     dept:"Engineering", active:false, salary:88000 },
  { id:6, name:"Frank",   dept:"Marketing",   active:true,  salary:79000 }
];


// Reusable named predicates — cleaner for complex rules
function isActive(emp,isActive)      { return emp.active == isActive; }
function isMember(emp, dept)    { return emp.dept == dept; }
function isHighEarner(emp, threshold)  { return emp.salary >= threshhold; }

// Now compose them clearly in a pipeline — reads like a sentence
var seniorEngineers = employees
  .filter(isActive, true)
  .filter(isMember, "Engineering")
  .filter(isHighEarner, 90000)
  .map((emp) => emp.name);

  // seniorEngineers = ["Alice", "Carol"]