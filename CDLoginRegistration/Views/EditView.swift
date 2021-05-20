//
//  EditView.swift
//  CDLoginRegistration
//
//  Created by Devin Ercolano on 5/19/21.
//

import SwiftUI

enum ActiveAlertEdit {
    case first, second, third, fourth
}

struct EditView: View {
    @State private var editFirstName = ""
    @State private var editLastName = ""
    @State private var editEmail = ""
    @State private var editPassword = ""
    @State private var badCredentialAlert = false
    @State private var activeAlert: ActiveAlertEdit = .first
    
    var user: User
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                // Include placeholders of existing data in each field, validate each field
                TextField("first name", text: $editFirstName)
                    .padding()
                TextField(user.lastName ?? "last name", text: $editLastName)
                    .padding()
                TextField(user.email ?? "email", text: $editEmail)
                    .padding()
                TextField(user.password ?? "password", text: $editPassword)
                    .padding()
                Button(action: {self.updateUser()}) {
                    Text("Update")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .medium))
                }.frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.red.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal, 20)
                Spacer()
                }.alert(isPresented: $badCredentialAlert) {
                    switch activeAlert {
                    case .first:
                        return Alert(title: Text("Bad First Name"), message: Text("all characters, 2-10"))
                    case .second:
                        return Alert(title: Text("Bad Last Name"), message: Text("all characters, 2-15"))
                    case .third:
                        return Alert(title: Text("Bad Email"), message: Text("Email does not match"))
                    case .fourth:
                        return Alert(title: Text("Bad Password"), message: Text("Password does not match"))
                    }
                }
                .onAppear(perform: {
                    editFirstName = user.firstName ?? ""
                    editLastName = user.lastName ?? ""
                    editEmail = user.email ?? ""
                    editPassword = user.password ?? ""
                })
            }
            .navigationTitle("Edit Profile")
            .navigationBarBackButtonHidden(true)
        }
    
    func updateUser() {
        user.firstName = editFirstName
        user.lastName = editLastName
        user.email = editEmail
        user.password = editPassword
        
        do {
            try self.managedObjectContext.save()
            //refresh previous view
            
            //Always a good idea to dimiss after saving
            self.presentationMode.wrappedValue.dismiss()
        } catch {
            self.managedObjectContext.rollback()
            //            self.dataAlert.toggle()
            print(error)
            //            #if DEBUG
            //            fatalError()
            //            #endif
        }
    }
    }
    
    

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView()
//    }
//}
