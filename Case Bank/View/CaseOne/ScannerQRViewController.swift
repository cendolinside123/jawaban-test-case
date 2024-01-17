//
//  ScannerQRViewController.swift
//  Case Bank
//
//  Created by Jan Sebastian on 16/01/24.
//

import UIKit

class ScannerQRViewController: UIViewController {
    
    private let vStackContent: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        return stackView
    }()
    
    private let viewNavbar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let btnExit: UIButton = {
        let button = UIButton()
        button.setTitle("Exit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.sizeToFit()
        return button
    }()
    
    private let viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let viewPreview: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let viewCature: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.001)
        view.layer.borderColor = UIColor.green.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.001)
        return view
    }()
    
    private let viewModelTransaksi: DummyTransactionVM<[TransactionLogModel]> = TransactionViewModelImpl()
    
    private var qrListenner: ScannerView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupConstraints()
        setupAction()
        bottomView.sizeToFit()
        setupQR()
        qrListenner?.start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        qrListenner?.start()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        qrListenner?.stop()
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
        self.view.backgroundColor = .black
        self.view.addSubview(vStackContent)
        vStackContent.addArrangedSubview(viewNavbar)
        viewNavbar.addSubview(btnExit)
        vStackContent.addArrangedSubview(viewContainer)
        viewContainer.addSubview(viewPreview)
        viewContainer.addSubview(viewCature)
        viewContainer.addSubview(bottomView) // dibuat jika ternyata perlu item" tertentu
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["vStackContent": vStackContent,
                                    "btnExit": btnExit,
                                    "bottomView": bottomView,
                                    "viewPreview": viewPreview]
        
        var constraints: [NSLayoutConstraint] = []
        
        vStackContent.translatesAutoresizingMaskIntoConstraints = false
        let h_vStackContent = "H:|-0-[vStackContent]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_vStackContent, options: .alignAllTop, metrics: nil, views: views)
        constraints += [NSLayoutConstraint(item: vStackContent, attribute: .top, relatedBy: .equal, toItem: view.layoutMarginsGuide, attribute: .top, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: vStackContent, attribute: .bottom, relatedBy: .equal, toItem: view.layoutMarginsGuide, attribute: .bottom, multiplier: 1, constant: 0)]
        
        viewNavbar.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: viewNavbar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)]
        
        btnExit.translatesAutoresizingMaskIntoConstraints = false
        let v_btnExit = "V:|-0-[btnExit]-0-|"
        let h_btnExit = "H:|-16-[btnExit]"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_btnExit, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_btnExit, options: .alignAllTop, metrics: nil, views: views)
        
        viewPreview.translatesAutoresizingMaskIntoConstraints = false
        let v_viewPreview = "V:|-0-[viewPreview]-0-|"
        let h_viewPreview = "H:|-0-[viewPreview]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_viewPreview, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_viewPreview, options: .alignAllTop, metrics: nil, views: views)
        
        viewCature.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: viewCature, attribute: .centerX, relatedBy: .equal, toItem: viewPreview, attribute: .centerX, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: viewCature, attribute: .centerY, relatedBy: .equal, toItem: viewPreview, attribute: .centerY, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: viewCature, attribute: .width, relatedBy: .equal, toItem: viewPreview, attribute: .width, multiplier: 2/3, constant: 0)]
        constraints += [NSLayoutConstraint(item: viewCature, attribute: .height, relatedBy: .equal, toItem: viewCature, attribute: .width, multiplier: 1, constant: 0)]
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        let h_bottomView = "H:|-0-[bottomView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_bottomView, options: .alignAllTop, metrics: nil, views: views)
        let constrainTop = NSLayoutConstraint(item: bottomView, attribute: .top, relatedBy: .equal, toItem: viewCature, attribute: .bottom, multiplier: 1, constant: 0)
        constrainTop.priority = UILayoutPriority(250)
        constraints += [constrainTop]
        constraints += [NSLayoutConstraint(item: bottomView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: bottomView, attribute: .bottom, relatedBy: .equal, toItem: viewPreview, attribute: .bottom, multiplier: 1, constant: 0)]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupQR() {
        viewContainer.layoutIfNeeded()
        viewCature.layoutIfNeeded()
        
        qrListenner = ScannerView(x: viewCature.frame.origin.x, y: viewCature.frame.origin.y, height: viewCature.bounds.height, width: viewCature.bounds.width, bounds: self.view.bounds)
        
        if let qrListenner {
            self.viewPreview.layer.addSublayer(qrListenner.getPreviewLayer())
            qrListenner.onError = { error in
                print("error: \(error.localizedDescription)")
            }
            
            qrListenner.onSuccess = { [weak self] message in
                
                print("message: \(message)")
                
                if let getCode =  self?.viewModelTransaksi.getDetailTransaction(text: message) {
                    let vc = PayViewController(transactionInfo: getCode)
                    vc.modalPresentationStyle = .overFullScreen
                    self?.present(vc, animated: true)
                } else {
                    
                }
            }
        }
        
        
    }

}

extension ScannerQRViewController {
    private func setupAction() {
        btnExit.addTarget(self, action: #selector(exitPage), for: .touchDown)
    }
    
    @objc private func exitPage() {
        self.navigationController?.popViewController(animated: true)
    }
}
