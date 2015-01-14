# iOS-Enterprise-Build-Script
Creates a .ipa from a project without needing developer account credentials set in Xcode.

### Instructions
- Put script in same directory as `.xcodeproj`
- Set developer certificate, provisioning profile, and bundle identifier in project settings
- Run `bash enterprise-build.sh -a MyProject -p MyProvisioningProfileName`

### License
MIT


