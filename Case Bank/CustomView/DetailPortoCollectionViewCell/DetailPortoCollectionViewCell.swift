//
//  DetailPortoCollectionViewCell.swift
//  Case Bank
//
//  Created by Jan Sebastian on 18/01/24.
//

import UIKit

class DetailPortoCollectionViewCell: UICollectionViewCell {
    
    private let viewCover: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private let hStackContent: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        stackView.spacing = 10
        return stackView
    }()
    
    private let lblTrx: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private let lblNominal: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
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
        viewCover.addSubview(hStackContent)
        hStackContent.addArrangedSubview(lblTrx)
        hStackContent.addArrangedSubview(lblNominal)
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["viewCover": viewCover,
                                    "hStackContent": hStackContent]
        
        var constraints: [NSLayoutConstraint] = []
        
        viewCover.translatesAutoresizingMaskIntoConstraints = false
        let v_viewCover = "V:|-8-[viewCover]-8-|"
        let h_viewCover = "H:|-5-[viewCover]-5-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_viewCover, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_viewCover, options: .alignAllTop, metrics: nil, views: views)
        
        hStackContent.translatesAutoresizingMaskIntoConstraints = false
        let v_hStackContent = "V:|-5-[hStackContent]-5-|"
        let h_hStackContent = "H:|-5-[hStackContent]-5-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_hStackContent, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_hStackContent, options: .alignAllTop, metrics: nil, views: views)
        
        lblTrx.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: lblTrx, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension DetailPortoCollectionViewCell {
    func setupValue(value: DetailPortoModel) {
        lblTrx.text = value.trxDate
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: value.nominal as NSNumber) {
            lblNominal.text = formattedTipAmount
        } else {
            lblNominal.text = "-"
        }
    }
}
