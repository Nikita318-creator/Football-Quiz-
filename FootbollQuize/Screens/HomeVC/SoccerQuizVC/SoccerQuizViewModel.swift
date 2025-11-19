import UIKit

struct SoccerQuizModel {
    let question: String
    let options: [String]
    let correctOption: Int
}


class SoccerQuizViewModel {
    let model: [SoccerQuizModel] = [
        SoccerQuizModel(
            question: "Which part of the foot is usually used for accurate passing?",
            options: ["Heel", "Outside of the foot", "Inside of the foot", "Toe"],
            correctOption: 3
        )
    ]
}
