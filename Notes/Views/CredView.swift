//
//  CredView.swift
//  Notes
//
//  Created by Xander The Boss on 7/24/25.
//

import SwiftUI

struct CredView: View {
    

    @Binding var cred : CredentialModel
    @State private var isValid = false
    @State private var wrongFormat = false
    @EnvironmentObject var notesvm : NotesViewModel
    
    var body: some View {
        NavigationStack {
            Text("Sign Up / Login Page")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .padding(.vertical)
                .bold()
            
            Spacer()
                .frame(height: 50)
            
            VStack {
                Text("Use Email and Password to sign up: ")
                TextField("email", text: $cred.email)
                    .padding(.leading)
                TextField("password", text: $cred.password)
                    .padding(.leading)
                HStack {
                    Button("Sign Up") {
                        if cred.password.count >= 6 && cred.email.contains("@") {
                            Task {
                                do {
                                    try await notesvm.signUp(cred: cred)
                                    isValid = true
                                } catch {
                                    print("fail")
                                }
                            }
                        }
                        else {
                            wrongFormat = true
                        }
                    }
                    .alert("Bad Format", isPresented: $wrongFormat) {
                        Button("OK", role: .destructive){}
                    } message: {
                        Text("email must be a valid email address \n password must be at least 6 characters")
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
                    .bold()

                    
                    Button("Log In ") {
                        Task {
                            do {
                                try await notesvm.login(cred: cred)
                                isValid = true
                            }
                            catch {
                                print(error)
                            }
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
                    .bold()
                }
            }
            .navigationDestination(isPresented: $isValid) {
                NoteBankView().navigationBarBackButtonHidden(true)
            }
            
            Spacer()
                .frame(height: 100)
            
            Spacer()
        }
        
    }
}

#Preview {
    CredView(cred: .constant(CredentialModel(email: "", password: "")))
}
