import UIKit

struct ProgressServiceData {
    let modelIndex: Int
    let question: String
    let questionNumber: Int
}

class ProgressService {
    
    // Ключи для UserDefaults
    private let quizeCompletedKey = "quizeCompleted"
    private let trainingCompletedKey = "trainingCompleted"
        
//    func saveTest(_ data: ProgressServiceData) {
//        UserDefaults.standard.set(data.modelIndex, forKey: "last_soccer_quiz_model_index")
//        UserDefaults.standard.set(data.question, forKey: "last_soccer_quiz_question")
//        UserDefaults.standard.set(data.questionNumber, forKey: "last_soccer_quiz_question_number")
//    }
//    
//    func getTest() -> ProgressServiceData? {
//        guard
//            let modelIndex = UserDefaults.standard.value(forKey: "last_soccer_quiz_model_index") as? Int,
//            let question = UserDefaults.standard.value(forKey: "last_soccer_quiz_question") as? String,
//            let questionNumber = UserDefaults.standard.value(forKey: "last_soccer_quiz_question_number") as? Int
//        else { return nil }
//
//        return ProgressServiceData(modelIndex: modelIndex, question: question, questionNumber: questionNumber)
//    }
    
    func getQuizeCompleted() -> [Int] {
        return UserDefaults.standard.array(forKey: quizeCompletedKey) as? [Int] ?? []
    }
    
    func getTrainingCompleted() -> [Int] {
        return UserDefaults.standard.array(forKey: trainingCompletedKey) as? [Int] ?? []
    }
    
    func saveQuizeCompleted(id: Int) {
        var completedQuizes = getQuizeCompleted()
        
        if !completedQuizes.contains(id) {
            completedQuizes.append(id)
            UserDefaults.standard.set(completedQuizes, forKey: quizeCompletedKey)
        }
    }
    
    func saveTrainingCompleted(id: Int) {
        var completedTrainings = getTrainingCompleted()
        
        if !completedTrainings.contains(id) {
            completedTrainings.append(id)
            UserDefaults.standard.set(completedTrainings, forKey: trainingCompletedKey)
        }
    }
}
