import Darwin.POSIX

struct Tweak {
    static let markerPath = "/var/jb/.xinamine_installed"

    static func ctor() {
        if access(markerPath, F_OK) == 0 {
            return
        }

        var pid: pid_t = 0
        posix_spawn(&pid, "/var/jb/usr/local/bin/Xinamine", nil, nil, [nil], [nil])
    }
}

@_cdecl("jinx_entry")
func jinxEntry() {
    Tweak.ctor()
}
