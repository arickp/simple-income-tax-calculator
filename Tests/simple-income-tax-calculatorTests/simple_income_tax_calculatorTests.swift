//
//  simple_income_tax_calculatorTests.swift
//  simple-income-tax-calculatorTests
//
//  Created by Eric Popelka on 10/15/25.
//

import XCTest
@testable import simple_income_tax_calculator

final class simple_income_tax_calculatorTests: XCTestCase {

    var taxConfig: TaxConfig!

    override func setUpWithError() throws {
        // Load the tax configuration for testing
        taxConfig = try loadConfig()
    }

    override func tearDownWithError() throws {
        taxConfig = nil
    }

    // MARK: - Specific Test Cases from Requirements
    
    func testIncome35000Tax3780() throws {
        // Given: income of $35,000
        let income = 35000
        let expectedTax = Decimal(3780)
        
        // When: computing tax
        let actualTax = try computeTaxOwed(income: income, config: taxConfig)
        
        // Then: tax should be $3,780
        XCTAssertEqual(actualTax, expectedTax, "Tax for income $35,000 should be $3,780")
    }
    
    func testIncome100000Tax23700() throws {
        // Given: income of $100,000
        let income = 100000
        let expectedTax = Decimal(23700)
        
        // When: computing tax
        let actualTax = try computeTaxOwed(income: income, config: taxConfig)
        
        // Then: tax should be $23,700
        XCTAssertEqual(actualTax, expectedTax, "Tax for income $100,000 should be $23,700")
    }
    
    func testNegativeIncomeThrowsError() throws {
        // Given: negative income
        let income = -1
        
        // When/Then: computing tax should throw an error
        XCTAssertThrowsError(try computeTaxOwed(income: income, config: taxConfig)) { error in
            XCTAssertTrue(error is TaxCalculationError, "Should throw TaxCalculationError for negative income")
        }
    }
    
    // MARK: - Additional Edge Case Tests
    
    func testZeroIncome() throws {
        // Given: income of $0
        let income = 0
        let expectedTax = Decimal(0)
        
        // When: computing tax
        let actualTax = try computeTaxOwed(income: income, config: taxConfig)
        
        // Then: tax should be $0
        XCTAssertEqual(actualTax, expectedTax, "Tax for income $0 should be $0")
    }
    
    func testIncome5000() throws {
        // Given: income of $5,000 (end of first bracket)
        let income = 5000
        let expectedTax = Decimal(0)
        
        // When: computing tax
        let actualTax = try computeTaxOwed(income: income, config: taxConfig)
        
        // Then: tax should be $0
        XCTAssertEqual(actualTax, expectedTax, "Tax for income $5,000 should be $0")
    }
    
    func testIncome5001() throws {
        // Given: income of $5,001 (start of second bracket)
        let income = 5001
        let expectedTax = Decimal(150) // 5001 * 0.03 = 150.03, rounded to 150
        
        // When: computing tax
        let actualTax = try computeTaxOwed(income: income, config: taxConfig)
        
        // Then: tax should be $150
        XCTAssertEqual(actualTax, expectedTax, "Tax for income $5,001 should be $150")
    }
    
    func testIncome10000() throws {
        // Given: income of $10,000 (end of second bracket)
        let income = 10000
        let expectedTax = Decimal(300) // 10000 * 0.03 = 300
        
        // When: computing tax
        let actualTax = try computeTaxOwed(income: income, config: taxConfig)
        
        // Then: tax should be $300
        XCTAssertEqual(actualTax, expectedTax, "Tax for income $10,000 should be $300")
    }
    
    func testIncome10001() throws {
        // Given: income of $10,001 (start of third bracket)
        let income = 10001
        let expectedTax = Decimal(550) // 10001 * 0.055 = 550.055 rounded to 550
        
        // When: computing tax
        let actualTax = try computeTaxOwed(income: income, config: taxConfig)
        
        // Then: tax should be $550
        XCTAssertEqual(actualTax, expectedTax, "Tax for income $10,001 should be $550")
    }
    
    func testIncome20000() throws {
        // Given: income of $20,000 (end of third bracket)
        let income = 20000
        let expectedTax = Decimal(1100) // 20000 * 0.055 = 1100
        
        // When: computing tax
        let actualTax = try computeTaxOwed(income: income, config: taxConfig)
        
        // Then: tax should be $1,100
        XCTAssertEqual(actualTax, expectedTax, "Tax for income $20,000 should be $1,100")
    }
    
    func testIncome20001() throws {
        // Given: income of $20,001 (start of fourth bracket)
        let income = 20001
        let expectedTax = Decimal(2160) // 20001 * 0.108 = 2160.108 rounded to 2160
        
        // When: computing tax
        let actualTax = try computeTaxOwed(income: income, config: taxConfig)
        
        // Then: tax should be $2,160
        XCTAssertEqual(actualTax, expectedTax, "Tax for income $20,001 should be $2,160")
    }
    
    func testIncome40000() throws {
        // Given: income of $40,000 (end of fourth bracket)
        let income = 40000
        let expectedTax = Decimal(4320) // 40000 * 0.108 = 4320
        
        // When: computing tax
        let actualTax = try computeTaxOwed(income: income, config: taxConfig)
        
        // Then: tax should be $4,320
        XCTAssertEqual(actualTax, expectedTax, "Tax for income $40,000 should be $4,320")
    }
    
    func testIncome40001() throws {
        // Given: income of $40,001 (start of highest bracket)
        let income = 40001
        let expectedTax = Decimal(9480) // 40001 * 0.237 = 9480.237 rounded to 9480
        
        // When: computing tax
        let actualTax = try computeTaxOwed(income: income, config: taxConfig)
        
        // Then: tax should be $9,480
        XCTAssertEqual(actualTax, expectedTax, "Tax for income $40,001 should be $9,480")
    }
    
    // MARK: - Performance Test
    
    func testPerformanceExample() throws {
        measure {
            // Test performance with a high income calculation
            do {
                _ = try computeTaxOwed(income: 100000, config: taxConfig)
            } catch {
                XCTFail("Performance test should not throw error")
            }
        }
    }
}
