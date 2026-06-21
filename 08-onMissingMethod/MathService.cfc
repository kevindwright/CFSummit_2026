/**
 * MathService.cfc
 * The "real" service component 

 */
component displayname="MathService" hint="Simple math operations" {

    public numeric function add(required numeric a, required numeric b) {
        return arguments.a + arguments.b;
    }

    public numeric function multiply(required numeric a, required numeric b) {
        return arguments.a * arguments.b;
    }

    public numeric function subtract(required numeric a, required numeric b) {
        return arguments.a - arguments.b;
    }

    public numeric function divide(required numeric a, required numeric b) {
        if (arguments.b == 0) {
            throw(message="Division by zero is not allowed.",
                  type="MathService.DivisionByZero");
        }
        return arguments.a / arguments.b;
    }

}
