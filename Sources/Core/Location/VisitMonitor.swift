//
//  VisitMonitor.swift
//  XestiMonitors
//
//  Created by J. G. Pusey on 2018-03-21.
//
//  © 2018 J. G. Pusey (see LICENSE.md)
//

#if os(iOS)

    import CoreLocation

    ///
    /// An `VisitMonitor` instance monitors ...
    ///
    public class VisitMonitor: BaseMonitor {
        ///
        /// Encapsulates changes to ...
        ///
        public enum Event {
            ///
            ///
            ///
            case didVisit(CLVisit)
        }

        ///
        /// Initializes a new `VisitMonitor`.
        ///
        /// - Parameters:
        ///   - queue:      The operation queue on which the handler executes.
        ///   - handler:    The handler to call when ...
        ///
        public init(queue: OperationQueue,
                    handler: @escaping (Event) -> Void) {
            self.handler = handler
            self.locationManager = CLLocationManager()
            self.queue = queue
        }

        ///
        /// A Boolean value indicating whether ...
        ///
//        public var isAvailable: Bool {
//            return type(of: altimeter).isRelativeAltitudeAvailable()
//        }

        private let handler: (Event) -> Void
        private let locationManager: CLLocationManager
        private let queue: OperationQueue

        override public func cleanupMonitor() {
            locationManager.stopMonitoringVisits()

            locationManager.delegate = nil

            super.cleanupMonitor()
        }

        override public func configureMonitor() {
            super.configureMonitor()

//            locationManager.delegate = self

            locationManager.startMonitoringVisits()
        }
    }

//    extension VisitMonitor: CLLocationManagerDelegate {
//    }

#endif
