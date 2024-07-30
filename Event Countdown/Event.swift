//
//  Event.swift
//  Event Countdown
//
//  Created by ahmed on 29/07/2024.
//

import Foundation
import SwiftUI

struct Event: Identifiable, Comparable {
    let id: UUID
    var title: String
    var date: Date
    var textColor: Color

    static let formatter = RelativeDateTimeFormatter()
    var formattedDate: String

    init(id: UUID? = nil, title: String, date: Date, textColor: Color) {
        self.id = id ?? UUID()
        self.title = title
        self.date = date
        self.textColor = textColor
        formattedDate = Event.formatter.localizedString(for: date, relativeTo: Date())

    }

    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.date.compare(rhs.date).rawValue == -1
    }
}

extension Event {
    static var sampleData: [Event] {
        [
            .init(title: "Halloween", date: Date(), textColor: .orange),
            .init(title: "Christmas", date: Date(), textColor: .green),
            .init(title: "New Year's Eve", date: Date(), textColor: .yellow)
        ]
    }
}
