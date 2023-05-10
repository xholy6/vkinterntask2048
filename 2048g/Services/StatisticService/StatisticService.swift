import Foundation

protocol StatisticService {
    var currentScore: Int { get }
    var bestGame: GameRecord { get }
    func store(current score: Int)
}
