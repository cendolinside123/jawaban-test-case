//
//  CaseThreeViewController.swift
//  Case Bank
//
//  Created by Jan Sebastian on 16/01/24.
//

import UIKit
import DGCharts
import PKHUD

class CaseThreeViewController: UIViewController {
    
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
        collectionView.register(ChartPieCollectionViewCell.self, forCellWithReuseIdentifier: "pieCell")
        collectionView.register(ChartLineCollectionViewCell.self, forCellWithReuseIdentifier: "lineCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let viewModelPorto: DummyPortoVM<PortofolioList> = PortofolioViewModelImpl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
        setupConstraints()
        setupDelegate()
        setupAction()
        setupController()
        viewModelPorto.loadAllData()
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

extension CaseThreeViewController {
    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupAction() {
        viewNavbar.onExit = {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setupController() {
        
        viewModelPorto.onLoading = { [weak self] in
            HUD.show(.progress, onView: self?.view)
        }
        
        viewModelPorto.onSuccess = { [weak self] in
            self?.collectionView.reloadData()
            HUD.hide()
        }
        
        viewModelPorto.onError = {[weak self] _ in
            
            HUD.hide()
            
        }
    }
}

extension CaseThreeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelPorto.listData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = viewModelPorto.listData?[indexPath.item] else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
        }
        
        switch item.data {
        case .dataDataDonut(let pieData):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pieCell", for: indexPath) as? ChartPieCollectionViewCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
            }
            cell.isCicked = {[weak self] item in
                let vc = DetailPortoViewController(listData: item)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            cell.setupView(value: pieData)
            return cell
            
        case .dataLine(let lineData):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lineCell", for: indexPath) as? ChartLineCollectionViewCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
            }
            cell.setupView(value: lineData)
            return cell
        }
        
    }
    
    
}

extension CaseThreeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let item = viewModelPorto.listData?[indexPath.item] else {
            return .zero
        }
        
        switch item.data {
        case .dataDataDonut(_):
            return CGSize(width: self.collectionView.bounds.width, height: 450)
        case .dataLine(_):
            return CGSize(width: self.collectionView.bounds.width, height: 250)
        }
    }
}
