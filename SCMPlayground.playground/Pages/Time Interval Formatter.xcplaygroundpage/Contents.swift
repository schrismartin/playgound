import Foundation

let date = Date(timeIntervalSinceNow: -60 * 60 * 24 * 2)
let since = -date.timeIntervalSinceNow

func string(from interval: TimeInterval) -> String {
    let minute = Int(interval / 60) % 60
    let hour = Int(interval / (60 * 60)) % 24
    let day = Int(interval / (60 * 60 * 24))
    
    switch (day, hour, minute) {
    case (let d, _, _) where d != 0:
        return String(format: "%d Day%@", d, d == 1 ? "" : "s")
    case (_, let h, _) where h != 0:
        return String(format: "%d Hour%@", h, h == 1 ? "" : "s")
    case (_, _, let m):
        return String(format: "%d Minute%@", m, m == 1 ? "" : "s")
    }
}

string(from: since)