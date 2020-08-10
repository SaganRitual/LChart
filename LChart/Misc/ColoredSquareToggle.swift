import SwiftUI

struct ColoredSquareToggle: ToggleStyle {
    let akConfig: LineChartConfiguration
    let legendCoordinates: AKPoint

    var color: Color {
        let x = legendCoordinates.x, y = legendCoordinates.y
        return akConfig.legends[x].legendoids[y].color
    }

    var labelText: String {
        let x = legendCoordinates.x, y = legendCoordinates.y
        return akConfig.legends[x].legendoids[y].text
    }

    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Rectangle()
                .foregroundColor(self.color)
                .border(Color.black, width: 2)
                .frame(width: 16, height: 16)

            Text(labelText)
        }
    }
}
