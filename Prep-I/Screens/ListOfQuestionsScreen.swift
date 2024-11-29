//
//  ContentView.swift
//  Prep-I
//
//  Created by Jamoliddinov Abduraxmon on 29/11/24.
//

import SwiftUI
import SwiftData

struct ListOfQuestionsScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [QuestionEntitiy]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        QuizView(question: Question(entity: item))
                    } label: {
                        Text(item.question)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        AddQuestionView()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ListOfQuestionsScreen()
        .modelContainer(for: QuestionEntitiy.self, inMemory: true)
}
