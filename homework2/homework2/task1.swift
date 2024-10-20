import Foundation

class Apartment {
    let number: Int
    weak var tenant: Person?
    
    init(number: Int) {
        self.number = number
    }
    
    func getInfo() {
        print("Apartment \(number) hosting \(tenant?.name.description ?? "empty")")
    }
    
    deinit {
        print("Apartment deinitialized")
    }
}

class Person {
    let name: String
    var apartment: Apartment?
    
    init(name: String) {
        self.name = name
    }
    
    func setupApartment(_ apartment: Apartment) {
        self.apartment = apartment
    }
    
    func getInfo() {
        print("Person \(name) is in Apartment \(apartment?.number.description ?? "empty")")
    }
    
    deinit {
        print("Person deinitialized")
    }
}

func executionTask1() {
    print("Task 1.")
    var person: Person? = Person(name: "kseniia")

    person?.setupApartment(Apartment(number: 42))

    person?.apartment?.tenant = person
    person?.getInfo()
    person?.apartment?.getInfo()

    person = nil
    print("\n")
}


// It is prohibited to use unowned for objects for which we are not sure that nil is not going to happen, as it can lead to runtime crashes. In this case, if we convert object Person to unowned reference, when we set person to nil, the apartment would still try to getInfo of the tenant which is nil. Meanwhile, weak reference is safer, as it fixes the retain cycle of strong references between those objects, automatically sets apartment to nil and deinitializes those objects. The output now prints out the deinitialization messages for both Person and Apartment.

// The output:
// Person kseniia is in Apartment 42
// Apartment 42 hosting kseniia
// Person deinitialized
// Apartment deinitialized
