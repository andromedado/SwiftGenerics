//
/**
 * GENERIC FUNCTIONS
 */

//The canonical example
func swap<T>(inout a: T, inout b: T) {
    let tmp : T = a
    a = b
    b = tmp
}

func needlesslyGeneric<T>(a: Int, b: Int) -> Int {
    return a
}

//Returned generic type - compiller can't figure it out
//func doTheThing<T>(a: Int, b: Int) -> T {
//    return 88
//}

/**
 * GENERIC TYPES
 */

var foo = Optional<Int>.Some(10)

var bar = Optional.Some(10)

//var baz = Optional<Float>.Some(10)
//var baz = Optional.Some(Float(10))
//var baz : Float? = Optional.Some(10)
var baz : Float? = 10

class Thing<T> {
    var fizz : T

    init(_ fizz: T) {
        self.fizz = fizz
    }
}

let aThing = Thing(5)
let bThing = Thing<Float>(5)

//if (aThing.fizz == bThing.fizz) {
//    println("THey have the same fizz")
//}


func veryPickyFunction<T where T : Equatable, T : Comparable, T : SequenceType>(doStuff: T) {
    //
}

//veryPickyFunction([5, 6])


class FailingMotel<T> {
    let numRooms : Int
    var guests : [T] = []

    init (_ numRooms : Int) {
        self.numRooms = numRooms
    }

    func checkIn(guest : T) -> Bool {
        if (numRooms <= self.guests.count) {
            return false
        }
        self.guests.append(guest)
        return true
    }

    /**
     You can checkin, but you can never checkout....
    */
    func checkOut(guest : T) -> Bool {
//        if (contains(self.guests, guest)) {
//            //remove?
//            return true
//        }
        return false
    }
}

































class Motel<T : Equatable> {
    let numRooms : Int
    var guests : [T] = []

    init (_ numRooms : Int) {
        self.numRooms = numRooms
    }

    func canAccomodate(guest : T) -> Bool {
        return numRooms > self.guests.count
    }

    func checkIn(guest : T) -> Bool {
        if (!self.canAccomodate(guest)) {
            return false
        }
        self.guests.append(guest)
        return true
    }

    func checkOut(guest : T) -> Bool {
        if (contains(self.guests, guest)) {
            remove(guest, &self.guests)
            return true
        }
        return false
    }
}



func remove<T : Equatable>(what: T, inout fromWhat:[T]) {
    for i in 0..<fromWhat.count {
        let foo = fromWhat[i]
        if (foo == what) {
            fromWhat.removeAtIndex(i)
            return
        }
    }
}


class Roach : Equatable {
    let name : String
    init (_ name : String) {
        self.name = name
    }
}

func == (lhs: Roach, rhs: Roach) -> Bool {
    return lhs.name == rhs.name
}


//let JillsMotel = Motel(100)
let JoesMotel = Motel<Roach>(2)
let Bob = Roach("Bob")
let Richard = Roach("Richard")
let Harry = Roach("Harry")
JoesMotel.checkIn(Bob)
JoesMotel.checkIn(Richard)
JoesMotel.checkIn(Harry)

JoesMotel.checkOut(Harry)
JoesMotel.checkOut(Bob)
JoesMotel.checkOut(Richard)
JoesMotel.checkIn(Harry)



let JanesMotel = Motel<Roach>(10)

func transferGuests<T>(fromMotel : Motel<T>, toMotel: Motel<T>) {
    for (_, guest) in enumerate(fromMotel.guests) {
        if (toMotel.checkIn(guest)) {
            fromMotel.checkOut(guest)
        }
    }
}

transferGuests(JoesMotel, JanesMotel)

JanesMotel.guests

let JohnsMotel = Motel<Int>(256)

//transferGuests(JanesMotel, JohnsMotel)
//Won't work

















protocol ProvidesLodging {
    typealias FoodProvided
    typealias GuestType
    func checkIn(guest : GuestType) -> Bool
    func checkOut(guest : GuestType) -> Bool
}

class BedAndBreakfast<T, Q where T : Equatable, T: EatsSomething> : Motel<T>, ProvidesLodging {
    typealias FoodProvided = Q

    override init(_ numRooms: Int) {
        super.init(numRooms)
    }

}

protocol EatsSomething {
    typealias WhatIEat
}

class HungryRoach<T> : Roach, EatsSomething {
    typealias WhatIEat = T
    override init(_ name: String) {
        super.init(name)
    }
}

class RedRoach<T : SignedNumberType> : HungryRoach<T> {
    override init(_ name: String) {
        super.init(name)
    }
}

class GreenRoach<T : Equatable> : HungryRoach<T> {
    override init(_ name: String) {
        super.init(name)
    }
}

class BlueRoach<T> : HungryRoach<T> {
    override init(_ name: String) {
        super.init(name)
    }
}

let MurielsBNB = BedAndBreakfast<HungryRoach<String>, String>(3)

func carefulBooking<
    R : EatsSomething, T : ProvidesLodging
    where T.GuestType == R, T.FoodProvided == R.WhatIEat
    >(guest: R, lodging : T) -> Bool {
    return lodging.checkIn(guest)
}

let Huey = RedRoach<Int>("Huey")
let Duey = GreenRoach<String>("Duey")
let Luey = BlueRoach<String>("Luey")

//carefulBooking(Huey, MurielsBNB)
carefulBooking(Duey, MurielsBNB)
carefulBooking(Luey, MurielsBNB)


MurielsBNB.guests

//MurielsBNB.checkIn(huey)

MurielsBNB.guests















protocol HasEquivalents {
    func isEquivalent(compareWith: Self) -> Bool
}

func containsEquivalent<T : HasEquivalents>(group: [T], searchElement: T) -> Bool {
    return reduce(group, false) { (curVal, element) -> Bool in
        return curVal || element.isEquivalent(searchElement)
    }
}

extension HungryRoach : HasEquivalents {
    func isEquivalent(compareWith: HungryRoach) -> Bool {
        return self.name.lowercaseString == compareWith.name.lowercaseString
    }
}


let luey = BlueRoach<String>("luey")

if (luey == Luey) {
    println("They are equal")
} else {
    println("They are not equal")
}

if (luey.isEquivalent(Luey)) {
    println("They are equivalent")
}



