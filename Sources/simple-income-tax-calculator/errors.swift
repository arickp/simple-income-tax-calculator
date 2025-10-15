//
//  errors.swift
//  simple-income-tax-calculator
//
//  Created by Eric Popelka on 10/15/25.
//

public enum TaxCalcuationError: Error, CustomStringConvertible {
    case noTaxRateFound
    
    public var description: String {
        switch self {
        case .noTaxRateFound:
            return "No tax rate found for this income level."
        }
    }
}

public enum ConfigError: Error { case notFound }
