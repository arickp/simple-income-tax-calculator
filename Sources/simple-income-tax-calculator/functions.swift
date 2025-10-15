//
//  functions.swift
//  simple-income-tax-calculator
//
//  Created by Eric Popelka on 10/15/25.
//

import Foundation
import Logging

private func getTaxRate(income: Int, config: TaxConfig) throws -> Decimal {
    let logger = Logger(label: applicationId)
    
    for bracket in config.brackets {
        let minIncome = bracket.min
        let maxIncome = bracket.max
        let rate = bracket.rate
        let maxIncomeText = maxIncome.map { String($0) } ?? "∞"
        logger.debug("Checking if \(income) is between \(minIncome) and \(maxIncomeText)...")
        
        if income >= minIncome && (maxIncome == nil || income <= maxIncome!) {
            logger.debug("Income \(income) is in range, rate is: \(rate)")
            return rate
        } else {
            logger.debug("Income is not in range, moving on to next bracket...")
        }
    }
    
    logger.error("No matching bracket for income \(income)")
    throw TaxCalculationError.noTaxRateFound
}

/** Given a person's annual income, and the tax rates, returns amount of tax owed */
public func computeTaxOwed(income: Int, config: TaxConfig) throws -> Decimal {
    let logger = Logger(label: applicationId)
    logger.debug("Computing tax owed for income of: \(income)")
    
    // Determine tax bracket
    let rate = try getTaxRate(income: income, config: config)
    
    // Compute tax and round to closest dollar
    var tax = Decimal(income) * rate
    var roundedTax = Decimal()
    NSDecimalRound(&roundedTax, &tax, 0, .plain)
    
    logger.debug("Tax owed is: \(roundedTax)")
    return roundedTax
}

