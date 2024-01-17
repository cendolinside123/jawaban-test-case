//
//  SplashScreenViewController.swift
//  Case Bank
//
//  Created by Jan Sebastian on 17/01/24.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    private let loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            loadingView.style = UIActivityIndicatorView.Style.medium
        } else {
            loadingView.style = UIActivityIndicatorView.Style.white
        }
        loadingView.color = .black
        loadingView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        loadingView.startAnimating()
        return loadingView
    }()
    
    private let lblWelcome: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.text = "welcome"
        label.font = UIFont.systemFont(ofSize: 27)
        label.sizeToFit()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupConstraint()
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
        self.view.addSubview(lblWelcome)
        self.view.addSubview(loadingView)
    }

    private func setupConstraint() {
        var constraints: [NSLayoutConstraint] = []
        
        lblWelcome.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: lblWelcome, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: lblWelcome, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)]
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: loadingView, attribute: .bottom, relatedBy: .equal, toItem: view.layoutMarginsGuide, attribute: .bottom, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: loadingView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 75)]
        constraints += [NSLayoutConstraint(item: loadingView, attribute: .height, relatedBy: .equal, toItem: loadingView, attribute: .width, multiplier: 1, constant: 0)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
