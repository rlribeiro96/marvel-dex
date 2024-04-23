//
//  ResponseState.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 17/04/24.
//

import Foundation

enum ResponseState {
    case idle
    case loading
    case loaded
    case error
    case errorNoResults
    case errorNoNetwork
}
