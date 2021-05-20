//
//  RegisterView.swift
//  CDLoginRegistration
//
//  Created by Devin Ercolano on 5/19/21.
//

import SwiftUI
import CoreData

struct RegisterView: View {
    @State private var registerFirstName = ""
    @State private var registerLastName = ""
    @State private var registerEmail = ""
    @State private var registerPassword = ""
    @State private var registerConfirmPassword = ""
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        ZStack {
            Color.gray
            .ignoresSafeArea()
            
            VStack(spacing: 15) {
            Spacer()
            Text("CDL Registration")
                .font(.system(size: 40, weight: .semibold))
                .foregroundColor(.black)
            HStack {
                Image(systemName: "person.badge.plus")
                    .foregroundColor(.gray)
                TextField("First Name", text: $registerFirstName)
            }.frame(height: 60)
            .background(Color.white)
            .cornerRadius(8)
            .padding(.horizontal, 20)
            HStack {
                Image(systemName: "person.badge.plus")
                    .foregroundColor(.gray)
                TextField("Last Name", text: $registerLastName)
            }.frame(height: 60)
            .background(Color.white)
            .cornerRadius(8)
            .padding(.horizontal, 20)
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                TextField("Email", text: $registerEmail)
            }.frame(height: 60)
            .background(Color.white)
            .cornerRadius(8)
            .padding(.horizontal, 20)
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                SecureField("Password", text: $registerPassword)
            }.frame(height: 60)
            .background(Color.white)
            .cornerRadius(8)
            .padding(.horizontal, 20)
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                SecureField("Confirm Password", text: $registerConfirmPassword)
            }.frame(height: 60)
            .background(Color.white)
            .cornerRadius(8)
            .padding(.horizontal, 20)
                Button(action: {self.addUser(firstName: registerFirstName, lastName: registerLastName, email: registerEmail, password: registerPassword, confirmPassword: registerConfirmPassword)}) {
                Text("Register")
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .medium))
            }.frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(Color.red.opacity(0.8))
            .cornerRadius(8)
            .padding(.horizontal, 20)
            Spacer()
            }
            
        }
    }
    
    private func addUser(firstName: String, lastName: String, email: String, password: String, confirmPassword: String) -> User? {
        let context = managedObjectContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
        
        newUser.id = UUID()
        newUser.firstName = registerFirstName
        newUser.lastName = registerLastName
        newUser.email = registerEmail
        newUser.password = registerPassword
        newUser.confirmPassword = registerConfirmPassword
        
        do {
            try context.save()
            print(newUser)
            //Always a good idea to dimiss after saving
            self.presentationMode.wrappedValue.dismiss()
            return newUser
        } catch  let createError {
            context.delete(newUser)
            print("Failed to create: \(createError)")
            return nil
//            #if DEBUG
//            fatalError()
//            #endif
        }
        
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
