//
//  AddQuestionView.swift
//  Prep-I
//
//  Created by Jamoliddinov Abduraxmon on 29/11/24.
//

import SwiftUI

struct Question {
    var question: String
    var answers: [Answer]
    var topics: [String]
    
    init(question: String, answers: [Answer], topics: [String]) {
        self.question = question
        self.answers = answers
        self.topics = topics
    }
}

extension Question {
    init(entity: QuestionEntitiy) {
        self.init(question: entity.question, answers: entity.answers.map { Answer(entity: $0) }, topics: entity.topics)
    }
}

extension Answer {
    init(entity: AnswerEntity) {
        self.init(answer: entity.answer, isCorrect: entity.isCorrect)
    }
}

extension AnswerEntity {
    convenience init(answer: Answer) {
        self.init(answer: answer.answer, isCorrect: answer.isCorrect)
    }
}
extension QuestionEntitiy {
    convenience init(question: Question) {
        let answers = question.answers.map { AnswerEntity(answer: $0) }
        self.init(question: question.question, topics: question.topics, answers: answers)
    }
}

struct Answer {
    var answer: String
    var isCorrect: Bool
}

struct AddQuestionScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var question: Question
    @State private var topic: String = ""
    
    init() {
        self.question = Question(question: "", 
                                 answers: [
                                    Answer(answer: "", isCorrect: true),
                                    Answer(answer: "", isCorrect: false),
                                    Answer(answer: "", isCorrect: false),
                                    Answer(answer: "", isCorrect: false)
                                 ],
                                 topics: [])
        
    }
    
    var body: some View {
        Form {
            TextField("Question", text: $question.question, axis: .vertical)

            TextField("Topic", text: $topic, axis: .vertical)
            
            ForEach(question.answers.indices, id: \.self) { index in
                Section("Answer \(index + 1)") {
                    TextField("Answer \(index+1)", text: $question.answers[index].answer, axis: .vertical)
                        .foregroundColor(question.answers[index].isCorrect ? Color.green : Color.black)
                    Toggle(question.answers[index].isCorrect ? "Correct" : "Incorrect", isOn: $question.answers[index].isCorrect)
                        .toggleStyle(.switch)
                }
            }
            
            Button("Save") {
                question.topics = topic.components(separatedBy: ",")
                modelContext.insert(QuestionEntitiy(question: question))
                dismiss()
            }
        }
    }
}

#Preview {
    AddQuestionScreen()
}
