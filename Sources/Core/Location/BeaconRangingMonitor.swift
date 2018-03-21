//
//  BeaconRangingMonitor.swift
//  XestiMonitors
//
//  Created by J. G. Pusey on 2018-03-21.
//
//  © 2018 J. G. Pusey (see LICENSE.md)
//

#if os(iOS)

    import CoreLocation

    ///
    /// An `BeaconRangingMonitor` instance monitors ...
    ///
    public class BeaconRangingMonitor: BaseMonitor {
        ///
        /// Encapsulates changes to ...
        ///
        public enum Event {
            ///
            ///
            ///
            case didFail(CLBeaconRegion, Error)

            ///
            ///
            ///
            case didRange(CLBeaconRegion, [CLBeacon])
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
            /// Monitor `didRange` events.
            ///
            public static let didRange = Options(rawValue: 1 << 1)

            ///
            /// Monitor all events.
            ///
            public static let all: Options = [.didFail,
                                              .didRange]

            /// :nodoc:
            public init(rawValue: UInt) {
                self.rawValue = rawValue
            }

            /// :nodoc:
            public let rawValue: UInt
        }

        ///
        /// Initializes a new `BeaconRangingMonitor`.
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
        /// A Boolean value indicating whether ...
        ///
        public var isAvailable: Bool {
            return type(of: locationManager).isRangingAvailable()
        }

        private let handler: (Event) -> Void
        private let locationManager: CLLocationManager
        private let options: Options
        private let queue: OperationQueue

        override public func cleanupMonitor() {
            locationManager.stopXXX()

            locationManager.delegate = nil

            super.cleanupMonitor()
        }

        override public func configureMonitor() {
            super.configureMonitor()

//            locationManager.delegate = self

            locationManager.startXXX()
        }
    }

//    extension BeaconRangingMonitor: CLLocationManagerDelegate {
//    }

#endif
