//
//  Loader.swift
//  PPCurrencyConversion
//
//  Created by Yuan Zhou on 2019/09/25.
//  Copyright © 2019 Yuan Zhou. All rights reserved.
//

import Foundation

/// Network-related tasks
class Loader {
    
    // TODO:
    // 1. network availability checking
    // 2. network timeout & retry
    func load(url: URL, completion: @escaping (Data?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("client error when loading rates: \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("server error when loading rates: \(String(describing: response))")
                return
            }
            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
               let data = data {
                completion(data)
            } else {
                print("data not exist")
                completion(nil)
            }
        }
        task.resume()
    }
}
