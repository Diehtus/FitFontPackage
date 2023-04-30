//
//  FitFont.swift
//
//
//  Created by Dustin Weise on 16.08.22.
//

import SwiftUI

/// Passt einen `Text` an die übergeordnete `View` an.
///
/// Bei der Anpassung wird die Textgröße in Abhängigkeit von `lineLimit` an die Breite der übergeordneten `View` angepasst.
/// Dabei kann weiter die Schriftgröße, Schriftdicke, Schriftart angepasst werden.
/// Zusätzlich lässt sich die Darstellung prozentual über den Skalierungsfaktor und prozentualen Anteil anpassen.
///
/// **Beispiel mit Parameter**
/// ```swift
/// Text("Hallo Welt")
///     .modifier(FitFont(lineLimit: 1, fontSize: .greatestFiniteMagnitude, fontWeight: .regular, fontDesign: .default, minimumScaleFactor: 0.01, percentage: 1))
/// ```
///
/// **Beispiel ohne Parameter**
/// ```swift
/// Text("Hallo Welt")
///     .modifier(FitFont())
/// ```
///
/// - Requires: `SwiftUI`
/// - Author: Dustin Weise
/// - Copyright: © 2021 by Dustin Weise
public struct FitFont: ViewModifier {
    public var lineLimit: Int?
    public var fontSize: CGFloat?
    public var fontWeight: Font.Weight
    public var fontDesign: Font.Design
    public var minimumScaleFactor: CGFloat
    public var percentage: CGFloat
    
    public init(lineLimit: Int? = nil, fontSize: CGFloat? = nil, fontWeight: Font.Weight = .regular, fontDesign: Font.Design = .default, minimumScaleFactor: CGFloat = 0.01, percentage: CGFloat = 1) {
        self.lineLimit = lineLimit
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.fontDesign = fontDesign
        self.minimumScaleFactor = minimumScaleFactor
        self.percentage = percentage
    }
    
    public func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .font(.system(size: min(min(geometry.size.width, geometry.size.height) * percentage, fontSize ?? CGFloat.greatestFiniteMagnitude), weight: fontWeight, design: fontDesign))
                .lineLimit(self.lineLimit)
                .minimumScaleFactor(self.minimumScaleFactor)
                .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
        }
    }
}

public extension View {
    
    /// Passt einen `Text` an die übergeordnete `View` an.
    ///
    /// Bei der Anpassung wird die Textgröße in Abhängigkeit von `lineLimit` an die Breite der übergeordneten `View` angepasst.
    /// Dabei kann weiter die Schriftgröße, Schriftdicke, Schriftart angepasst werden.
    /// Zusätzlich lässt sich die Darstellung prozentual über den Skalierungsfaktor und prozentualen Anteil anpassen.
    ///
    /// **Beispiel mit Parameter**
    /// ```swift
    /// Text("Hallo Welt")
    ///     .fitFont(lineLimit: 1, fontSize: 35.0, fontWeight: .bold, fontDesign: .regular, minimumScaleFactor: 0.01, percentage: 1)
    /// ```
    ///
    /// **Beispiel ohne Parameter**
    /// ```swift
    /// Text("Hallo Welt")
    ///     .fitFont()
    /// ```
    ///
    /// - Requires: `SwiftUI`
    /// - Author: Dustin Weise
    /// - Copyright: © 2021 by Dustin Weise
    func fitFont(lineLimit: Int? = nil, fontSize: CGFloat? = nil, fontWeight: Font.Weight = .regular, fontDesign: Font.Design = .default, minimumScaleFactor: CGFloat = 0.01, percentage: CGFloat = 1) -> ModifiedContent<Self, FitFont> {
        return modifier(FitFont(lineLimit: lineLimit, fontSize: fontSize, fontWeight: fontWeight, fontDesign: fontDesign, minimumScaleFactor: minimumScaleFactor, percentage: percentage))
    }
}
