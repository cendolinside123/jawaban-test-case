//
//  PayViewController.swift
//  Case Bank
//
//  Created by Jan Sebastian on 18/01/24.
//

import UIKit
import PKHUD

class PayViewController: UIViewController {
    
    
    private let vStackContent: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        return stackView
    }()
    
    private let viewNavbar = ViewNavbar()
    
    private let lblNama: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 35)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let lblSaldo: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 35)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let lblStatus: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 35)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        return scrollView
    }()
    
    private let vStackCoreContent: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let vStackItemPay: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let lblBank: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let lblHarga: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let lblTransactionCode: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let lblMerchanName: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let vStackButton: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let btnCancel: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private let btnPay: UIButton = {
        let button = UIButton()
        button.setTitle("Pay", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private let viewModelTransaksi: DummyTransactionVM<[TransactionLogModel]> = TransactionViewModelImpl()
    private let viewModelUserInfo: DummyUserInfoVm<UserInfoModel> = UserInfoViewModelImpl()
    
    
    private var transactionInfo: TransactionInfoModel?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(transactionInfo: TransactionInfoModel) {
        super.init(nibName: nil, bundle: nil)
        self.transactionInfo = transactionInfo
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupConstraints()
        setupAction()
        setupController()
        setupAction()
        setupTransaksiDisplay()
        viewModelUserInfo.loadCurrentUser()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(vStackContent)
        vStackContent.addArrangedSubview(viewNavbar)
        vStackContent.addArrangedSubview(scrollView)
        scrollView.addSubview(vStackCoreContent)
        vStackCoreContent.addArrangedSubview(lblStatus)
        vStackCoreContent.addArrangedSubview(lblNama)
        vStackCoreContent.addArrangedSubview(lblSaldo)
        vStackCoreContent.addArrangedSubview(vStackItemPay)
        vStackItemPay.addArrangedSubview(lblHarga)
        vStackItemPay.addArrangedSubview(lblMerchanName)
        vStackItemPay.addArrangedSubview(lblTransactionCode)
        vStackItemPay.addArrangedSubview(lblBank)
        vStackCoreContent.addArrangedSubview(vStackButton)
        vStackButton.addArrangedSubview(btnCancel)
        vStackButton.addArrangedSubview(btnPay)
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["vStackContent": vStackContent,
                                    "vStackCoreContent": vStackCoreContent]
        
        var constraints: [NSLayoutConstraint] = []
        
        vStackContent.translatesAutoresizingMaskIntoConstraints = false
        let h_vStackContent = "H:|-0-[vStackContent]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_vStackContent, options: .alignAllTop, metrics: nil, views: views)
        constraints += [NSLayoutConstraint(item: vStackContent, attribute: .top, relatedBy: .equal, toItem: view.layoutMarginsGuide, attribute: .top, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: vStackContent, attribute: .bottom, relatedBy: .equal, toItem: view.layoutMarginsGuide, attribute: .bottom, multiplier: 1, constant: 0)]
        
        viewNavbar.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: viewNavbar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)]
        
        
        vStackCoreContent.translatesAutoresizingMaskIntoConstraints = false
        let v_vStackCoreContent = "V:|-0-[vStackCoreContent]-0-|"
        let h_vStackCoreContent = "H:|-0-[vStackCoreContent]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_vStackCoreContent, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_vStackCoreContent, options: .alignAllTop, metrics: nil, views: views)
        constraints += [NSLayoutConstraint(item: vStackCoreContent, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0)]
        
        vStackButton.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: vStackButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)]
        
        NSLayoutConstraint.activate(constraints)
    }

}

extension PayViewController {
    
    private func setupTransaksiDisplay() {
        if let transactionInfo {
            lblBank.text = transactionInfo.bank
            lblTransactionCode.text = transactionInfo.transactionID
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "id_ID")
            formatter.numberStyle = .currency
            if let formattedTipAmount = formatter.string(from: transactionInfo.price as NSNumber) {
                lblHarga.text = formattedTipAmount
            } else {
                lblHarga.text = "-"
            }
            lblMerchanName.text = transactionInfo.merchanName
        }
    }
    
    private func setupAction() {
        viewNavbar.onExit = {[weak self] in
            self?.dismiss(animated: true)
        }
        btnPay.addTarget(self, action: #selector(doingPay), for: .touchDown)
        btnCancel.addTarget(self, action: #selector(exitPage), for: .touchDown)
    }
    
    @objc private func exitPage() {
        self.dismiss(animated: true)
    }
    
    @objc private func doingPay() {
        if let transactionInfo {
            viewModelUserInfo.updateSaldo(bayar: transactionInfo.price)
        }
    }
}

extension PayViewController {
    
    private func setupController() {
        
        viewModelTransaksi.onLoading = { [weak self] in
            HUD.show(.progress, onView: self?.view)
            
        }
        
        viewModelTransaksi.onSuccess = { [weak self] in
            HUD.hide()
            self?.btnPay.isEnabled = false
            self?.btnCancel.isEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self?.dismiss(animated: true)
            })
        }
        
        viewModelTransaksi.onError = { [weak self] error in
            HUD.hide()
            let alert = UIAlertController(title: "error", message: " terjadi issue: \(error.localizedDescription)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "close", style: .cancel))
            self?.present(alert, animated: true)
        }
        
        viewModelUserInfo.onLoading = { [weak self] in
            HUD.show(.progress, onView: self?.view)
            
        }
        
        viewModelUserInfo.onSuccess = { [weak self] in
            self?.lblStatus.text = "Transaksi berhasil"
            if let userInfo = self?.viewModelUserInfo.userInfo {
                self?.lblNama.text = userInfo.nama
                let formatter = NumberFormatter()
                formatter.locale = Locale(identifier: "id_ID")
                formatter.numberStyle = .currency
                if let formattedTipAmount = formatter.string(from: userInfo.saldo as NSNumber) {
                    self?.lblSaldo.text = formattedTipAmount
                } else {
                    self?.lblSaldo.text = "-"
                }
            }
        }
        
        viewModelUserInfo.onSuccessUpdate = { [weak self] in
            HUD.hide()
            self?.lblStatus.text = "Transaksi gagal"
            if let userInfo = self?.viewModelUserInfo.userInfo {
                self?.lblNama.text = userInfo.nama
                let formatter = NumberFormatter()
                formatter.locale = Locale(identifier: "id_ID")
                formatter.numberStyle = .currency
                if let formattedTipAmount = formatter.string(from: userInfo.saldo as NSNumber) {
                    self?.lblSaldo.text = formattedTipAmount
                } else {
                    self?.lblSaldo.text = "-"
                }
            }
            
            if let getTransaksi = self?.transactionInfo {
                let transaksi = TransactionInfoModel(bank: getTransaksi.bank, transactionID: getTransaksi.transactionID, merchanName: getTransaksi.merchanName, price: -getTransaksi.price)
                self?.viewModelTransaksi.inputTransactionData(input: (transaksi, TransactionState.Success))
            }
        }
        
        
        viewModelUserInfo.onFailed = { [weak self] _ in
            HUD.hide()
            if let getTransaksi = self?.transactionInfo {
                let transaksi = TransactionInfoModel(bank: getTransaksi.bank, transactionID: getTransaksi.transactionID, merchanName: getTransaksi.merchanName, price: -getTransaksi.price)
                self?.viewModelTransaksi.inputTransactionData(input: (transaksi, TransactionState.Failed))
            }
        }
    }
}
