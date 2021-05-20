//
//  UserView.swift
//  CDLoginRegistration
//
//  Created by Devin Ercolano on 5/19/21.
//

import SwiftUI

struct UserView: View {
    @State var isPresented = false
    var user: User
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        List {
            Section(header: Text("Name")) {
                Text(user.firstName ?? "")
                Text(user.lastName ?? "")
            }
            
            Section(header: Text("Email")) {
                Text(user.email ?? "")
            }
            
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Profile")
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }) {
            Image(systemName: "gearshape")
        })
        .sheet(isPresented: $isPresented) {
            NavigationView {
                EditView(user: user)
                    .navigationBarItems(leading: Button("Dismiss") {
                        isPresented = false
                    })
            }
        }
    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView()
//    }
//}
