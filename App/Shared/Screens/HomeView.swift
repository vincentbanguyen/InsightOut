//
//  HomeView.swift.swift
//  InsightOut
//
//  Created by Marc Gidaszewski on 06.11.21.
//

import SwiftUI
import InsightOut

struct HomeView: View {
    @EnvironmentObject var loader: Loader
    @State private var moodStatus = Mood.happiness
    @Binding var backgroundColor: Color
    @State private var colors = [Color]()

    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [backgroundColor, .white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                EmotionsOfTheDayView(colors: colors)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(lineWidth: 3)
                            .foregroundColor(.white)
                    )
                    .frame(minHeight: 25, maxHeight: 50)
                    .padding()
                Emoji(mood: moodStatus)
                    .frame(width: 200, height: 200)
                    .foregroundColor(backgroundColor)
                    .padding(50)
                EmojiWheel(moodStatus: $moodStatus, backgroundColor: $backgroundColor, onTap: onTap)
                    .frame(width: 300, height: 300)
                    .padding(.bottom, 50)
            }
        }.onAppear(perform: load)
    }

    private func load() {
        let moods = loader.moods(forDate: Date())
        colors = moods
            .map(\.mood)
            .map(String.init(describing:))
            .map { Color($0) }
    }

    private func onTap() {
        let colorName = String(describing: moodStatus)
        let color = Color(colorName)
        loader.saveMood(moodStatus, date: Date(), label: .family)
        withAnimation(.easeInOut) {
            colors.append(color)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    @State static var color = Color.yellow
    static var previews: some View {
        HomeView(backgroundColor: $color)
            .environmentObject(MoodEntryRepository(context: CoreDataStack.preview.context))
    }
}
