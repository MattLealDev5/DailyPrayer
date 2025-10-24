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
    let verseData: Verse
    
    @State var timeRemaining = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var textSaved = false
    @State var verseSaved = false

    @State private var musicAudio: AVAudioPlayer?

    func playMusic() {
        // Configure audio session first
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
            return
        }
        
        guard let path = Bundle.main.path(forResource: "music_01", ofType: "mp3") else {
            print("Music file not found")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        do {
            musicAudio = try AVAudioPlayer(contentsOf: url)
            musicAudio?.prepareToPlay() // Pre-buffer the audio
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
                Text(verseData.id)
                    .font(.system(size: 24, weight: .semibold))
                Text(verseData.text)
                    .font(.system(size: 22, weight: .semibold))
            }
                
                
        }
        .onAppear {
//            playMusic() // Take off if you hear that confounded crackling
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
            if timeRemaining <= 0 {
                timer.upstream.connect().cancel()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) {
            VStack {
                Button("Share", systemImage: "arrowshape.turn.up.left") {
                    UIPasteboard.general.string = "\(verseData.id)\n\(verseData.text)\nDownload our app"
                    if let content = UIPasteboard.general.string {
                        print(content)
                        textSaved = true
                    }
                }
                if textSaved {
                    Text("Saved!")
                        .padding(3)
                        .font(.system(size: 24))
                }
            }
        }
        .overlay(alignment: .topLeading) {
            Button("Save", systemImage: verseSaved ? "heart.fill" : "heart") {
                verseSaved.toggle()
            }
        }
        .padding()
    }
    
    
}

#Preview {
    PrayerView(verseData: Verse.mocked)
}
