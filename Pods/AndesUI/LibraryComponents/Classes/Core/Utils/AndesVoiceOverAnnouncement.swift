//
//  AndesVoiceOverAnnouncement.swift
//  AndesUI
//
//  Created by Ezequiel Rasgido on 28/01/2022.
//

@objc
public class AndesVoiceOverAnnouncement: NSObject {
    /// Make an announcement via VoiceOver.
    ///
    /// - Parameters:
    ///   - message: Description of the announce.
    ///   - delay: Expected time for message enqued.
    @objc
    public static func sendMessage(_ message: String, delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                let notificationArgument = NSAttributedString(
                    string: message,
                    attributes: [NSAttributedString.Key.accessibilitySpeechQueueAnnouncement: true]
                )
                UIAccessibility.post(
                    notification: .announcement,
                    argument: notificationArgument
                )
        }
    }
}
