//
//  ListTopicView.swift
//  Prep-I
//
//  Created by Jamoliddinov Abduraxmon on 02/12/24.
//

import SwiftUI
import SwiftData

struct ListTopicScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [QuestionEntitiy]
    
    var body: some View {
        List {
            let topics = topics()
            ForEach(topics.indices, id: \.self) { index in
                NavigationLink {
                    ListOfQuestionsScreen(topic: topics[index])
                } label: {
                    Text(topics[index])
                }
            }
        }
    }
    
    func topics() -> [String] {
        var topics = Set<String>()
        for item in items {
            for topic in item.topics {
                topics.insert(topic)
            }
        }
        
        return Array(topics)
    }
}

#Preview {
    ListTopicScreen()
        .modelContainer(for: QuestionEntitiy.self, inMemory: true)
}
