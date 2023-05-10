import Foundation

final class BoardServices {
    static let shared = BoardServices()
    
    private init() {}
    
    private let gridSize = 4
    private var tile: Tile = Tile()
    private (set) var board: [[Tile]] = [[]]
    
    
    func fillStartingBoard() {
        board = Array(repeating: Array(repeating: Tile(), count: gridSize), count: gridSize)
        for i in 0..<gridSize {
            for j in 0..<gridSize {
                board[i][j] = Tile()
            }
        }
        for _ in 0..<2 {
            addRandomTile()
        }
    }
    
    func addRandomTile() {
        if checkForLose() { return }
        
        while true {
            printMatrix()
            let randRow = Int.random(in: 0..<board.count)
            let randCol = Int.random(in: 0..<board[randRow].count)
            
            if board[randRow][randCol].value == 0 {
                board[randRow][randCol].value = Int.random(in: 1...2) * 2
                break
            }
        }
        
    }
    
        private func printMatrix() {
            var string = String("")
            for i in 0..<board.count {
                for j in 0..<board[i].count {
                    string += String("\(board[i][j].value )    ")
                }
                print(string)
                string = ""
            }
        }
    
    
    func checkForLose() -> Bool {
        for row in 0..<board.count {
            for col in 0..<board[row].count {
                let currentTile = board[row][col].value
                
                if row > 0 {
                    let topTile = board[row-1][col].value
                    if topTile == currentTile || topTile == 0 || (currentTile == 0 && topTile != 0) {
                        return false
                    }
                }
                
                if row < board.count {
                    let bottomTile = board[row+1][col].value
                    if bottomTile == currentTile || bottomTile == 0 || (currentTile == 0 && bottomTile != 0) {
                        return false
                    }
                }
                
                if col > 0 {
                    let leftTile = board[row][col-1].value
                    if leftTile == currentTile || leftTile == 0 || (currentTile == 0 && leftTile != 0) {
                        return false
                    }
                }
                
                if col < board[row].count - 1 {
                    let rightTile = board[row][col+1].value
                    if rightTile == currentTile || rightTile == 0 || (currentTile == 0 && rightTile != 0) {
                        return false
                    }
                }
            }
        }
        return true
    }
    
    
    
    func clearBoard() {
        for i in 0..<gridSize {
            for j in 0..<gridSize {
                board[i][j].value = 0
            }
        }
    }
    
}
