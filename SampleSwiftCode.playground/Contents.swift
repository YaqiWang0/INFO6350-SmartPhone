import Cocoa

var str = "Hello, playground"
var intValue = 5;
let name = "Mihir";
print("Value \(intValue)");

//let constInt = 10; //Cannot assign to value: 'constInt' is a 'let' constant


var varName : Int? // optional value

varName = 34

var names : [String] = ["Ashish", "Tom", "Peter", "Mark"]


print(names[0]);
print(names[1]);
print(names[2]);
print(names[3]);

names.append("Vidya");
names[4];

var names1 = [String]()
names1.append("Ashshi");
names1.append("Emma");

print(names1);

for namePer in names1 {
    print(namePer)
}

//while loop
var n = 0
while(n < 10) {
    print("N = \(n)")
    n = n + 1
}

for i in 0..<10 {
    print(i);
}

for i in 0...10 { // include 10
    print(i);
}

func printMyName(_ name : String, city : String) -> Int {
    print("Hello \(name), how is the weather in \(city)");
    return 0;
}


printMyName("Ashish", city : "Seattle");
//let userId: firstName = (1: "Ashshi");
//
//print(userId)
//print(firstName);
//print("Value \(varName)");

class Employee{
    var firstName : String?;
    var lastName : String?;
    var id : Int = -1;
    var designation : String?
    
    init(firstName : String, lastName : String, id : Int, designation : String) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.designation = designation;
        self.id = id;
    }
}

var ashish = Employee(firstName: "Ashish", lastName: "singh", id: 55, designation: "Instructor");

print(ashish.firstName);

var test = 5;
if test < 10 {
    
}
