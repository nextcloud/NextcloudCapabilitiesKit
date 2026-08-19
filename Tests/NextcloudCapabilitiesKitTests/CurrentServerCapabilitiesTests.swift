//  SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

@testable import NextcloudCapabilitiesKit
import XCTest

final class CurrentServerCapabilitiesTests: XCTestCase {
    func testCurrentServerCapabilities() {
        let data = """
        {
          "ocs": {
            "data": {
              "version": {
                "major": 33,
                "minor": 0,
                "micro": 0
              },
              "capabilities": {
                "core": {
                  "pollinterval": 60,
                  "webdav-root": "remote.php/webdav",
                  "reference-api": true,
                  "reference-regex": "regex",
                  "mod-rewrite-working": true,
                  "user": {
                    "language": "en",
                    "locale": "en_US",
                    "timezone": "Europe/Berlin"
                  },
                  "can-create-app-token": true
                },
                "dav": {
                  "chunking": "1.0",
                  "public_shares_chunking": true,
                  "search_supports_creation_time": true,
                  "search_supports_upload_time": true,
                  "search_supports_last_activity": true,
                  "bulkupload": "1.0",
                  "absence-supported": true,
                  "absence-replacement": true
                },
                "files": {
                  "bigfilechunking": true,
                  "blacklisted_files": ["legacy"],
                  "forbidden_filenames": ["forbidden"],
                  "forbidden_filename_basenames": [".DS_Store"],
                  "forbidden_filename_characters": ["/"],
                  "forbidden_filename_extensions": [".tmp"],
                  "chunked_upload": {
                    "max_size": 1000,
                    "max_parallel_count": 3
                  },
                  "file_conversions": [
                    {
                      "from": "application/vnd.oasis.opendocument.text",
                      "to": "application/pdf",
                      "extension": "pdf",
                      "displayName": "PDF"
                    }
                  ],
                  "delete_from_trash": true,
                  "windows_compatible_filenames": true
                },
                "files_sharing": {
                  "api_enabled": true,
                  "public": {
                    "enabled": true,
                    "multiple_links": true,
                    "upload_files_drop": true,
                    "custom_tokens": true
                  },
                  "user": {
                    "send_mail": false
                  },
                  "resharing": true,
                  "group_sharing": true,
                  "group": {
                    "enabled": true
                  },
                  "default_permissions": 31,
                  "exclude_reshare_from_edit": true,
                  "federation": {
                    "outgoing": true,
                    "incoming": true,
                    "expire_date": {
                      "enabled": true
                    },
                    "expire_date_supported": {
                      "enabled": true
                    }
                  },
                  "sharee": {
                    "minSearchStringLength": 3,
                    "query_lookup_default": true,
                    "always_show_unique": true
                  },
                  "sharebymail": {
                    "enabled": true,
                    "send_password_by_mail": true,
                    "upload_files_drop": {
                      "enabled": true
                    },
                    "password": {
                      "enabled": true,
                      "enforced": false
                    },
                    "expire_date": {
                      "enabled": true,
                      "enforced": true
                    }
                  }
                },
                "sharing": {
                  "api_versions": ["v1"],
                  "source_types": [
                    {
                      "class": "OCA\\\\Files\\\\Sharing\\\\FileSource"
                    }
                  ],
                  "permission_presets": [
                    {
                      "class": "OCA\\\\Files\\\\Sharing\\\\ReadOnlyPreset",
                      "display_name": "Read only",
                      "hint": "Can view but not edit"
                    }
                  ]
                },
                "systemtags": {
                  "enabled": true
                },
                "weather_status": {
                  "enabled": true
                },
                "provisioning_api": {
                  "version": "1.0.0",
                  "AccountPropertyScopesVersion": 2,
                  "AccountPropertyScopesFederatedEnabled": true,
                  "AccountPropertyScopesPublishedEnabled": true
                },
                "user_status": {
                  "enabled": true,
                  "restore": true,
                  "supports_emoji": true,
                  "supports_busy": true
                }
              }
            }
          }
        }
        """.data(using: .utf8)!

        let capabilities = Capabilities(data: data)

        XCTAssertEqual(capabilities?.core?.canCreateAppToken, true)
        XCTAssertEqual(capabilities?.dav?.absenceReplacement, true)
        XCTAssertEqual(capabilities?.files?.forbiddenFilenameExtensions, [".tmp"])
        XCTAssertEqual(capabilities?.files?.fileConversions.first?.displayName, "PDF")
        XCTAssertEqual(capabilities?.filesSharing?.publicLink?.multipleAllowed, true)
        XCTAssertEqual(capabilities?.filesSharing?.email?.expireDateEnforced, true)
        XCTAssertEqual(capabilities?.sharing?.apiVersions, ["v1"])
        XCTAssertEqual(capabilities?.sharing?.sourceTypes.first?.className, "OCA\\Files\\Sharing\\FileSource")
        XCTAssertEqual(capabilities?.sharing?.permissionPresets.first?.displayName, "Read only")
        XCTAssertEqual(capabilities?.systemTags?.enabled, true)
        XCTAssertEqual(capabilities?.weatherStatus?.enabled, true)
        XCTAssertEqual(capabilities?.provisioningAPI?.accountPropertyScopesVersion, 2)
        XCTAssertEqual(capabilities?.userStatus?.supportsBusy, true)
    }
}
