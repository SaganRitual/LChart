import SwiftUI

struct LineChartHeaderView: View {

    let akConfig: LineChartConfiguration

    var body: some View {
        VStack {
            Text(akConfig.chartTitle)
                .font(.caption)
                .foregroundColor(.white)

            HStack {
                LineChartLegendView(akConfig, AKPoint(x: 0, y: 0))
                    .frame(maxWidth: .infinity)

                Spacer()

                LineChartLegendView(akConfig, AKPoint(x: 1, y: 0))
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct LineChartHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartHeaderView(akConfig: LineChartBrowsingSuccess())
    }
}
