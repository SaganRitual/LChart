import SwiftUI

struct LineChartDataBackdrop: View {
    let akConfig: LineChartConfiguration

    var body: some View {
        ZStack {
            GeometryReader { gr in
                Rectangle()
                    .foregroundColor(akConfig.chartBackdropColor)

                drawGridLines(gr, .horizontal)
                drawGridLines(gr, .vertical)

//                ForEach(0..<definitions.legend1Descriptor.legendoidDescriptors.count) { ss in
//                    LineChartLineView(
//                        color: definitions.legend1Descriptor.legendoidDescriptors[ss].0,
//                        viewWidth: gr.size.width, viewHeight: gr.size.height
//                    ).environmentObject(data.histograms[ss])
//                }
//
//                ForEach(0..<definitions.legend2Descriptor.legendoidDescriptors.count) { ss in
//                    LineChartLineView(
//                        color: definitions.legend1Descriptor.legendoidDescriptors[ss].0,
//                        viewWidth: gr.size.width, viewHeight: gr.size.height
//                    ).environmentObject(data.histograms[ss + definitions.legend1Descriptor.legendoidDescriptors.count])
//                }
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
