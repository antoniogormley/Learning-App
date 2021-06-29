//
//  Learning_AppApp.swift
//  Learning App
//
//  Created by Antonio Gormley on 29/06/2021.
//

import SwiftUI

@main
struct Learning_App: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
