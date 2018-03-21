//
//  StandardLocationMonitor.swift
//  XestiMonitors
//
//  Created by J. G. Pusey on 2018-03-21.
//
//  © 2018 J. G. Pusey (see LICENSE.md)
//

#if os(iOS) || os(macOS) || os(watchOS)

    import CoreLocation

    ///
    /// An `StandardLocationMonitor` instance monitors ...
    ///
    @available(watchOS 3.0, *)
    public class StandardLocationMonitor: BaseMonitor {
        ///
        /// Encapsulates changes to ...
        ///
        public enum Event {
            ///
            ///
            ///
            case didFail(Error)

            ///
            ///
            ///
            case didFinishDeferredUpdates(Error?)

            ///
            ///
            ///
            case didPauseUpdates

            ///
            ///
            ///
            case didResumeUpdates

            ///
            ///
            ///
            case didUpdate([CLLocation])
        }

        ///
        /// Specifies which events to monitor.
        ///
        public struct Options: OptionSet {
            ///
            /// Monitor `didFail` events.
            ///
            public static let didFail = Options(rawValue: 1 << 0)

            ///
            /// Monitor `didFinishDeferredUpdates` events.
            ///
            public static let didFinishDeferredUpdates = Options(rawValue: 1 << 1)

            ///
            /// Monitor `didPauseUpdates` events.
            ///
            public static let didPauseUpdates = Options(rawValue: 1 << 2)

            ///
            /// Monitor `didResumeUpdates` events.
            ///
            public static let didResumeUpdates = Options(rawValue: 1 << 3)

            ///
            /// Monitor `didUpdate` events.
            ///
            public static let didUpdate = Options(rawValue: 1 << 4)

            ///
            /// Monitor all events.
            ///
            public static let all: Options = [.didFail,
                                              .didFinishDeferredUpdates,
                                              .didPauseUpdates,
                                              .didResumeUpdates,
                                              .didUpdate]

            /// :nodoc:
            public init(rawValue: UInt) {
                self.rawValue = rawValue
            }

            /// :nodoc:
            public let rawValue: UInt
        }

        ///
        /// Initializes a new `StandardLocationMonitor`.
        ///
        /// - Parameters:
        ///   - options:    The options that specify which events to monitor. By
        ///                 default, all events are monitored.
        ///   - queue:      The operation queue on which the handler executes.
        ///   - handler:    The handler to call when ...
        ///
        public init(options: Options = .all,
                    queue: OperationQueue,
                    handler: @escaping (Event) -> Void) {
            self.handler = handler
            self.locationManager = CLLocationManager()
            self.options = options
            self.queue = queue
        }

        ///
        /// A Boolean value indicating whether the device supports generating data
        /// for relative altitude changes.
        ///
        //    public var isAvailable: Bool {
        //        return type(of: altimeter).isRelativeAltitudeAvailable()
        //    }

        private let handler: (Event) -> Void
        private let locationManager: CLLocationManager
        private let options: Options
        private let queue: OperationQueue

        override public func cleanupMonitor() {
            locationManager.stopUpdatingLocation()

            locationManager.delegate = nil

            super.cleanupMonitor()
        }

        override public func configureMonitor() {
            super.configureMonitor()

            //        locationManager.delegate = self

            locationManager.startUpdatingLocation()
        }
    }

    // extension StandardLocationMonitor: CLLocationManagerDelegate {
    // }

#endif
