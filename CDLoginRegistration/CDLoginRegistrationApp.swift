//
//  CDLoginRegistrationApp.swift
//  CDLoginRegistration
//
//  Created by Devin Ercolano on 5/19/21.
//

import SwiftUI

@main
struct CDLoginRegistrationApp: App {
    let persistenceController = PersistenceController.shared
    @State var signInSuccess = false

    var body: some Scene {
        WindowGroup {
            AppContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
