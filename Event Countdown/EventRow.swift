//
//  EventRow.swift
//  Event Countdown
//
//  Created by ahmed on 29/07/2024.
//

import SwiftUI

struct EventRow: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading){
            Text(event.title)
                .foregroundStyle(event.textColor)
                .font(.headline)
            
            Text("\(event.formattedDate)")
        }
    }
}

#Preview {
    EventRow(event: Event.sampleData.first!)
}
