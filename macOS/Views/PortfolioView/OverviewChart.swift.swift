//
//  OverviewChart.swift.swift
//  Returns (macOS)
//
//  Created by James Chen on 2021/11/10.
//

import SwiftUI
import Charts

struct OverviewChart: NSViewRepresentable {
    @State var portfolio: Portfolio

    typealias NSViewType = PieChartView

    func makeNSView(context: Context) -> PieChartView {
        let view = PieChartView()
        view.data = chartData
        return view
    }

    func updateNSView(_ nsView: PieChartView, context: Context) {
        nsView.data = chartData
    }
}

extension OverviewChart {
    var colors: [NSColor] {
        ChartColorTemplates.material()
    }

    var chartData: PieChartData {
        let entries = ChartData(portfolio: portfolio).totalAssetsData.map {
            name, balance in
            PieChartDataEntry(value: balance, label: name)
        }
        let dataSet = PieChartDataSet(entries: entries)
        dataSet.colors = colors
        return PieChartData(dataSets: [dataSet])
    }
}

struct OverviewChart_Previews: PreviewProvider {
    static var previews: some View {
        GrowthChart(portfolio: testPortfolio)
    }

    static var testPortfolio: Portfolio {
        let context = PersistenceController.preview.container.viewContext
        let portfolio = Portfolio(context: context)
        portfolio.name = "My Portfolio"
        var account = Account(context: context)
        account.name = "My Account #1"
        account.portfolio = portfolio
        account = Account(context: context)
        account.name = "My Account #2"
        account.portfolio = portfolio
        return portfolio
    }
}