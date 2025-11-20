import Foundation

struct ProgressServiceData: Codable {
    let time: Int
    let stars: Int
    let mood: String
}

class ProgressService {
    
    private let quizeCompletedKey = "quizeCompleted"
    private let trainingCompletedKey = "trainingCompleted"
    private let progressRecordsKey = "progressRecords"
        
    func saveProgress(_ data: ProgressServiceData) {
        let userDefaults = UserDefaults.standard
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        var allRecords: [ProgressServiceData] = []
        
        if let savedData = userDefaults.data(forKey: progressRecordsKey) {
            do {
                allRecords = try decoder.decode([ProgressServiceData].self, from: savedData)
            } catch {
                print("\(error)")
            }
        }
        
        allRecords.append(data)
        
        do {
            let encodedData = try encoder.encode(allRecords)
            userDefaults.set(encodedData, forKey: progressRecordsKey)
        } catch {
            print("\(error)")
        }
    }
    
    func getProgressRecords() -> [ProgressServiceData] {
        let userDefaults = UserDefaults.standard
        let decoder = JSONDecoder()
        
        guard let savedData = userDefaults.data(forKey: progressRecordsKey) else {
            return []
        }
        
        do {
            let allRecords = try decoder.decode([ProgressServiceData].self, from: savedData)
            return allRecords
        } catch {
            print("\(error)")
            return []
        }
    }
    
    func clearAllProgress() {
        UserDefaults.standard.removeObject(forKey: progressRecordsKey)
    }
    
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
