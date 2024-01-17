//
//  DetailPortoViewController.swift
//  Case Bank
//
//  Created by Jan Sebastian on 18/01/24.
//

import UIKit

class DetailPortoViewController: UIViewController {
    
    private let vStackContent: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        return stackView
    }()
    
    private let viewNavbar = ViewNavbar()
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        collectionView.register(DetailPortoCollectionViewCell.self, forCellWithReuseIdentifier: "detailCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private var listData: [DetailPortoModel] = []
    
    
    init(listData: [DetailPortoModel]) {
        super.init(nibName: nil, bundle: nil)
        self.listData = listData
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupConstraints()
        setupDelegate()
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
        vStackContent.addArrangedSubview(viewNavbar)
        vStackContent.addArrangedSubview(collectionView)
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["vStackContent": vStackContent]
        
        var constraints: [NSLayoutConstraint] = []
        
        vStackContent.translatesAutoresizingMaskIntoConstraints = false
        let h_vStackContent = "H:|-0-[vStackContent]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_vStackContent, options: .alignAllTop, metrics: nil, views: views)
        constraints += [NSLayoutConstraint(item: vStackContent, attribute: .top, relatedBy: .equal, toItem: view.layoutMarginsGuide, attribute: .top, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: vStackContent, attribute: .bottom, relatedBy: .equal, toItem: view.layoutMarginsGuide, attribute: .bottom, multiplier: 1, constant: 0)]
        
        viewNavbar.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: viewNavbar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)]
        NSLayoutConstraint.activate(constraints)
    }

}

extension DetailPortoViewController {
    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupAction() {
        viewNavbar.onExit = {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

extension DetailPortoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as? DetailPortoCollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
        }
        let data =  listData[indexPath.item]
        cell.setupValue(value: data)
        return cell
    }
}

extension DetailPortoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: self.collectionView.bounds.width, height: 60)
    }
}
