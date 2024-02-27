//
//  NetworkError.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 27.02.2024.
//

import UIKit

enum NetworkError: Error {
    case serverError(text: String)
    case networkError(text: String)
    case incorrectData(text: String)
}
