//
//  PedometerMonitor.swift
//  XestiMonitors
//
//  Created by J. G. Pusey on 2017-04-14.
//
//  © 2017 J. G. Pusey (see LICENSE.md)
//

import CoreMotion
import Foundation

///
/// A `PedometerMonitor` instance monitors the device to fetch
/// pedestrian-related data.
///
public class PedometerMonitor: BaseMonitor {

    // Public Nested Types

    ///
    ///
    ///
    public enum Event {

        ///
        ///
        ///
        case didQuery(Info)

        ///
        ///
        ///
        case didUpdate(Info)

    }

    ///
    ///
    ///
    public enum Info {

        ///
        ///
        ///
        case data(CMPedometerData)

        ///
        ///
        ///
        case error(Error)

        ///
        ///
        ///
        case unknown

    }

    // Public Initializers

    ///
    /// Initializes a new `PedometerMonitor`.
    ///
    /// - Parameters:
    ///   - queue:      The operation queue on which the handler executes.
    ///   - handler:    The handler to call when ...
    ///
    public init(queue: OperationQueue,
                handler: @escaping (Event) -> Void) {

        self.handler = handler
        self.pedometer = CMPedometer()
        self.queue = queue

    }

    // Public Instance Properties

    ///
    /// A Boolean value indicating whether cadence information is available on
    /// the device.
    ///
    public var isCadenceAvailable: Bool {

        if #available(iOS 9.0, *) {
            return CMPedometer.isCadenceAvailable()
        } else {
            return false
        }

    }

    ///
    /// A Boolean value indicating whether distance estimation is available on
    /// the device.
    ///
    public var isDistanceAvailable: Bool {

        return CMPedometer.isDistanceAvailable()

    }

    ///
    /// A Boolean value indicating whether floor counting is available on the
    /// device.
    ///
    public var isFloorCountingAvailable: Bool {

        return CMPedometer.isFloorCountingAvailable()

    }

    ///
    /// A Boolean value indicating whether pace information is available on the
    /// device.
    ///
    public var isPaceAvailable: Bool {

        if #available(iOS 9.0, *) {
            return CMPedometer.isPaceAvailable()
        } else {
            return false
        }

    }

    ///
    /// A Boolean value indicating whether step counting is available on the
    /// device.
    ///
    public var isStepCountingAvailable: Bool {

        return CMPedometer.isStepCountingAvailable()

    }

    // Public Instance Methods

    public func query(from start: Date,
                      to end: Date) -> Bool {

        pedometer.queryPedometerData(from: start,
                                     to: end) { [unowned self] data, error in

                                        var info: Info

                                        if let error = error {
                                            info = .error(error)
                                        } else if let data = data {
                                            info = .data(data)
                                        } else {
                                            info = .unknown
                                        }

                                        self.queue.addOperation {
                                            self.handler(.didQuery(info))
                                        }

        }

        return true

    }

    // Private Instance Properties

    private let handler: (Event) -> Void
    private let pedometer: CMPedometer
    private let queue: OperationQueue

    // Overridden BaseMonitor Instance Methods

    public override final func cleanupMonitor() -> Bool {

        pedometer.stopUpdates()

        return super.cleanupMonitor()

    }

    public override final func configureMonitor() -> Bool {

        guard super.configureMonitor()
            else { return false }

        pedometer.startUpdates(from: Date()) { [unowned self] data, error in

            var info: Info

            if let error = error {
                info = .error(error)
            } else if let data = data {
                info = .data(data)
            } else {
                info = .unknown
            }

            self.queue.addOperation { self.handler(.didUpdate(info)) }

        }

        return true

    }

}