//
//  NotesView.swift
//  Notas
//
//  Created by Matheus Accorsi on 10/11/23.
//

import SwiftUI

struct NotesView: View {
    
    @StateObject var viewModel = NoteViewModel()
    @State var isGoAdditionNote = false
    
    var body: some View {
            
            List($viewModel.notes, editActions: .all) { $note in
                NavigationLink {
                    NotesDetailView(note: $note)
                } label: {
                    HStack {
                        Image(systemName: "pencil")
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 8)
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                            Text(note.content)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("Notas")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Adicionar") {
                        isGoAdditionNote.toggle()
                    }
                }
            }
            .sheet(isPresented: $isGoAdditionNote) {
                AddNotesView(viewModel: viewModel)
        }
    }
}

#Preview {
    NavigationStack {
        NotesView()
    }
}
