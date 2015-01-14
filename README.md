# iOS Enterprise Build Script
Creates a .ipa from a project without needing developer account credentials set in Xcode.

### Instructions
- Put script in same directory as `.xcodeproj`
- Set developer certificate, provisioning profile, and bundle identifier in target build settings
- Create a new scheme named `BuildScheme` in Xcode
- Run `bash enterprise-build.sh -a MyProject -p MyProvisioningProfileName`
- `.ipa` will be generated as `builds/MyProject.ipa`

### License
MIT


