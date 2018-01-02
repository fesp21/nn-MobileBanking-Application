//
//  ManulifeTests.swift
//  ManulifeTests
//
//  Created by Najla on 2017-12-19.
//  Copyright © 2017 Manulife. All rights reserved.
//

import XCTest
@testable import Manulife

class ManulifeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //Mark: Manulife test
    
    func testAccountService(){
    
        let urlString : String = "https://raw.githubusercontent.com/seyDoggy/ml-app-challenge/master/data/listOfAccounts.json"
        let url = URL(string : urlString)
        var statusCode:Int?
        var responseError:Error?
        
        let dataTask =	URLSession.shared.dataTask(with: URLRequest(url:url!))
                        {(data, response,error) in
        
         statusCode = (response as! HTTPURLResponse).statusCode
         responseError = error
        
         XCTAssert(((responseError != nil)))
         XCTAssertEqual(statusCode, 200)
        }
        
        dataTask.resume()
        
    }
    
    func testTransactionsService(){
        
        let urlString : String = "https://raw.githubusercontent.com/seyDoggy/ml-app-challenge/master/data/accountTransactions.json"
        let url = URL(string : urlString)
        var statusCode:Int?
        var responseError:Error?
        
        let dataTask =	URLSession.shared.dataTask(with: URLRequest(url:url!))
        {(data, response,error) in
            
            statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200{
                XCTAssertEqual(statusCode, 200)
            }
            else
            {
                XCTFail("Status code:\(String(describing: statusCode))")
            }
            
            responseError = error
            
        }
        
        dataTask.resume()
        
    }
    
    
}
