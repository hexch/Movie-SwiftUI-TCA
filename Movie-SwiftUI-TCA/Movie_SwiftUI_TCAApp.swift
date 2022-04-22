//
//  Movie_SwiftUI_TCAApp.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import SwiftUI
import ComposableArchitecture

@main
struct Movie_SwiftUI_TCAApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(
                store: Store(
                    initialState: .init(),
                    reducer: homeReducer,
                    environment: HomeEnveroment()
                )
            ).navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
