//
//  ContentView.swift
//  LChart
//
//  Created by Rob Bishop on 8/9/20.
//

import SwiftUI

struct AKPoint {
    let x: Int
    let y: Int
}

struct LineChartLegendoidConfiguration {
    let color: Color
    let text: String
}

struct LineChartLegendConfiguration {
    let legendTitle: String
    let titleEdge: Edge
    let legendoids: [LineChartLegendoidConfiguration]
}

struct ContentView: View {
    var body: some View {
        LineChartLegendView(
            LineChartBrowsingSuccess(), AKPoint(x: 0, y: 0)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
