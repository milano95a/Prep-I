//
//  QuestionEntitiy.swift
//  Prep-I
//
//  Created by Jamoliddinov Abduraxmon on 29/11/24.
//

import Foundation
import SwiftData

@Model
final class QuestionEntitiy {
    
    var question: String
    var answers: [AnswerEntity]
    var topics: [String]
    
    init(question: String, topics: [String], answers: [AnswerEntity]) {
        self.question = question
        self.topics = topics
        self.answers = answers
    }
}
