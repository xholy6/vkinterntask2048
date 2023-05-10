//
//  ViewController.swift
//  2048g
//
//  Created by D on 09.05.2023.
//

import UIKit

final class GameViewController: UIViewController {
    
    private var gameScreen = GameScreen()
    
    private let boardServices = BoardServices.shared
    private var victoryAlertPresenter: VictoryAlertPresenterProtocol?
    private var loseAlertPresenter: LoseAlertPresenterProtocol?
    private var statisticService: StatisticService! = StatisticServiceImplementation()
    
    var currentScore: Int = 0
    
    //MARK: - UI Object
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.register(TileCell.self, forCellWithReuseIdentifier: TileCell.identifier)
        return cv
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        boardServices.fillStartingBoard()
        victoryAlertPresenter = VictoryAlertPresenter(delegate: self)
        loseAlertPresenter = LoseAlertPresenter(delegate: self)
        setupView()
        addSwipeGestures()
        storeScore()
    }
    //MARK: - SetupView
    
    private func setupView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        gameScreen.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gameScreen)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            gameScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameScreen.topAnchor.constraint(equalTo: view.topAnchor),
            gameScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            collectionView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
        ])
        view.backgroundColor = .white
        collectionView.layer.cornerRadius = 15
        collectionView.layer.masksToBounds = true
        collectionView.backgroundColor = .gray
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: - Gestures functions
    private func addSwipeGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        collectionView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        collectionView.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeUp.direction = .up
        collectionView.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeDown.direction = .down
        collectionView.addGestureRecognizer(swipeDown)
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case .left:
            moveLeft()
        case .right:
            moveRight()
        case .up:
            moveUp()
        case .down:
            moveDown()
        default:
            break
        }
        boardServices.addRandomTile()
        collectionView.reloadData()
    }
    
    //MARK: - Private functions
    
    private func moveLeft() {
        var isMovePossible = !boardServices.checkForLose()
        for row in 0..<boardServices.board.count {
            for col in (0..<boardServices.board[row].count).reversed() {
                if col <= 0 {
                    break
                }
                 tryToSummarizeTiles(tile1: boardServices.board[row][col-1],
                                       tile2: boardServices.board[row][col])
            }
        }
        if !isMovePossible {
            storeScore()
            showLoseAlert()
        }
    }
    private func moveRight() {
        var isMovePossible = !boardServices.checkForLose()
        for row in 0..<boardServices.board.count {
            for col in 0..<boardServices.board[row].count {
                if col >= boardServices.board[row].count - 1 {
                    break
                }
                tryToSummarizeTiles(tile1: boardServices.board[row][col+1],
                                       tile2: boardServices.board[row][col])
            }
        }
        if !isMovePossible {
            storeScore()
            showLoseAlert()
        }
    }
    
    private func moveUp() {
        var isMovePossible = !boardServices.checkForLose()
        for col in 0..<boardServices.board[0].count {
            for row in (0..<boardServices.board.count).reversed() {
                if row <= 0 {
                    break
                }
                tryToSummarizeTiles(tile1: boardServices.board[row-1][col],
                                       tile2: boardServices.board[row][col])
            }
        }
        if !isMovePossible {
            storeScore()
            showLoseAlert()
        }
    }
    
    private func moveDown() {
        var isMovePossible = !boardServices.checkForLose()
        for row in 0..<boardServices.board.count {
            for col in 0..<boardServices.board[row].count {
                if row >= boardServices.board[col].count - 1 {
                    break
                }
                 tryToSummarizeTiles(tile1: boardServices.board[row+1][col],
                                       tile2: boardServices.board[row][col])
            }
        }
        if !isMovePossible {
            storeScore()
            showLoseAlert()
        }
    }
    
    private func tryToSummarizeTiles(tile1: Tile, tile2: Tile) -> Bool {
        let isMovePossible = !boardServices.checkForLose()
            if tile1.value == 0 {
                tile1.value = tile2.value
                tile2.value = 0
                gameScreen.updateCurrentScoreLabel(currentScore)
                storeScore()
                
            } else if tile1.value == tile2.value {
                tile1.value += tile2.value
                tile2.value = 0
                currentScore += tile1.value - tile2.value
                gameScreen.updateCurrentScoreLabel(currentScore)
                storeScore()
            }
        return isMovePossible

    }
    
    
    private func storeScore() {
        let bestGame = statisticService.bestGame
        statisticService.store(current: currentScore)
        gameScreen.updateBestScoreLabel(bestGame.currentScore)
    }
    
    
    
    
    //MARK: - AlertShow functions
    
    private func showLoseAlert() {
        let alertModel = AlertModel (title: "You've lost bruh",
                                     message: "Try ur luck next time",
                                     buttonText: "Again" ) { [weak self] _ in
            guard let self = self else { return }
            self.boardServices.clearBoard()
            self.boardServices.fillStartingBoard()
            self.collectionView.reloadData()
        }
        loseAlertPresenter?.requestShowLoseAlert(alertModel: alertModel)
    }
    
    private func showVictoryAlert() {
        let alertModel = AlertModel (title: "Congratz!",
                                     message: "Try to beat ur record",
                                     buttonText: "Ofc" ) { [weak self] _ in
            guard let self = self else { return }
            self.boardServices.clearBoard()
        }
        victoryAlertPresenter?.requestShowVictoryAlert(alertModel: alertModel)
    }
}
//MARK: - AlertPresenterDelegates

extension GameViewController: VictoryAlertPresenterDelegate {
    func showVictoryAlert(alertController: UIAlertController?) {
        guard let alertController = alertController else { return }
        present(alertController, animated: true)
    }
}

extension GameViewController: LoseAlertPresenterDelegate {
    func showLoseAlert(alertController: UIAlertController?) {
        guard let alertController = alertController else { return }
        present(alertController, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension GameViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let itemWidth = (width - 50) / 4
        let itemHeight = (height - 50) / 4
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    
    
}

//MARK: - UICollectionViewDataSource

extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        boardServices.board[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        boardServices.board.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TileCell.identifier, for: indexPath)
                as? TileCell else { fatalError("Unable to dequeue TileCell") }
        let tile = boardServices.board[indexPath.section][indexPath.row]
        
        cell.configure(value: tile.value)
        
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        return cell
    }
}


