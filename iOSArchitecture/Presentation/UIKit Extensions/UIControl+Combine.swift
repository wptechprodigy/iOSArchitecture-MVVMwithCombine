//
//  UIControl+Combine.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 03/07/2022.
//

import UIKit
import Combine

// MARK: - Custom Subscription

extension UIControl {

    class InteractionSubscription<S: Subscriber>: Subscription
    where S.Input == Any? {

        // MARK: - Properties

        private let subscriber: S?
        private let control: UIControl
        private let event: UIControl.Event

        // MARK: - Initializer

        init(
            subscriber: S,
            control: UIControl,
            event: UIControl.Event
        ) {
            self.subscriber = subscriber
            self.control = control
            self.event = event

            self.control.addTarget(self, action: #selector(handleEvent(_:)), for: event)
        }

        // MARK: - Button Action

        @objc func handleEvent(_ sender: UIControl) {
            _ = self.subscriber?.receive(())
        }

        // MARK: - Subscriber Demands

        func request(_ demand: Subscribers.Demand) {}

        // MARK: - Cancel

        func cancel() {}
    }
}

// MARK: - Custom Publisher

extension UIControl {

    struct InteractionPublisher: Publisher {

        // MARK: - Type Definition

        typealias Output = Any?
        typealias Failure = Never

        // MARK: - Properties

        private let control: UIControl
        private let event: UIControl.Event

        // MARK: - Initializer

        init(control: UIControl, event: UIControl.Event) {
            self.control = control
            self.event = event
        }

        // MARK: - Receiver/Subscriber

        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Any? == S.Input {
            let subscription = InteractionSubscription(
                subscriber: subscriber,
                control: control,
                event: event)

            subscriber.receive(subscription: subscription)
        }
    }
}

// MARK: - Convenience Method

extension UIControl {
    func publisher(for event: UIControl.Event) -> UIControl.InteractionPublisher {
        return InteractionPublisher(control: self, event: event)
    }
}
