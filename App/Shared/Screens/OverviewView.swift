
//
//  OverviewView.swift
//  InsightOut
//
//  Created by Marc Gidaszewski on 06.11.21.
//

import SwiftUI
import InsightOut

extension Dictionary where Value: Equatable {
    func key(from value: Value) -> Key? {
        return self.first(where: { $0.value == value })?.key
    }
}

struct OverviewView: View {
    @EnvironmentObject var loader: Loader

    @State private var selectedTime = 0
    
    @State private var selectedEmotion = 7

    @State private var entries = [MoodEntry]()

    let emotionLookup = [
        "happiness":0,
        "sadness":1,
        "love":2,
        "fear":3,
        "disgust":4,
        "surprised":5,
        "anger":6,
        "all":7
    ]
    
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea()
            VStack {
                Spacer()
                WeekView(entries: entries)
                Spacer()
            }
        }.onAppear(perform: load)
    }
    
    func load() {
        entries = loader.moods(forDate: Date())
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView()
            .environmentObject(Loader(context: CoreDataStack.preview.context))
    }
}
