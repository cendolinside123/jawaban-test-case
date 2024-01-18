//
//  ChartLineCollectionViewCell.swift
//  Case Bank
//
//  Created by Jan Sebastian on 18/01/24.
//

import UIKit
import DGCharts

class ChartLineCollectionViewCell: UICollectionViewCell {
    
    
    private var lineChart: LineChartView = {
        let view = LineChartView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(white: 1, alpha: 0.001)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(lineChart)
    }
    
    private func setupContraints() {
        let views: [String: Any] = ["lineChart": lineChart]
        var constraints: [NSLayoutConstraint] = []
        
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        let v_lineChart = "V:|-5-[lineChart]-5-|"
        let h_lineChart = "H:|-5-[lineChart]-5-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_lineChart, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_lineChart, options: .alignAllTop, metrics: nil, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension ChartLineCollectionViewCell {
    func setupView(value: DataLineModel) {
        
        var listItemChart: [ChartDataEntry] = []
        for index in 0...(value.month.count - 1) {
            listItemChart.append(ChartDataEntry(x: Double((index + 1)), y: Double(value.month[index])))
        }
        
        let setup = LineChartDataSet(entries: listItemChart, label: "Data per bulan")
        setup.drawIconsEnabled = false
        setup.lineDashLengths = [5, 2.5]
        setup.highlightLineDashLengths = [5, 2.5]
        setup.setColor(.black)
        setup.setCircleColor(.black)
        setup.gradientPositions = nil
        setup.lineWidth = 1
        setup.circleRadius = 3
        setup.drawCircleHoleEnabled = false
        setup.valueFont = .systemFont(ofSize: 9)
        setup.formLineDashLengths = [5, 2.5]
        setup.formLineWidth = 1
        setup.formSize = 15
        setup.drawValuesEnabled = true
        setup.valueTextColor = .black
        
        setup.drawFilledEnabled = false

        let value = ChartDataEntry(x: Double(3), y: 3)
        setup.addEntryOrdered(value)

        setup.fillAlpha = 1
        setup.drawFilledEnabled = false
        
        
        lineChart.legend.form = .line
        lineChart.legend.textColor = .black

        let data = LineChartData(dataSet: setup)
        lineChart.data = data
    }
}
