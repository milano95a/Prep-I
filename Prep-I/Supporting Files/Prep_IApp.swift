//
//  Prep_IApp.swift
//  Prep-I
//
//  Created by Jamoliddinov Abduraxmon on 29/11/24.
//

import SwiftUI
import SwiftData

@main
struct Prep_IApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            QuestionEntitiy.self,
            AnswerEntity.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ListQuestionView()
        }
        .modelContainer(sharedModelContainer)
    }
}
