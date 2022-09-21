//
//  AndesAccessibleViewProtocol.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 21/05/21.
//

import Foundation
import AVFoundation

enum AccessibilityAnnouncement {
    case vibration
    case message(message: String)
    case custom(notification: UIAccessibility.Notification, argument: Any?, deadline: Double = 0.1)
}

protocol AndesAccessibleView {
    var accessibilityManager: AndesAccessibilityManager? { get set }
}

protocol AndesAccessibilityManager {
    init(view: UIView)
    func viewUpdated()
    func accessibilityActivated()
    func makeAnnouncement(type: AccessibilityAnnouncement)
}

extension AndesAccessibilityManager {
    func makeAnnouncement(type: AccessibilityAnnouncement) {
        guard UIAccessibility.isVoiceOverRunning else { return }
        switch type {
        case .vibration:
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        case .message(let message):
            sendMessage(message)
        case .custom(let notification, let argument, let deadline):
            sendCustomMessage(notification, argument, deadline)
        }
    }

    func makeAnnouncementWithLinks(_ text: String, _ bodyLinks: AndesBodyLinks) {
        let topViewController = UIApplication.getTopViewController()
        let linksAlert = UIAlertController(title: "Links disponibles".localized(), message: nil, preferredStyle: .actionSheet)
        for (index, link) in bodyLinks.links.enumerated() {
            let range = NSRange(location: link.startIndex, length: link.endIndex - link.startIndex)
            let actionTitle = (text as NSString?)?.substring(with: range)
            linksAlert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { _ in
                bodyLinks.listener(index)
            }))
        }
        linksAlert.addAction(UIAlertAction(title: "Cancelar".localized(), style: .default, handler: { [weak linksAlert] _ in
            linksAlert?.dismiss(animated: true, completion: nil)
        }))
        topViewController?.present(linksAlert, animated: true, completion: nil)
    }

    // Validate if 80% of the maximum assigned text has already been entered
    func shouldSendAnnouncement(maximumNumberOfCharacters: Int, viewTextCount: Int) -> Bool {
        let characterCountPercentage = 0.8
        let minCharacterCountToAnnounce = 20
        let numberOfAnnounced = Int((Double(maximumNumberOfCharacters) * characterCountPercentage).rounded(.toNearestOrEven))
        return maximumNumberOfCharacters >= minCharacterCountToAnnounce && viewTextCount == numberOfAnnounced
    }

    private func sendMessage(_ message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let notificationArgument = NSAttributedString(string: message,
                                                          attributes: [NSAttributedString.Key.accessibilitySpeechQueueAnnouncement: true])
            UIAccessibility.post(notification: .announcement, argument: notificationArgument)
        }
    }

    private func sendCustomMessage(_ notification: UIAccessibility.Notification, _ argument: Any?, _ deadline: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + deadline) {
            UIAccessibility.post(notification: notification, argument: argument)
        }
    }
}
