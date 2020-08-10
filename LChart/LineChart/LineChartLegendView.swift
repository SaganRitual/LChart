import SwiftUI

struct LineChartLegendView: View {
//    let data: LineChartData

    let akConfig: LineChartConfiguration
    let checkLeft: Bool
    let legendCoordinates: AKPoint

    static let legendoidPositions = [
        AKPoint(x: 0, y: 0), AKPoint(x: 0, y: 1), AKPoint(x: 0, y: 2),
        AKPoint(x: 1, y: 0), AKPoint(x: 1, y: 1), AKPoint(x: 1, y: 2)
    ]

    let liveLegendoidPositions: [AKPoint]

    init(_ akConfig: LineChartConfiguration, _ legendCoordinates: AKPoint) {
        self.akConfig = akConfig
        self.legendCoordinates = legendCoordinates

        self.checkLeft = legendCoordinates.x == 0

        // Figure out which legendoids we'll be displaying
        liveLegendoidPositions =
            LineChartLegendView.getLiveLegendoidPositions(akConfig, legendCoordinates)
    }

    static func getLiveLegendoidPositions(
        _ akConfig: LineChartConfiguration,
        _ legendCoordinates: AKPoint
    ) -> [AKPoint] {
        return legendoidPositions.compactMap {
            if $0.x != legendCoordinates.x { return nil }
            return akConfig.getLegendoid(at: $0) == nil ? nil : $0
        }
    }

    func getLegendText() -> some View {
        if akConfig.getLegend(at: legendCoordinates)!.titleEdge == (checkLeft ? .leading : .trailing) {
            return AnyView(Text(akConfig.getLegend(at: legendCoordinates)!.legendTitle)
                    .font(.footnote)
                    .padding(checkLeft ? .trailing : .leading)
            )
        } else {
            return AnyView(EmptyView())
        }
    }

    func buildLeftLegendIf() -> some View {
        if liveLegendoidPositions[0].x != 0 { return AnyView(EmptyView()) }
        if akConfig.getLegend(at: legendCoordinates)!.titleEdge != .leading { return AnyView(EmptyView()) }

        let leftLegendPositions = liveLegendoidPositions.compactMap { $0.x == 0 ? $0 : nil }
        if leftLegendPositions.isEmpty { return AnyView(EmptyView()) }

        return AnyView(getLegendText())
    }

    func buildRightLegendIf() -> some View {
        if liveLegendoidPositions.last!.x != 1 { return AnyView(EmptyView()) }
        if akConfig.getLegend(at: legendCoordinates)!.titleEdge != .trailing { return AnyView(EmptyView()) }

        let rightLegendPositions = liveLegendoidPositions.compactMap { $0.x == 1 ? $0 : nil }
        if rightLegendPositions.isEmpty { return AnyView(EmptyView()) }

        return AnyView(getLegendText())
    }

    func buildControls() -> some View {
        let theInt = checkLeft ? 0 : 1
        let positions = liveLegendoidPositions.compactMap { $0.x == theInt ? $0 : nil }
        if positions.isEmpty { return AnyView(EmptyView()) }

        return AnyView(
            HStack(alignment: .center) {
                if checkLeft { buildLeftLegendIf() }

                VStack(alignment: .center) {
                    ForEach(0..<positions.count) { ss in
                        LineChartLegendoidView(
                            akConfig: self.akConfig,
                            legendCoordinates: positions[ss]
                        )
                    }.padding([.leading, .trailing], 5)
                }

                if !checkLeft { buildRightLegendIf() }
            }
        )
    }

    var body: some View { buildControls() }
}

struct LineChartLegend_Previews: PreviewProvider {
    static var previews: some View {
        LineChartLegendView(LineChartBrowsingSuccess(), AKPoint(x: 0, y: 0))
    }
}
