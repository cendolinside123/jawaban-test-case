//
//  ChartPieCollectionViewCell.swift
//  Case Bank
//
//  Created by Jan Sebastian on 18/01/24.
//

import UIKit
import DGCharts

class ChartPieCollectionViewCell: UICollectionViewCell {
    private var pieChart: PieChartView = {
        let view = PieChartView()
        return view
    }()
    
    var isCicked: (([DetailPortoModel]) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupContraints()
        pieChart.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(white: 1, alpha: 0.001)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(pieChart)
    }
    
    private func setupContraints() {
        let views: [String: Any] = ["pieChart": pieChart]
        var constraints: [NSLayoutConstraint] = []
        
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        let v_pieChart = "V:|-5-[pieChart]-5-|"
        let h_pieChart = "H:|-5-[pieChart]-5-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_pieChart, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_pieChart, options: .alignAllTop, metrics: nil, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension ChartPieCollectionViewCell {
    func setupView(value: [DataDonutModel]) {
        let entries = value.map({ (item) -> PieChartDataEntry in
            return PieChartDataEntry(value: Double(item.percentage) ?? 0, label: item.label, data: item.data)
        })
        
        let legend = pieChart.legend
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.xEntrySpace = 7
        legend.yEntrySpace = 0
        legend.yOffset = 0
        legend.textColor = .black
        
        pieChart.entryLabelColor = .black
        pieChart.entryLabelFont = .systemFont(ofSize: 12, weight: .light)
        
        let set = PieChartDataSet(entries: entries, label: "")
        set.sliceSpace = 2
        set.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.black)
        
        pieChart.data = data
        pieChart.highlightValues(nil)
        
        pieChart.drawHoleEnabled = false
        pieChart.drawCenterTextEnabled = false
    }
}
extension ChartPieCollectionViewCell: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if let data = entry.data as? [DetailPortoModel] {
            isCicked?(data)
        }
    }
}
