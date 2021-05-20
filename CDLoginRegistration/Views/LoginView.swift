//
//  ContentView.swift
//  CDLoginRegistration
//
//  Created by Devin Ercolano on 5/19/21.
//

import SwiftUI
import CoreData


struct AppContentView: View {
    
    @State var signInSuccess = false
    
    var body: some View {
        return Group {
            if signInSuccess {
               SuccessView()
            }
            else {
                LoginView(signInSuccess: $signInSuccess)
            }
        }
    }
}

enum ActiveAlert {
    case first, second
}

struct LoginView: View {
    @State private var badCredentialAlert = false
    @State private var activeAlert: ActiveAlert = .first
    @Binding var signInSuccess: Bool
//    var alertMessage = ""
//    var alertTitle = ""
    @State private var loginEmail = ""
    @State private var loginPassword = ""
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray
                .ignoresSafeArea()
                
                VStack(spacing: 15) {
                Spacer()
                Text("CDLoginRegistration")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(.black)
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                    TextField("Email", text: $loginEmail)
                }.frame(height: 60)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal, 20)
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                    SecureField("Password", text: $loginPassword)
                }.frame(height: 60)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal, 20)
                //give this a text title and make it bigger
                NavigationLink(destination: RegisterView()) {
                    Image(systemName: "person.badge.plus")
                }
                    Button(action: {self.loginUser()}) {
                    Text("Login")
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
                            return Alert(title: Text("Bad Email"), message: Text("Email does not match"))
                        case .second:
                            return Alert(title: Text("Bad Password"), message: Text("Password does not match"))
                        }
                }
            }
        }
        
    }
    
    func fetchUserDetails(withEmail email: String) -> User? {
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            return users.first
        } catch let fetchError {
            print("Failed to fetch: \(fetchError)")
        }
        
        return nil
    }
    
     func loginUser() {
        // fetch data by email loginEmail
        let user = fetchUserDetails(withEmail: loginEmail)

        if user?.email != loginEmail {
            self.badCredentialAlert = true
            self.activeAlert = .first
            print("bad email")

        } else if user?.password != loginPassword {
            self.badCredentialAlert = true
            self.activeAlert = .second
            print("bad password")
        } else {
            //go to success page
            self.signInSuccess = true
            print("Done!")
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
