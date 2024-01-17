//
//  ViewNavbar.swift
//  Case Bank
//
//  Created by Jan Sebastian on 18/01/24.
//

import UIKit

class ViewNavbar: UIView {

    private let btnExit: UIButton = {
        let button = UIButton()
        button.setTitle("Exit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.sizeToFit()
        return button
    }()
    
    var onExit: (() -> Void)?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.backgroundColor = .white
        self.addSubview(btnExit)
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["btnExit": btnExit]
        
        var constraints: [NSLayoutConstraint] = []
        
        btnExit.translatesAutoresizingMaskIntoConstraints = false
        let v_btnExit = "V:|-0-[btnExit]-0-|"
        let h_btnExit = "H:|-16-[btnExit]"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_btnExit, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_btnExit, options: .alignAllTop, metrics: nil, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }

}

extension ViewNavbar {
    private func setupAction() {
        btnExit.addTarget(self, action: #selector(exitPage), for: .touchDown)
    }
    
    @objc private func exitPage() {
        onExit?()
    }
}
