import SwiftUI

struct LineChartLineView: View {
    @Binding var isOn: Bool

    let color: Color
    let viewWidth: CGFloat
    let viewHeight: CGFloat

    func drawLine() -> Path {
        var path = Path()
        if !isOn { return path }

        guard let yValues = data.histogram.getScalarDistribution(reset: false) else {
            return path
        }

        let points: [CGPoint] = zip(Int(0)..., yValues).map {
            let p1 = CGPoint(x: CGFloat($0), y: $1)
            let p2 = CGPoint(x: 1.175 / 10 * viewWidth, y: -viewHeight)
            let p3 = CGPoint(x: 0, y: viewHeight)

            return p1 * p2 + p3
        }

        path.move(to: points[0])

        for (previousPoint, currentPoint) in zip(points.dropLast(), points.dropFirst()) {
            let midPoint = (previousPoint + currentPoint) / 2
            path.addQuadCurve(to: midPoint, control: previousPoint)
        }

        return path
    }

    var body: some View {
        GeometryReader { gr in
            drawLine()
                .stroke(lineWidth: 3)
                .foregroundColor(color)
                .opacity(data.isVisible ? 1 : 0)
        }
    }
}

struct LineChartLineView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartLineView(
            color: Color.blue,
            viewWidth: ArkoniaLayout.xScale,
            viewHeight: ArkoniaLayout.yScale
        ).environmentObject(LineChartHistogram())
    }
}
