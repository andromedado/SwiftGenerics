//
//  ViewController.swift
//  SwiftGenerics
//
//  Created by Shad Downey on 4/23/15.
//  Copyright (c) 2015 com.shad.swiftGenerics. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var table : UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        println("viewDidLoad!")

        var foooo : [String] = ["a", "b", "c"]
        foooo.append("hi")

        var bug = Optional<Int>.None
        bug = 6
//        bug = "hi"

        var foo = Promise<Int, Int>(executor:{ (good, bad) in
            good(5)
        })
        var bar = foo.then { (someInt) -> Promise<String, Int> in
            var foo = Promise<String, Int>(executor:{ (good, bad) in
                good("dd")
            })
            return foo
        }

        bar.then { (someStr) -> () in
            println(someStr)
        }

    }

}

//class Motel<T> {
//    let numRooms : Int
//    var guests : [T] = []
//
//    init (_ numRooms : Int) {
//        self.numRooms = numRooms
//    }
//
//    func checkIn(guest : T) -> Bool {
//        if (numRooms <= self.guests.count) {
//            return false
//        }
//        self.guests.append(guest)
//        return true
//    }
//
//    func checkOut(guest : T) -> Bool {
//        if (contains(self.guests, guest)) {
//            //remove?
//            return true
//        }
//        return false
//    }
//}
