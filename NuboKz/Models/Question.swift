//
//  Question.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 03.03.2024.
//

import Foundation

struct Question {
    var missionId: String
    var questionId: String
    var answers: [Answer]
    var question: String
}

struct Answer {
    var id: String
    var answer: String
}

struct ChoosedQuestion {
    var questionId: String
    var answerId: String
}
