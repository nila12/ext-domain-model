import XCTest
import SimpleDomainModel

class ExtDomainTests: XCTestCase {
    
    let tenUSD = Money(amount: 10, currency: "USD")
    let twelveUSD = Money(amount: 12, currency: "USD")
    let fiveGBP = Money(amount: 5, currency: "GBP")
    let fifteenEUR = Money(amount: 15, currency: "EUR")
    let fifteenCAN = Money(amount: 15, currency: "CAN")
    
    //Test Money desc
    func testMoneyDesc() {
        XCTAssert(tenUSD.description == "USD10")
        XCTAssert(twelveUSD.description == "USD12")
        XCTAssert(fiveGBP.description == "GBP5")
        XCTAssert(fifteenEUR.description == "EUR15")
        XCTAssert(fifteenCAN.description == "CAN15")
    }
    
    //Test Money desc when converting
    func testConvertMoneyDesc() {
        let USDtoGBP = tenUSD.convert("GBP")
        print("USDtoGBP: \(USDtoGBP)")
        XCTAssert(USDtoGBP.description == "GBP5")
        
        let CANtoUSD = fifteenCAN.convert("USD")
        XCTAssert(CANtoUSD.description == "USD12")
    }
    
    
    func testJobDescSalary() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.description == "Guest Lecturer, salary $1000")
        job.raise(1000.0)
        XCTAssert(job.description == "Guest Lecturer, salary $2000")
    }
    
    func testJobDescHourly() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.description == "Janitor, hourly $15.0")
    }
    
    let anne = Person(firstName: "Anne", lastName: "Foo", age: 21)
    
    func testPersonDesc() {
        anne.job = Job(title: "programmer", type: Job.JobType.Salary(1000))
        XCTAssert(anne.description == "Anne Foo is 21 years old and is employed as a programmer, salary $1000")
    }
    
    func testFamilyDesc() {
        let frank = Person(firstName: "Frank", lastName: "Foo", age: 21)
        let fam = Family(spouse1: frank, spouse2: anne)
        XCTAssert(fam.description == "Family members: Frank Foo is 21 years old and is unemployedAnne Foo is 21 years old and is unemployed\nHousehold income: $0")
    }
    
    //Tests double extension
    func testProtocolDoubleExt() {
        let tenUSD = 10.0.USD
        XCTAssert(tenUSD.amount == 10 && tenUSD.currency == "USD")
        let twentyUSD = 20.0.USD
        XCTAssert(twentyUSD.amount == 20 && twentyUSD.currency == "USD")
        
        let resultUSD = tenUSD.add(twentyUSD)
        XCTAssert(resultUSD.amount == 30 && resultUSD.currency == "USD")
        
        XCTAssert(tenUSD.amount == 10 && tenUSD.currency == "USD")
        let twentyGBP = 20.0.GBP
        XCTAssert(twentyGBP.amount == 20 && twentyGBP.currency == "GBP")
        
        let result = tenUSD.add(twentyGBP)
        XCTAssert(result.amount == 25 && result.currency == "GBP")
    
    }
    
}
