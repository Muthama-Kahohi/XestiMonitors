//
//  RegionMonitor.swift
//  XestiMonitors
//
//  Created by J. G. Pusey on 2018-03-21.
//
//  © 2018 J. G. Pusey (see LICENSE.md)
//

#if os(iOS) || os(macOS)

    import CoreLocation

    ///
    /// An `RegionMonitor` instance monitors ...
    ///
    public class RegionMonitor: BaseMonitor {
        ///
        /// Encapsulates changes to ...
        ///
        public enum Event {
            ///
            ///
            ///
            case didDetermineState(CLRegion, CLRegionState)

            ///
            ///
            ///
            case didEnter(CLRegion)

            ///
            ///
            ///
            case didExit(CLRegion)

            ///
            ///
            ///
            case didFail(CLRegion?, Error)

            ///
            ///
            ///
            case didStart(CLRegion)
        }

        ///
        /// Specifies which events to monitor.
        ///
        public struct Options: OptionSet {
            ///
            /// Monitor `didDetermineState` events.
            ///
            public static let didDetermineState = Options(rawValue: 1 << 0)

            ///
            /// Monitor `didEnter` events.
            ///
            public static let didEnter = Options(rawValue: 1 << 1)

            ///
            /// Monitor `didExit` events.
            ///
            public static let didExit = Options(rawValue: 1 << 2)

            ///
            /// Monitor `didFail` events.
            ///
            public static let didFail = Options(rawValue: 1 << 3)

            ///
            /// Monitor `didStart` events.
            ///
            public static let didStart = Options(rawValue: 1 << 4)

            ///
            /// Monitor all events.
            ///
            public static let all: Options = [.didDetermineState,
                                              .didEnter,
                                              .didExit,
                                              .didFail,
                                              .didStart]

            /// :nodoc:
            public init(rawValue: UInt) {
                self.rawValue = rawValue
            }

            /// :nodoc:
            public let rawValue: UInt
        }

        ///
        /// Initializes a new `RegionMonitor`.
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
//        public var isAvailable: Bool {
//            return type(of: altimeter).isRelativeAltitudeAvailable()
//        }

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

//    extension RegionMonitor: CLLocationManagerDelegate {
//    }

#endif
