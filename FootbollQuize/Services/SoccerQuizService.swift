import UIKit

struct LastSoccerQuizData {
    let modelIndex: Int
    let question: String
    let questionNumber: Int
}

class SoccerQuizService {
    
    func save(_ data: LastSoccerQuizData) {
        UserDefaults.standard.set(data.modelIndex, forKey: "last_soccer_quiz_model_index")
        UserDefaults.standard.set(data.question, forKey: "last_soccer_quiz_question")
        UserDefaults.standard.set(data.questionNumber, forKey: "last_soccer_quiz_question_number")
    }
    
    func get() -> LastSoccerQuizData? {
        guard
            let modelIndex = UserDefaults.standard.value(forKey: "last_soccer_quiz_model_index") as? Int,
            let question = UserDefaults.standard.value(forKey: "last_soccer_quiz_question") as? String,
            let questionNumber = UserDefaults.standard.value(forKey: "last_soccer_quiz_question_number") as? Int
        else { return nil }

        return LastSoccerQuizData(modelIndex: modelIndex, question: question, questionNumber: questionNumber)
    }
}
