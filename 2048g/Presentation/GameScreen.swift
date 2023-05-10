import UIKit

final class GameScreen: UIView {

    
    private lazy var currentScoreLabel = {
        let label = UILabel()
        label.text = "Score"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20 , weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bestScoreLabel = {
        let label = UILabel()
        label.text = "Record"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var gameIcon = {
        let image = UIImageView()
        image.image = UIImage(named: "Pepega")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var scoreLabelBackground = {
        let view = UIView()
        view.backgroundColor = .gGray
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bestLabelBackground = {
        let view = UIView()
        view.backgroundColor = .gGray
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCurrentScoreLabel(_ score: Int) {
        currentScoreLabel.text = "Score: \n     \(score)"
    }
    
    func updateBestScoreLabel(_ score: Int) {
        bestScoreLabel.text = "Best: \n     \(score)"
    }
    
    private func setupView() {
        self.addSubview(scoreLabelBackground)
        self.addSubview(bestLabelBackground)
        self.addSubview(currentScoreLabel)
        self.addSubview(bestScoreLabel)
        self.addSubview(gameIcon)
        
        NSLayoutConstraint.activate([
            bestLabelBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            bestLabelBackground.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            bestLabelBackground.widthAnchor.constraint(equalToConstant: 100),
            bestLabelBackground.heightAnchor.constraint(equalToConstant: 100),

            scoreLabelBackground.trailingAnchor.constraint(equalTo: bestLabelBackground.leadingAnchor, constant: -15),
            scoreLabelBackground.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            scoreLabelBackground.widthAnchor.constraint(equalToConstant: 100),
            scoreLabelBackground.heightAnchor.constraint(equalToConstant: 100),

            
            bestScoreLabel.centerXAnchor.constraint(equalTo: bestLabelBackground.centerXAnchor),
            bestScoreLabel.centerYAnchor.constraint(equalTo: bestLabelBackground.centerYAnchor),
            
            currentScoreLabel.centerXAnchor.constraint(equalTo: scoreLabelBackground.centerXAnchor),
            currentScoreLabel.centerYAnchor.constraint(equalTo: scoreLabelBackground.centerYAnchor),
            
            gameIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            gameIcon.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            gameIcon.widthAnchor.constraint(equalToConstant: 100),
            gameIcon.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
