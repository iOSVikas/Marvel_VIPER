//
//  APIError.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation

enum APIError: Error {
    case message(String)
    
    var localizedDescription: String {
        switch self {
        case .message(let string):
            return string
        }
    }
}
