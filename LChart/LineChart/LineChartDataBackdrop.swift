import SwiftUI

struct LineChartDataBackdrop: View {
    @Binding var isOn: Bool

    let akConfig: LineChartConfiguration
    let firstLeft, lastLeft: Int?
    let firstRight, lastRight: Int?
    let legendCoordinates: AKPoint
    let liveLegendoidPositions: [AKPoint]

    init(_ akConfig: LineChartConfiguration, _ legendCoordinates: AKPoint) {
        self.akConfig = akConfig

        self.liveLegendoidPositions =
            LineChartLegendView.getLiveLegendoidPositions(akConfig, legendCoordinates)

        if let FL = self.liveLegendoidPositions.firstIndex(where: { $0.x == 0 }) {
            self.firstLeft = FL
            self.lastLeft = self.liveLegendoidPositions.lastIndex(where: { $0.x == 0 })!
        }

        if let FR = self.liveLegendoidPositions.firstIndex(where: { $0.x == 1}) {
            self.firstRight = FR
            self.lastRight = self.liveLegendoidPositions.lastIndex(where: { $0.x == 1 })!
        }
    }

    var body: some View {
        ZStack {
            GeometryReader { gr in
                Rectangle()
                    .foregroundColor(akConfig.chartBackdropColor)

                drawGridLines(gr, .horizontal)
                drawGridLines(gr, .vertical)

                ForEach((firstLeft ?? 0)..<(lastLeft ?? 0)) { ss in
                    LineChartLineView(
                        isOn: $isOn, color: akConfig.getLegend(at: liveLegendoidPositions[ss])!.color,
                        viewWidth: gr.size.width, viewHeight: gr.size.height
                    )
                }

                ForEach((firstRight ?? 0)..<(lastRight ?? 0)) { ss in
                    LineChartLineView(
                        viewWidth: gr.size.width, viewHeight: gr.size.height
                    )
                }
            }
        }
    }
}

extension LineChartDataBackdrop {

    func drawGridLines(
        _ gProxy: GeometryProxy, _ direction: GridLinesDirection
    ) -> some View {
        let (rectWidth, rectHeight) = direction == .vertical ?
            (gProxy.size.width, 0) : (0, gProxy.size.height)

        return ForEach(0..<(5 + 1)) { ss in
            Path { path in
                if direction == .vertical {
                    path.move(
                        to: CGPoint(x: CGFloat(ss * 2) * rectWidth / 10, y: 0)
                    )

                    path.addLine(
                        to: CGPoint(x: CGFloat(ss * 2) * rectWidth / 10, y: gProxy.size.height)
                    )
                } else {
                    path.move(
                        to: CGPoint(x: 0, y: CGFloat(ss * 2) * rectHeight / 10)
                    )

                    path.addLine(
                        to: CGPoint(x: gProxy.size.width, y: CGFloat(ss * 2) * rectHeight / 10)
                    )
                }

                path.closeSubpath()
            }
            .stroke(lineWidth: 1).foregroundColor((.black))
        }
    }

}
