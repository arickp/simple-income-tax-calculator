//
//  main.swift
//  simple-income-tax-calculator
//
//  Created by Eric Popelka on 10/15/25.
//

import Logging
import Foundation

LoggingSystem.bootstrap { _ in
    var handler = StreamLogHandler.standardOutput(label: applicationId)
    handler.logLevel = .info
    return handler
}

let logger = Logger(label: applicationId)

let config = try loadConfig()

print("Enter your income:")
if let input = readLine(), let income = Int(input) {
    let tax = try computeTaxOwed(income: income, config: config)
    print("Your tax is: $\(tax)")
} else {
    print("Invalid input")
}

