import UIKit

struct CalendarDate {
    let date: Date
    var isSelected: Bool
}

struct TrainingSession {
    let title: String
    let duration: Int
    let mood: String
    let fatigue: Int
}

struct ProgressDataModel {
    let title: String
    let subtitle: String
    let imageName: String
    var currentProgress: Int = 0
    var fullProgress: Int = 0
    let nextRank: String
}

class ProgressViewModel {
    private let progressService = ProgressService()

    var currentIndex: Int = 0
    var model: ProgressDataModel
        
    init() {
        model = progressDataModels[currentIndex] // for init in's necessary
        updateState()
    }
    
    func updateState() {
        let quizesCompleted = progressService.getQuizeCompleted().count
        let trainingsCompleted = progressService.getTrainingCompleted().count
             
        let currentProgress: Int
        let fullProgress: Int
        
        if trainingsCompleted >= 50 && quizesCompleted >= 3 {
            currentIndex = 5
            fullProgress = 50
            currentProgress = trainingsCompleted
        } else if trainingsCompleted >= 20 && quizesCompleted >= 3 {
            currentIndex = 4
            fullProgress = 50
            currentProgress = trainingsCompleted
        } else if trainingsCompleted >= 10 && quizesCompleted >= 3 {
            currentIndex = 3
            fullProgress = 20
            currentProgress = trainingsCompleted
        } else if quizesCompleted >= 3 && trainingsCompleted >= 1 {
            currentIndex = 2
            fullProgress = 10
            currentProgress = trainingsCompleted
        } else {
            if trainingsCompleted >= 1 {
                currentIndex = 1
                fullProgress = 3
                currentProgress = quizesCompleted
            } else {
                currentIndex = 0
                fullProgress = 1
                currentProgress = trainingsCompleted
            }
        }
        
        model = progressDataModels[currentIndex]
        model.currentProgress = currentProgress
        model.fullProgress = fullProgress
    }
    
    let progressDataModels: [ProgressDataModel] = [
        ProgressDataModel(
            title: "NO RANK",
            subtitle: "Complete 1 training",
            imageName: "progressImage0",
            nextRank: "NEWBIE"
        ),
        ProgressDataModel(
            title: "NEWBIE",
            subtitle: "Complete 3 quizes",
            imageName: "progressImage1",
            nextRank: "Player"
        ),
        ProgressDataModel(
            title: "Player",
            subtitle: "Complete 10 training",
            imageName: "progressImage2",
            nextRank: "Midfielder"
        ),
        ProgressDataModel(
            title: "Midfielder",
            subtitle: "Complete 20 training",
            imageName: "progressImage3",
            nextRank: "Captain"
        ),
        ProgressDataModel(
            title: "Captain",
            subtitle: "Complete 50 training",
            imageName: "progressImage4",
            nextRank: "Legend"
        ),
        ProgressDataModel(
            title: "Legend",
            subtitle: "",
            imageName: "progressImage5",
            nextRank: ""
        )
    ]
}
