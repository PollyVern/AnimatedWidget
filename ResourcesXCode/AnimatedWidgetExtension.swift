//
//  AnimatedWidgetExtension.swift
//  AnimatedWidgetExtension
//
//  Created by Polina Belovodskaya on 08.06.2024.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), userPlantCount: 0, configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), userPlantCount: getPlantCount(), configuration: configuration)
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, userPlantCount: getPlantCount(), configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

    func getPlantCount() -> Int {
        return 15
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let userPlantCount: Int
    let configuration: ConfigurationAppIntent
}

struct ServicePlantWidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .accessoryCircular:
            ZStack {
                VStack {
                    Spacer()
                    Image("static_grass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                Text(Calendar.current.startOfDay(for: Date()),
                     style: .timer)
                .contentTransition(.identity)
                .lineLimit(1)
                .multilineTextAlignment(.center) // .trailing
                .truncationMode(.head)
                .font(Font.custom("DynamicFont", size: 48))
                .offset(x: -68, y: 10)

                VStack {
                    Spacer()
                    Text("\(entry.userPlantCount)")
                        .font(.system(size: 30.0, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .blendMode(.destinationOut)
                        .padding([.leading, .trailing], 12)
                        .padding([.bottom], 5)
                        .minimumScaleFactor(0.0001)
                        .lineLimit(1)
                }
            }
            .compositingGroup()
            .unredacted()
        default:
            Text("default")
        }

    }
}

struct ServicePlantWidget: Widget {

    private let kind: String = "ServicePlantWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            ServicePlantWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)

        }
        .configurationDisplayName(NSLocalizedString("widget_plant_count_title", comment: ""))
        .description(NSLocalizedString("widget_plant_count_description", comment: ""))
        .supportedFamilies([.accessoryCircular])
    }
}
