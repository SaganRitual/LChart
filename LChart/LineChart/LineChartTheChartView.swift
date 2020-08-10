import SwiftUI

struct LineChartTheChartView: View {
    let akConfig: LineChartConfiguration

    let scale: CGSize
    var timer: Timer!
    let xScale: CGFloat
    let yScale: CGFloat

    init(_ akConfig: LineChartConfiguration) {
        self.akConfig = akConfig
        self.xScale = ArkoniaLayout.xScale
        self.yScale = ArkoniaLayout.yScale
        self.scale = CGSize(width: xScale, height: yScale)

        scheduleUpdate()
    }

    func scheduleUpdate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: updateHistograms)
    }

    func updateHistograms() {
//        let L = Int.random(in: 1..<100)
//
//        (0..<L).forEach { _ in
//            let M = Double.random(in: 0..<1)
//            let N = self.data.histograms.randomElement()!
//            N.histogram.track(sample: M)
//        }
//
//        self.data.updateTrigger += 1
//        scheduleUpdate()
    }

    var body: some View {
        VStack {
            LineChartHeaderView(akConfig: akConfig)
                .padding(.top, 5)

            LineChartDataBackdrop(akConfig: akConfig)
                .padding(5)
                .background(Color.gray)
        }
    }
}
