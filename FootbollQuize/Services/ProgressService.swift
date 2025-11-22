import Foundation

struct ProgressServiceData: Codable {
    let time: Int
    let stars: Int
    let mood: String
}

class ProgressService {
    
    private let maxKeyLimit = 5
    
    private let quizeCompletedKey = "quizeCompleted"
    private let trainingCompletedKey = "trainingCompleted"
    private let progressRecordsKey = "progressRecords"
    
    private let dayKeyDatesKey = "dayKeyDates"
    
    typealias ProgressRecords = [String: [ProgressServiceData]]
    
    typealias DayKeyDates = [String: String]
    
    private let timestampFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        return formatter
    }()
    
    private func getDayKey(from date: Date) -> String {
        let calendar = Calendar.current
        let dayNumber = calendar.component(.day, from: date)
        return String(dayNumber)
    }
    
    private func getAllProgressRecords() -> ProgressRecords {
        let userDefaults = UserDefaults.standard
        let decoder = JSONDecoder()
        
        guard let savedData = userDefaults.data(forKey: progressRecordsKey) else { return [:] }
        
        do {
            return try decoder.decode(ProgressRecords.self, from: savedData)
        } catch {
            print("Error decoding progress records: \(error)")
            return [:]
        }
    }
    
    private func getDayKeyDates() -> DayKeyDates {
        let userDefaults = UserDefaults.standard
        let decoder = JSONDecoder()
        
        guard let savedData = userDefaults.data(forKey: dayKeyDatesKey) else { return [:] }
        
        do {
            return try decoder.decode(DayKeyDates.self, from: savedData)
        } catch {
            print("Error decoding day key dates: \(error)")
            return [:]
        }
    }
    
    private func saveDayKeyDates(_ dates: DayKeyDates) {
        let userDefaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        do {
            let encodedData = try encoder.encode(dates)
            userDefaults.set(encodedData, forKey: dayKeyDatesKey)
        } catch {
            print("Error encoding and saving day key dates: \(error)")
        }
    }

    func saveProgress(_ data: ProgressServiceData) {
        let userDefaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        let currentDate = Date()
        let dayKey = getDayKey(from: currentDate)
        let currentTimestamp = timestampFormatter.string(from: currentDate)
        
        var allRecords = getAllProgressRecords()
        var dayKeyDates = getDayKeyDates()
        
        var currentRecords = allRecords[dayKey] ?? []
        currentRecords.append(data)
        allRecords[dayKey] = currentRecords
        
        if dayKeyDates[dayKey] == nil {
            dayKeyDates[dayKey] = currentTimestamp
        }
                
        let sortedDayKeysByTimestamp = dayKeyDates.sorted { $0.value < $1.value }
        
        if sortedDayKeysByTimestamp.count > maxKeyLimit {
            let oldestKey = sortedDayKeysByTimestamp.first!.key
            
            allRecords.removeValue(forKey: oldestKey)
            dayKeyDates.removeValue(forKey: oldestKey)
            
            print("Removed oldest key (Day: \(oldestKey)) to maintain limit of \(maxKeyLimit) days.")
        }
        
        do {
            let encodedData = try encoder.encode(allRecords)
            userDefaults.set(encodedData, forKey: progressRecordsKey)
            saveDayKeyDates(dayKeyDates)
        } catch {
            print("Error encoding and saving all progress records: \(error)")
        }
    }
    
    func getProgressRecords(for date: Date) -> [ProgressServiceData] {
        let allRecords = getAllProgressRecords()
        
        let keyString = getDayKey(from: date)
        
        return allRecords[keyString] ?? []
    }

    func getAvailableDayKeysChronologically() -> [Int] {
        let dayKeyDates = getDayKeyDates()
        
        let sortedKeysByTimestamp = dayKeyDates.sorted { $0.value < $1.value }
        
        return sortedKeysByTimestamp.compactMap { Int($0.key) }
    }

    
    func clearAllProgress() {
        UserDefaults.standard.removeObject(forKey: progressRecordsKey)
        UserDefaults.standard.removeObject(forKey: dayKeyDatesKey)
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
