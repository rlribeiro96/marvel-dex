//
//  LoadingView.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 21/04/24.
//

import SwiftUI

struct LoadingView: View {

    var height: CGFloat?
    var width: CGFloat?

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ProgressView().progressViewStyle(.circular)
                Spacer()
            }
            Spacer()
        }
        .frame(width: width, height: height)
    }
}
