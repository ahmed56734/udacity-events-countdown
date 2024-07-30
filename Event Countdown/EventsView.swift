//
//  EventsView.swift
//  Event Countdown
//
//  Created by ahmed on 29/07/2024.
//

import SwiftUI

struct EventsView: View {
    @State var events: [Event] = []
    @State var timer: Timer?

    var body: some View {
        NavigationStack {
            VStack {
                if events.isEmpty {
                    ContentUnavailableView("No Events Created", systemImage: "calendar")
                } else {
                    List(events, id: \.id) { event in
                        NavigationLink {
                            EventForm(toEdit: event, onSave: {
                                event in updateEvent(event)
                            })
                        } label: {
                            EventRow(event: event)
                                .swipeActions {
                                    Button {
                                        deleteEvent(event)
                                    } label:{
                                        Label("", systemImage: "trash")
                                    }
                                    .tint(.red)
                                }
                        }
                    }
                    .onAppear {
                        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { _ in
                            print("timer")
                            triggerStateUpdate()
                        }
                    }
                    .onDisappear {
                        timer?.invalidate()
                    }
                }
            }
            .navigationTitle("Events")
            .toolbar {
                NavigationLink {
                    EventForm { event in
                        addEvent(event)
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }

    func addEvent(_ event: Event) {
        events.append(event)
        events.sort()
    }

    func deleteEvent(_ event: Event) {
        events.removeAll { $0.id == event.id }
        events.sort()
    }

    func updateEvent(_ event: Event) {
        events[events.firstIndex { $0.id == event.id }!] = event
        events.sort()
    }

    func triggerStateUpdate() {
        for idx in events.indices{
            events[idx].formattedDate =  Event.formatter.localizedString(for: events[idx].date, relativeTo: Date())
        }
    }
}

#Preview {
    EventsView(events: Event.sampleData)
}
