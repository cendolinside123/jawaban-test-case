//
//  ItemPayCollectionViewCell.swift
//  Case Bank
//
//  Created by Jan Sebastian on 16/01/24.
//

import UIKit

class ItemPayCollectionViewCell: UICollectionViewCell {
    
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
    
    private let lblHarga: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let hStackMiddleInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        return stackView
    }()
    
    private let hStackBottomInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        return stackView
    }()
    
    private let lblBank: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let lblTransactionId: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let lblNameMerchan: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let lblTanggal: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let lblStatusTransaksi: UILabel = {
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
        vStackContent.addArrangedSubview(lblHarga)
        vStackContent.addArrangedSubview(hStackMiddleInfo)
        hStackMiddleInfo.addArrangedSubview(lblBank)
        hStackMiddleInfo.addArrangedSubview(lblNameMerchan)
        vStackContent.addArrangedSubview(lblTransactionId)
        vStackContent.addArrangedSubview(hStackBottomInfo)
        hStackBottomInfo.addArrangedSubview(lblTanggal)
        hStackBottomInfo.addArrangedSubview(lblStatusTransaksi)
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
        
        lblBank.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: lblBank, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)]
        
        lblStatusTransaksi.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: lblStatusTransaksi, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension ItemPayCollectionViewCell {
    func setupValue(value: TransactionLogModel) {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: value.price as NSNumber) {
            lblHarga.text = formattedTipAmount
        } else {
            lblHarga.text = "-"
        }
        lblBank.text = value.bank
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "id_ID")
        let tanggal =  dateFormatter.string(from: value.tanggal)
        lblTanggal.text = tanggal
        lblNameMerchan.text = value.merchanName
        
        lblStatusTransaksi.text = value.status.rawValue
        
        if value.status == .Success {
            lblStatusTransaksi.textColor = .green
        } else {
            lblStatusTransaksi.textColor = .red
        }
    }
}
