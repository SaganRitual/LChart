import SwiftUI

struct LineChartLegendoidView: View {
    @State private var isOn = true

    let akConfig: LineChartConfiguration
    let legendCoordinates: AKPoint

    var body: some View {
        Toggle(akConfig.getLegendoid(at: legendCoordinates)!.text, isOn: $isOn)
            .toggleStyle(ColoredSquareToggle(akConfig: akConfig, legendCoordinates: legendCoordinates))
    }
}

struct LineChartLegendoidView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartLegendoidView(
            akConfig: LineChartBrowsingSuccess(),
            legendCoordinates: AKPoint(x: 0, y: 0)
        )
    }
}
