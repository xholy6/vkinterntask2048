import Foundation

struct GameRecord: Codable, Comparable {
    
    let currentScore: Int
    
    static func < (prevValue: GameRecord, newValue: GameRecord) -> Bool {
        return prevValue.currentScore < newValue.currentScore
    }
    func toString () -> String {
        ("\(currentScore)")
    }
}
