//
//  HomeViewController.swift
//  Case Bank
//
//  Created by Jan Sebastian on 16/01/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let lblNavBar: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.text = "welcome"
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    private let vStackContent: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
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
    
    private let btnCaseOne: UIButton = {
        let button = UIButton()
        button.setTitle("Case Study 1", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    private let btnCaseTwo: UIButton = {
        let button = UIButton()
        button.setTitle("Case Study 2", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    private let btnCaseThree: UIButton = {
        let button = UIButton()
        button.setTitle("Case Study 3", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    private let btnCaseFour: UIButton = {
        let button = UIButton()
        button.setTitle("Case Study 4", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
        setupConstraints()
        setupAction()
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
        vStackContent.addArrangedSubview(lblNavBar)
        vStackContent.addArrangedSubview(scrollView)
        scrollView.addSubview(vStackCoreContent)
        vStackCoreContent.addArrangedSubview(btnCaseOne)
        vStackCoreContent.addArrangedSubview(btnCaseTwo)
        vStackCoreContent.addArrangedSubview(btnCaseThree)
        vStackCoreContent.addArrangedSubview(btnCaseFour)
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
        
        lblNavBar.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: lblNavBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)]
        
        vStackCoreContent.translatesAutoresizingMaskIntoConstraints = false
        let v_vStackCoreContent = "V:|-0-[vStackCoreContent]-0-|"
        let h_vStackCoreContent = "H:|-0-[vStackCoreContent]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_vStackCoreContent, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_vStackCoreContent, options: .alignAllTop, metrics: nil, views: views)
        constraints += [NSLayoutConstraint(item: vStackCoreContent, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0)]
        
        btnCaseOne.translatesAutoresizingMaskIntoConstraints = false
        btnCaseTwo.translatesAutoresizingMaskIntoConstraints = false
        btnCaseThree.translatesAutoresizingMaskIntoConstraints = false
        btnCaseFour.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: btnCaseOne, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)]
        constraints += [NSLayoutConstraint(item: btnCaseTwo, attribute: .height, relatedBy: .equal, toItem: btnCaseOne, attribute: .height, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: btnCaseThree, attribute: .height, relatedBy: .equal, toItem: btnCaseOne, attribute: .height, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: btnCaseFour, attribute: .height, relatedBy: .equal, toItem: btnCaseOne, attribute: .height, multiplier: 1, constant: 0)]
        
        NSLayoutConstraint.activate(constraints)
        
    }

}

extension HomeViewController {
    
    private func setupAction() {
        btnCaseOne.addTarget(self, action: #selector(toCaseStudeOne), for: .touchDown)
        btnCaseTwo.addTarget(self, action: #selector(toCaseStudeTwo), for: .touchDown)
        btnCaseThree.addTarget(self, action: #selector(toCaseStudeThree), for: .touchDown)
        btnCaseFour.addTarget(self, action: #selector(toCaseStudeFour), for: .touchDown)
    }
    
    @objc private func toCaseStudeOne() {
        let vc = CaseOneViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func toCaseStudeTwo() {
        let vc = CaseTwoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func toCaseStudeThree() {
        let vc = CaseThreeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func toCaseStudeFour() {
        let alert = UIAlertController(title: "Note", message: "Study Case no 4 tidak bisa dilakukan karena untuk penerannya memerlukan akun subscription apple developer agak feature push notif , apns tersedia", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "close", style: .cancel))
        self.present(alert, animated: true)
    }
}
