import SwiftUI

struct ColoredSquareToggle: ToggleStyle {
    @Binding var isOn: Bool {
        willSet { print("will set to \(newValue)") }
    }

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

            Button(action: {
                isOn.toggle()
            }) {
                Rectangle()
                    .foregroundColor(isOn ? self.color : Color.gray)
                    .border(Color.black, width: 2)
                    .frame(width: 16, height: 16)
            }
            .buttonStyle(PlainButtonStyle())

            Text(labelText).foregroundColor(isOn ? Color.white : Color.gray)
        }
    }
}
