//
//  AnswerEntity.swift
//  Prep-I
//
//  Created by Jamoliddinov Abduraxmon on 06/12/24.
//

import Foundation
import SwiftData

@Model
final class AnswerEntity {
    
    var answer: String
    var isCorrect: Bool
    
    init(answer: String, isCorrect: Bool) {
        self.answer = answer
        self.isCorrect = isCorrect
    }
}
