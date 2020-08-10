import SwiftUI

protocol LineChartConfiguration {
    var chartTitle: String { get }
    var legends: [LineChartLegendConfiguration] { get }

    func getLegend(at: AKPoint) -> LineChartLegendConfiguration?
    func getLegendoid(at: AKPoint) -> LineChartLegendoidConfiguration?
}

struct LineChartBrowsingSuccess: LineChartConfiguration {
    let chartTitle = "Browsing Success"

    func getLegend(at: AKPoint) -> LineChartLegendConfiguration? {
        legends.count > at.x ? legends[at.x] : nil
    }

    func getLegendoid(at position: AKPoint) -> LineChartLegendoidConfiguration? {
        guard let legend = getLegend(at: position) else { return nil }
        return legend.legendoids.count > position.y ? legend.legendoids[position.y] : nil
    }

    let legends = [
        LineChartLegendConfiguration(
            legendTitle: "Current",
            titleEdge: .leading,
            legendoids: [
                LineChartLegendoidConfiguration(color: .red, text: "Max"),
                LineChartLegendoidConfiguration(color: .green, text: "Avg")
            ]
        ),

        LineChartLegendConfiguration(
            legendTitle: "All-Time",
            titleEdge: .trailing,
            legendoids: [
                LineChartLegendoidConfiguration(color: .blue, text: "Max"),
                LineChartLegendoidConfiguration(color: .orange, text: "Avg")
            ]
        ),
    ]
}
