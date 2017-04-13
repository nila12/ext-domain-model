//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

////////////////////////////////////
// Money
//
public struct Money {
    public var amount : Int
    public var currency : String
    
    public func convert(_ to: String) -> Money {
        
        switch to {
            
        case self.currency : // works because swift automatically breaks out of the statement when a matching case is met
            return self;
            
        case "USD" : //converting to USD
            
            switch self.currency {
                
            case "GBP" : // 1 GBP to 2 USD
                
                return Money(amount: self.amount * 2, currency: "USD")
                
            case "EUR" : // 3 EUR to 2 USD
                
                return Money(amount: (self.amount * 2) / 3, currency: "USD")
                
            case "CAN" :  // 5 CAN to 4 USD
                
                return Money(amount: (self.amount * 4) / 5, currency: "USD")
                
            default : //since USD case dealt by the very first case
                print ("Invalid exchange currency inputted, no conversion conducted")
                return self;
            }
            
        case "GBP" : //converting to GBP
            
            switch self.currency {
                
            case "USD" : // 2 USD to 1 GBP
                
                return Money(amount: self.amount / 2, currency: "GBP")
                
            case "EUR" : // 3 EUR to 1 GBP
                
                return Money(amount: self.amount / 3, currency: "GBP")
                
            case "CAN" : // 5 CAN to 2 GBP
                
                return Money(amount: (self.amount / 5) * 2, currency: "GBP")
                
            default : //since GBP case dealt by the very first case
                print ("Invalid exchange currency inputted, no conversion conducted")
                return self;
            }
            
        case "EUR" : // converting to EUR
            
            switch self.currency {
                
            case "USD" : // 2 USD to 3 EUR
                
                return Money(amount: (self.amount / 2) * 3, currency: "EUR")
                
            case "GBP" : // 1 GBP to 3 EUR
                
                return Money(amount: self.amount * 3, currency: "EUR")
                
            case "CAN" : //  5 CAN to 6 EUR
                
                return Money(amount: (self.amount / 5) * 6, currency: "EUR")
                
            default : //since GBP case dealt by the very first case
                print ("Invalid exchange currency inputted, no conversion conducted")
                return self;
            }
            
        case "CAN" : // converting to CAN
            
            switch self.currency {
                
            case "USD" : // 4 USD to 5 CAN
                
                return Money(amount: (self.amount / 4) * 5, currency: "CAN")
                
            case "GBP" : // 2 GBP to 5 CAN
                
                return Money(amount: (self.amount / 2) * 5, currency: "CAN")
                
            case "EUR" : // 6 EUR to 5 CAN
                
                return Money(amount: (self.amount / 6) * 5, currency: "CAN")
                
            default : //since GBP case dealt by the very first case
                print ("Invalid exchange currency inputted, no conversion conducted")
                return self;
            }
            
        default :
            print ("Invalid exchange currency inputted, no conversion conducted")
            return self;
        }
        
    }
    
    public func add(_ to: Money) -> Money {
        
        return Money(amount: (self.convert(to.currency)).amount + to.amount, currency: to.currency)
    }
    
    public func subtract(_ from: Money) -> Money {
        
        return Money(amount: (self.convert(from.currency)).amount - from.amount, currency: from.currency)
        
    }
}

////////////////////////////////////
// Job
//

open class Job {
    fileprivate var title : String
    fileprivate var type : JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int) //per-year
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    open func calculateIncome(_ hours: Int) -> Int {
        
        switch type {
            
        case .Hourly(let pay):
            return Int(Double(hours) * pay);
        case .Salary(let salary):
            return salary;
            
        }
    }
    
    open func raise(_ amt : Double) {
        
        switch type {
        case .Hourly(let pay):
            type = JobType.Hourly(amt + pay)
        case .Salary(let salary):
            type = JobType.Salary(Int(amt) + salary)
        }
    }
}

////////////////////////////////////
// Person
//
open class Person {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get {
            return _job
        }
        
        set(value) {
            if (age >= 16) {
                _job = value
            }
        }
    }
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get {
            return _spouse
        }
        set(value) {
            if (age >= 18) {
                _spouse = value
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    open func toString() -> String {
        return ("[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(_job) spouse:\(_spouse)]")
    }
}

////////////////////////////////////
// Family
//
open class Family {
    fileprivate var members : [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        if (spouse1._spouse == nil && spouse2._spouse == nil) {
            spouse1._spouse = spouse2
            spouse2._spouse = spouse1
        }
        members.append(spouse1)
        members.append(spouse2)
    }
    
    open func haveChild(_ child: Person) -> Bool {
        members.append(child)
        return true
    }
    
    open func householdIncome() -> Int {
        var sum = 0
        
        for person in members {
            if (person.job != nil) {
                sum += (person.job?.calculateIncome(2000))!
            }
            
        }
        return sum

    }
}





