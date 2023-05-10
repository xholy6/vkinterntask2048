//
//  TileCell.swift
//  2048g
//
//  Created by D on 09.05.2023.
//

import UIKit

final class TileCell: UICollectionViewCell {
    let label = UILabel()
    var background = UIColor()
    
    static let identifier = "Cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(value: Int) {
        label.text = value == 0 ? "" : "\(value)"
        contentView.backgroundColor = replaceColor(value: value)
    }
    
    func replaceColor(value: Int) -> UIColor {
        switch value {
        case 0:
            background = .gGray
        case 2:
            background = .two
        case 4:
            background = .four
        case 8:
            background = .eight
        case 16:
            background = .sixteen
        case 32:
            background = .thirtytwo
        case 64:
            background = .sixtyfour
        case 128:
            background = .onetwentyeight
        case 256:
            background = .twofiftysix
        case 512:
            background = .fivetwelve
        case 1024:
            background = .tentwentyfour
        case 2048:
            background = .twentyfourtyeight
        default:
            return .twentyfourtyeight
        }
        return background
    }
}
