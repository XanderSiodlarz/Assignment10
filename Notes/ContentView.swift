//
//  ContentView.swift
//  Notes
//
//  Created by Xander The Boss on 7/22/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var notesvm : NotesViewModel
    @State var tempCred = CredentialModel(email: "", password: "")
    
    var body: some View {
        NavigationStack {
            Text("Welcome to the Notes App")
                .font(.largeTitle)
                .padding(40)
                .multilineTextAlignment(.center)
            
            Spacer()

            
            Text("Get Started")
                .underline()
                .padding(.vertical)
            
            HStack {
                
                Spacer()
                
                NavigationLink(destination: CredView(cred: $tempCred)) {
                    Text("Sign Up / Login")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(5)
                .bold()
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NotesViewModel())
}
