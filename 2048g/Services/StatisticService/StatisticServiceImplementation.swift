import UIKit

final class StatisticServiceImplementation: StatisticService {
    
    private enum Keys: String {
        
        case currentScore, bestScore, bestGame
    }
    
    private let userDefaults = UserDefaults.standard
    
     var currentScore: Int {
        get {
            userDefaults.integer(forKey: Keys.currentScore.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.currentScore.rawValue)
        }
    }
    
    var bestScore: Int {
        get {
            userDefaults.integer(forKey: Keys.bestScore.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.bestScore.rawValue)
        }
    }
    
    
    var bestGame: GameRecord {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                  let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                return .init(currentScore: 0)
            }
            return record
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
        
    }
    func store(current score: Int) {
        
        currentScore += score
        
        let newResult = GameRecord(currentScore: score)
        if bestGame < newResult {
            bestGame = newResult
        }
    }
}

