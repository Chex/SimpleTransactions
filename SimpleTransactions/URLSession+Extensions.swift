//
//  URLSession+Extensions.swift
//  SimpleTransactions
//
//  Created by Sean Chen on 7/13/24.
//

import Foundation

extension URLSession {
    
    /// Fetches and decodes JSON data from a URL into a specified Decodable type.
    /// - Parameters:
    ///   - type: The Decodable type to decode the JSON into. Defaults to T.self.
    ///   - url: The URL to fetch the JSON data from.
    ///   - keyDecodingStrategy: The key decoding strategy to use. Defaults to .useDefaultKeys.
    ///   - dataDecodingStrategy: The data decoding strategy to use. Defaults to .deferredToData.
    ///   - dateDecodingStrategy: The date decoding strategy to use. Defaults to .deferredToDate.
    /// - Returns: An instance of the specified Decodable type.
    /// - Throws: An error if the data couldn't be fetched or decoded.
    func decode<T: Decodable>(
        _ type: T.Type = T.self,
        from url: URL,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) async throws  -> T {
        
        // Fetch data from the URL
        let (data, _) = try await data(from: url)
        
        // Create and configure a JSONDecoder
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy
        
        // Decode the data into the specified type
        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
}
