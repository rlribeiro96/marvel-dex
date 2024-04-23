//
//  RequestProtocol.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 17/04/24.
//

import Foundation

protocol RequestProtocol {
    var url: String { get }
    var path: String { get }
    var method: String { get }
    var queryParameters: [String: String]? { get }
}
