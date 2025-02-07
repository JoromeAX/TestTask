//
//  MicrophoneButton.swift
//  TestTask
//
//  Created by Roman Khancha on 07.02.2025.
//

import SwiftUI
import AVFoundation
import SDWebImageSwiftUI

struct MicrophoneButton: View {
    @Binding var microphonePressed: Bool
    @State private var showAlert = false
    var action: () -> Void = {}
    
    private let gifURL = URL(string: "https://s3-alpha-sig.figma.com/img/9297/5f1e/a03badf80a1bd6a597390f7e212c7028?Expires=1739750400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=PD4EnxERFSeJ6567tUXSGJOyWPpEjlYW8-cOI6C7UklrCaFgOkDHU6juOJrZTjVzhAcy4a~yaL5WoYxJJQH7aRgv6OJuAug5uOR12XbFnJji9wqLG0aZF5XLzTKrVudrjo6qzLTWaBSr7166ymk53unwvIUkOxnGsC72d1t6ejmP9xZhPZJiCbO6MqC~-6rKGCXt5Vr~J6We6zP6iRpHgE0Ty2zCiHPIoYfqvi1C8C3mmAdRlCEFiyUE9CoMzVUfQfXL3hnv-FcLtLanjeiDqywjFDZQReq-OZWmzmaP50UHtLRt8K0Nl5FY2P3V7tJD4CFL9~kj4vCkzHL19o4hQA__")
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .frame(width: 178, height: 178)
            .foregroundStyle(.white)
            .shadow(radius: 4, y: 4)
            .overlay(contentView)
            .onTapGesture { checkMicrophonePermission() }
            .alert("Enable Microphone Access", isPresented: $showAlert, actions: alertActions, message: alertMessage)
    }
    
    private var contentView: some View {
        VStack(spacing: 24) {
            if microphonePressed {
                WebImage(url: gifURL)
                    .resizable()
                    .indicator(.activity)
                    .frame(width: 163, height: 95)
                Text("Recording...")
            } else {
                Image("microphone")
                Text("Start Speak")
            }
        }
        .foregroundStyle(.testTaskBlack)
    }
    
    private func checkMicrophonePermission() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .undetermined: requestMicrophoneAccess()
        case .denied: showAlert = true
        case .granted: toggleMicrophone()
        @unknown default: fatalError("Unexpected case in microphone permission")
        }
    }
    
    private func requestMicrophoneAccess() {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            DispatchQueue.main.async {
                granted ? toggleMicrophone() : (showAlert = true)
            }
        }
    }
    
    private func toggleMicrophone() {
        microphonePressed.toggle()
        if !microphonePressed { action() }
    }
    
    private func alertActions() -> some View {
        Group {
            Button("Cancel", role: .cancel) {}
            Button("Settings", action: openAppSettings)
        }
    }
    
    private func alertMessage() -> some View {
        Text("Please allow access to your microphone to use the app’s features.")
    }
    
    private func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(settingsURL) else { return }
        UIApplication.shared.open(settingsURL)
    }
}
