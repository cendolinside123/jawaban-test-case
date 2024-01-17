//
//  CaseOneViewController.swift
//  Case Bank
//
//  Created by Jan Sebastian on 16/01/24.
//

import UIKit
import PKHUD

class CaseOneViewController: UIViewController {
    
    private let vStackContent: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        return stackView
    }()
    
    private let viewNavbar = ViewNavbar()
    
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
    
    private let btnQR: UIButton = {
        let button = UIButton()
        button.setTitle("QR", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private let btnHistory: UIButton = {
        let button = UIButton()
        button.setTitle("History payment", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private var viewModelUserInfo: DummyUserInfoVm<UserInfoModel> = UserInfoViewModelImpl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupConstraints()
        setupAction()
        setupController()
        viewModelUserInfo.loadCurrentUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        vStackCoreContent.addArrangedSubview(lblNama)
        vStackCoreContent.addArrangedSubview(lblSaldo)
        vStackCoreContent.addArrangedSubview(btnQR)
        vStackCoreContent.addArrangedSubview(btnHistory)
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
        
        btnQR.translatesAutoresizingMaskIntoConstraints = false
        btnHistory.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: btnQR, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)]
        constraints += [NSLayoutConstraint(item: btnHistory, attribute: .height, relatedBy: .equal, toItem: btnQR, attribute: .height, multiplier: 1, constant: 0)]
        
        NSLayoutConstraint.activate(constraints)
    }

}

extension CaseOneViewController {
    
    private func setupController() {
        viewModelUserInfo.onLoading = {
            HUD.show(.progress, onView: self.view)
        }
        
        viewModelUserInfo.onSuccess = { [weak self] in
            if let getUserInfo = self?.viewModelUserInfo.userInfo {
                self?.lblNama.text = getUserInfo.nama
                let formatter = NumberFormatter()
                formatter.locale = Locale(identifier: "id_ID")
                formatter.numberStyle = .currency
                if let formattedTipAmount = formatter.string(from: getUserInfo.saldo as NSNumber) {
                    self?.lblSaldo.text = formattedTipAmount
                } else {
                    self?.lblSaldo.text = "-"
                }
            }
            HUD.hide()
        }
        
        viewModelUserInfo.onFailed = { [weak self] _ in
            HUD.hide()
            self?.lblSaldo.text = "-"
            self?.lblNama.text = "-"
        }
    }
    
    private func setupAction() {
        btnQR.addTarget(self, action: #selector(toScannerPage), for: .touchDown)
        btnHistory.addTarget(self, action: #selector(toHistoryPage), for: .touchDown)
        viewNavbar.onExit = {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func toScannerPage() {
        let vc = ScannerQRViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func toHistoryPage() {
        let vc = HstoryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
