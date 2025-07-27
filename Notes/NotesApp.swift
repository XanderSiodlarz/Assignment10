//
//  NotesApp.swift
//  Notes
//
//  Created by Xander The Boss on 7/22/25.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct NotesApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var notes = NotesViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notes)
        }
    }
}
