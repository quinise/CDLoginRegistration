//
//  SuccessView.swift
//  CDLoginRegistration
//
//  Created by Devin Ercolano on 5/19/21.
//

import SwiftUI

struct SuccessView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.email, ascending: false)])
    var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.id) { user in
                    NavigationLink(destination: UserView(user: user)) {
                        Text("\(user.email ?? "")")
                    }
                }.onDelete(perform: deleteItems)
            }.navigationTitle("Accounts")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            managedObjectContext.perform {
                offsets.map { users[$0] }.forEach(managedObjectContext.delete)
                
                do {
                    try managedObjectContext.save()
                } catch {
                    #if DEBUG
                    fatalError()
                    #endif
                }
            }
        }
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
