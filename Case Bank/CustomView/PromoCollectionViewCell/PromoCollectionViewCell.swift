//
//  PromoCollectionViewCell.swift
//  Case Bank
//
//  Created by Jan Sebastian on 18/01/24.
//

import UIKit

class PromoCollectionViewCell: UICollectionViewCell {
    
    private let viewCover: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private let vStackContent: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        return stackView
    }()
    
    private let imgPromo: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        return image
    }()
    
    private let lblTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(white: 1, alpha: 0.001)
        self.contentView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        self.contentView.addSubview(viewCover)
        viewCover.addSubview(vStackContent)
        vStackContent.addArrangedSubview(imgPromo)
        vStackContent.addArrangedSubview(lblTitle)
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["viewCover": viewCover,
                                    "vStackContent": vStackContent]
        
        var constraints: [NSLayoutConstraint] = []
        
        viewCover.translatesAutoresizingMaskIntoConstraints = false
        let v_viewCover = "V:|-8-[viewCover]-8-|"
        let h_viewCover = "H:|-5-[viewCover]-5-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_viewCover, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_viewCover, options: .alignAllTop, metrics: nil, views: views)
        
        vStackContent.translatesAutoresizingMaskIntoConstraints = false
        let v_vStackContent = "V:|-5-[vStackContent]-5-|"
        let h_vStackContent = "H:|-5-[vStackContent]-5-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_vStackContent, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_vStackContent, options: .alignAllTop, metrics: nil, views: views)
        
        imgPromo.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: imgPromo, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120)]
    }
    
    
    
}
