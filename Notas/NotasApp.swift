//
//  NotasApp.swift
//  Notas
//
//  Created by Matheus Accorsi on 10/11/23.
//

import SwiftUI

@main
struct NotasApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}


