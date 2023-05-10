import UIKit

protocol VictoryAlertPresenterProtocol: AnyObject {
    func requestShowVictoryAlert(alertModel: AlertModel?)
}

protocol VictoryAlertPresenterDelegate: AnyObject {
    func showVictoryAlert(alertController: UIAlertController?)
}

final class VictoryAlertPresenter {
    private weak var delegate: VictoryAlertPresenterDelegate?
    
    init(delegate: VictoryAlertPresenterDelegate) {
        self.delegate = delegate
    }
}

extension VictoryAlertPresenter: VictoryAlertPresenterProtocol {
    func requestShowVictoryAlert(alertModel: AlertModel?) {
        let vc = UIAlertController(title: alertModel?.title,
                                   message: alertModel?.message,
                                   preferredStyle: .alert)
        
        let action = UIAlertAction(title: alertModel?.buttonText,
                                   style: .default,
                                   handler: alertModel?.completion)
        
        vc.addAction(action)
        delegate?.showVictoryAlert(alertController: vc)
        
    }
}
