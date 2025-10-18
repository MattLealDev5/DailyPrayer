//
//  PrayerView.swift
//  DailyPrayers
//
//  Created by Matthew Leal on 10/12/25.
//

import Foundation
import SwiftUI
internal import Combine
import AVFoundation

struct PrayerView: View {
    @State var timeRemaining = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let verse = "6. Philippians 4:6-7 (NIV)"
    let verseText = "Do not be anxious about anything, but in every situation, by prayer and petition, with thanksgiving, present your requests to God. And the peace of God, which transcends all understanding, will guard your hearts and your minds in Christ Jesus."

    @State private var musicAudio: AVAudioPlayer?

    func playMusic() {
        guard let path = Bundle.main.path(forResource: "music_01", ofType: "mp3") else {
            print("Music file not found")
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            musicAudio = try AVAudioPlayer(contentsOf: url)
            musicAudio?.play()
        } catch {
            print("Error playing music: \(error)")
        }
    }

    var body: some View {
        VStack(spacing: 80) {
            Spacer()
            
            // Circle Timer
            ZStack {
                Circle()
                    .frame(width: 200)
                    .foregroundStyle(.pink.gradient)
                    .rotationEffect(.degrees(-90))
                    .blur(radius: 15)
                Circle()
                    .trim(from: 0.0, to: CGFloat(timeRemaining)/60.0)
                    .stroke(style: StrokeStyle(lineWidth: 12.0,
                                               lineCap: .round, lineJoin: .round))
                    .frame(width: 200)
                    .rotationEffect(.degrees(-90))
                    .foregroundStyle(.pink.gradient)
                    .overlay() {
                        Text("\(timeRemaining)")
                            .font(.title)
                            .foregroundStyle(.white)
                    }
            }
            
            // Verse and text
            VStack(spacing: 10.0) {
                Text(verse)
                    .font(.system(size: 24, weight: .semibold))
                Text(verseText)
                    .font(.system(size: 22, weight: .semibold))
            }
                
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
//            VStack(spacing: 10.0) {
//                Text(verse)
//                    .font(.system(size: 24, weight: .semibold))
//                Text(verseText)
//                    .font(.system(size: 22, weight: .semibold))
//            }
        }.padding()
        
        .onAppear {
            playMusic()
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
            if timeRemaining <= 0 {
                timer.upstream.connect().cancel()
            }
        }
    }
}

#Preview {
    PrayerView()
}
