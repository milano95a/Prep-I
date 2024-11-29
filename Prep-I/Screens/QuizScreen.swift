//
//  QuizView.swift
//  Prep-I
//
//  Created by Jamoliddinov Abduraxmon on 02/12/24.
//

import SwiftUI

struct QuizScreen: View {
    init(question: Question) {
        self.question = question
        let isCorrect = question.answers.map { _ in false }
        self.isCorrect = isCorrect
    }
    
    @State var question: Question
    @State var isCorrect: [Bool]
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(question.question)
                ForEach(question.answers.indices, id: \.self) { index in
                    HStack {
                        CheckboxView(isChecked: isCorrect[index])
                        Text(question.answers[index].answer)
                    }
                    .onTapGesture {
                        isCorrect[index].toggle()
                    }
                }
                     
                if let check = check() {
                    Text(check ? "Correct" : "Incorrect")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
    
    func check() -> Bool? {
        guard isCorrect.contains(true) else {
            return nil
        }
        
        for index in question.answers.indices {
            if isCorrect[index] != question.answers[index].isCorrect {
                return false
            }
        }
        
        return true
    }
}

#Preview {
    QuizScreen(question: .init(question: "question", answers: [.init(answer: "answer 1", isCorrect: true), .init(answer: "answer 2", isCorrect: false)], topics: ["topic 1", "topic 2"]))
}

struct CheckboxView: View {
    var isChecked: Bool

    var body: some View {
        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
            .foregroundColor(isChecked ? .blue : .gray)
    }
}
