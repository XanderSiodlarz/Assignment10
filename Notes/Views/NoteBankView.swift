//
//  NoteBankView.swift
//  Notes
//
//  Created by Xander The Boss on 7/24/25.
//

import SwiftUI

struct NoteBankView: View {
    
    @EnvironmentObject var notesvm : NotesViewModel
    @State var newNote = NoteModel(title: "", content: "")
    @State private var backButton = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($notesvm.notes) { $note in
                    NavigationLink {
                        NoteDetail(note: $note)
                    } label: {
                        Text(note.title)
                    }
                }
                .onDelete { indexSet in
                        Task {
                            for index in indexSet {
                                let note = notesvm.notes[index]
                                await notesvm.deleteData(note: note)
                            }
                        }
                    }
                
                Section {
                    NavigationLink {
                        NoteDetail(note: $newNote)
                    } label: {
                        Text("Create New Note")
                            .foregroundStyle(.gray)
                    }
                }
                
                NavigationStack {
                        Button("Logout"){
                            notesvm.logout()
                            backButton = true
                        }
                        .navigationDestination(isPresented: $backButton) {
                            ContentView()
                                .navigationBarBackButtonHidden(true)
                        }
                }
                Button("Delete All Notes") {
                    Task {
                        await notesvm.deleteAllData()
                        await notesvm.fetchData()
                    }
                }
            }
            .task {
                await notesvm.fetchData()
            }
        }
    }
}

#Preview {
    NoteBankView()
        .environmentObject(NotesViewModel())
}
