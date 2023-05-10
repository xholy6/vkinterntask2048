import UIKit

protocol LoseAlertPresenterProtocol: AnyObject {
    func requestShowLoseAlert(alertModel: AlertModel?)
}

protocol LoseAlertPresenterDelegate: AnyObject {
    func showLoseAlert(alertController: UIAlertController?)
}

final class LoseAlertPresenter {
    private weak var delegate: LoseAlertPresenterDelegate?
    
    init(delegate: LoseAlertPresenterDelegate) {
        self.delegate = delegate
    }
}

extension LoseAlertPresenter: LoseAlertPresenterProtocol {
    func requestShowLoseAlert(alertModel: AlertModel?) {
        let vc = UIAlertController(title: alertModel?.title,
                                   message: alertModel?.message,
                                   preferredStyle: .alert)
        
        let action = UIAlertAction(title: alertModel?.buttonText,
                                   style: .default,
                                   handler: alertModel?.completion)
        
        vc.addAction(action)
        delegate?.showLoseAlert(alertController: vc)
        
    }
}
