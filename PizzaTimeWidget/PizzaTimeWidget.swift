//
//  PizzaTimeWidget.swift
//  PizzaTimeWidget
//
//  Created by Steven Lipton on 11/3/20.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(),stage: 1)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(),stage: 0)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        entries.append(SimpleEntry(date: Date(), stage: 0))
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let stage:Int
}

struct PizzaTimeWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    var body: some View {
        //Text(entry.date, style: .time)
        switch family{
        case .systemSmall:
            DeliveryView(stage: .constant(entry.stage))
        case .systemMedium:
            DeliveryViewMedium(stage: .constant(entry.stage))
        case .systemLarge:
            DeliveryViewLarge(stage: .constant(entry.stage))
        default:
            DeliveryView(stage: .constant(entry.stage))
        }
        
    }
}

@main
struct PizzaTimeWidget: Widget {
    let kind: String = "PizzaTimeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PizzaTimeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Huli Pizza Delivery")
        .description("The widget to know where your pizza is")
        .supportedFamilies([.systemSmall,.systemMedium,.systemLarge])
    }
}

struct PizzaTimeWidget_Previews: PreviewProvider {
    static var previews: some View {
        PizzaTimeWidgetEntryView(entry: SimpleEntry(date: Date(), stage: 0))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
