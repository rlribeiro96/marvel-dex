//
//  BookmarksViewModel.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 19/04/24.
//

import Foundation
import LocalAuthentication

protocol BookmarksViewModelProtocol {
    func authenticate()
}

class BookmarksViewModel: BookmarksViewModelProtocol, ObservableObject {

    @Published var isUnlocked: Bool = false

    @MainActor
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                if success {
                    self.isUnlocked = true
                } else {
                    self.isUnlocked = false
                }
            }
        } else {
            isUnlocked = true
        }
    }
}
