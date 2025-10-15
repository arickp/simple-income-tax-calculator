//
//  taxConfig.swift
//  simple-income-tax-calculator
//
//  Defines the structure of the tax rate data, and provides functionality for
//  loading tax rates from a JSON file.
//
//  Created by Eric Popelka on 10/15/25.
//

import Foundation
import Logging

/** Structure of the data files containing the tax rates for each income bracket */
public struct TaxConfig: Codable {
    struct Bracket: Codable {
        /** lower bound */
        let min: Int
        
        /** if this is nil, then there is no upper bound */
        let max: Int?
        
        /** e.g., 0.055 for 5.5% */
        let rate: Decimal
    }
    
    let brackets: [Bracket]
}

private func loadConfigData() throws -> Data {
    let logger = Logger(label: applicationId)
    if let url = Bundle.module.url(forResource: "taxConfig", withExtension: "json") {
        logger.debug("Tax rates loaded from: \(url)")
        return try Data(contentsOf: url)
    } else {
        throw NSError(domain: "taxConfig", code: 1, userInfo: [NSLocalizedDescriptionKey: "Could not find taxConfig.json in Bundle.main"])
    }
}

/** Loads tax rates from a JSON file */
func loadConfig() throws -> TaxConfig {
    let logger = Logger(label: applicationId)
    logger.debug("Loading tax rates from resources...")
    let data = try loadConfigData()
    let config = try JSONDecoder().decode(TaxConfig.self, from: data)
    logger.debug("Got \(config.brackets.count) tax brackets")
    return config
}

