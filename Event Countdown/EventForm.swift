//
//  EventForm.swift
//  Event Countdown
//
//  Created by ahmed on 29/07/2024.
//

import SwiftUI

struct EventForm: View {
    @State private var formData: EventFormData
    private var callback: (Event) -> Void
    private var mode: FormMode
    private let oldTitle: String?
    @Environment(\.dismiss) private var dismiss
    
    init(toEdit event: Event? = nil, onSave: @escaping (Event) -> Void) {
        callback = onSave
        if event != nil {
            formData = EventFormData(id: event!.id,
                                     title: event!.title,
                                     date: event!.date,
                                     color: event!.textColor)
            mode = .edit
            oldTitle = event!.title
           
        } else {
            formData = EventFormData()
            mode = .add
            oldTitle = nil
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $formData.title)
                
                DatePicker("Date", selection: $formData.date)
                
                ColorPicker("Text Color", selection: $formData.color)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        callback(formData.toEvent())
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .disabled(!formData.isValid)
                }
            }
            .navigationTitle(mode == .add ? "Add Event" : "Edit \(oldTitle!)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct EventFormData {
    var id = UUID()
    var title: String = ""
    var date: Date = .init()
    var color: Color = .blue
    
    var isValid: Bool {
        !title.isEmpty
    }
    
    func toEvent() -> Event {
        return Event(id: id, title: title, date: date, textColor: color)
    }
}

enum FormMode {
    case add
    case edit
}

#Preview {
    EventForm(onSave: { _ in })
}
