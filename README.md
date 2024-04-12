NextcloudCapabilitiesKit
========================

`NextcloudCapabilitiesKit` is a Swift library tailored for parsing and handling capabilities information from a Nextcloud server. It provides a structured way to access detailed features available on the server, including core settings, file handling capabilities, notifications, theming, and more, directly through Swift data structures.

Features
--------

*   **Comprehensive Parsing**: Understands and translates JSON capabilities data from Nextcloud into strongly typed Swift structures.
*   **Support for Various Capabilities**: Handles a wide range of Nextcloud server capabilities, such as core configurations, file sharing options, user statuses, theming, and more.
*   **Ease of Integration**: Designed to be easily integrated into any Swift application interacting with Nextcloud servers.

Installation
------------

### Swift Package Manager

`NextcloudCapabilitiesKit` can be integrated into your project using the Swift Package Manager.

Usage
-----

To use `NextcloudCapabilitiesKit` in your project, you first need to fetch the capabilities JSON from your Nextcloud server, which is typically available at a known URL path relative to your Nextcloud domain. Once you have the JSON data, you can parse it as follows:

```swift
import NextcloudCapabilitiesKit
import NextcloutKit

// We are assuming the use of NextcloudKit to fetch capabilities data

let ncKit = NextcloudKit()
ncKit.setup(user: user, userId: user, password: password, urlBase: serverUrl)

let capabilitiesData: Data? = await withCheckedContinuation { continuation in
    ncKit.getCapabilities { account, data, error in
        guard error == .success else {
            Logger.ncBackend.error("Could not get \(self.backendId) capabilities: \(error)")
            continuation.resume(returning: nil)
            return
        }
        continuation.resume(returning: data)
    }
}

if let capabilities = Capabilities(data: jsonData) {
    // Access parsed capabilities
    if let core = capabilities.core {
        print("Nextcloud version: \(core.version)")
    }
    // Handle other capabilities similarly...
} else {
    print("Failed to parse Nextcloud capabilities.")
}
```

Contributing
------------

Contributions to `NextcloudCapabilitiesKit` are welcome! Whether you're fixing bugs, adding new features, or improving documentation, please feel free to submit a pull request or open an issue.

License
-------

`NextcloudCapabilitiesKit` is released under the LGPL V3 License. See the `LICENSE` file for more details.

