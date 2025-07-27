//
//  NotesViewModel.swift
//  Notes
//
//  Created by Xander The Boss on 7/22/25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class NotesViewModel : ObservableObject {
    @Published var notes: [NoteModel] = []
    
    let db = Firestore.firestore()
    
    @MainActor
    func fetchData() async {
        notes.removeAll()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        do {
            let querySnapshot = try await db.collection("users").document(uid).collection("notes").getDocuments()
          for document in querySnapshot.documents {
              do {
                  try notes.append(document.data(as: NoteModel.self))
              } catch {
                  print(error)
              }
          }
        } catch {
          print("Error getting documents: \(error)")
        }
    }
    
    func saveData(note: NoteModel) {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            if !note.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || !note.content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                if let id = note.id {
                    try db.collection("users").document(uid).collection("notes").document(note.id!).setData(from: note)
                }
                else {
                    try db.collection("users").document(uid).collection("notes").addDocument(from: note)
                }
            }
        } catch let error {
          print("Error: \(error)")
        }
    }
    
    func deleteData(note: NoteModel) async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        do {
            try await db.collection("users").document(uid).collection("notes").document(note.id!).delete()
          print("Document successfully removed!")
        } catch {
          print("Error removing document: \(error)")
        }
    }
    
    @MainActor
    func deleteAllData() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = db.collection("users").document(uid).collection("notes")
        
        do {

            let userDocs = try await userData.getDocuments()
            
            for doc in userDocs.documents {
                try await userData.document(doc.documentID).delete()
            }
        }
        catch {
            print("Error removing documents: \(error)")
        }
    }
    
    func signUp(cred: CredentialModel) async throws {
        try await Auth.auth().createUser(withEmail: cred.email, password: cred.password)
    }
    func login(cred: CredentialModel) async throws {
        try await Auth.auth().signIn(withEmail: cred.email, password: cred.password)
    }
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
}
