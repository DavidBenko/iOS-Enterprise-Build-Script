#!/bin/bash

# iOS Enterprise Build Script
# for Xcode 6+
# Written by David Benko

while getopts ":a:p:" opt; do
  case $opt in
    a)
      echo "Building Project: $OPTARG" >&2
	    PROJECT=$OPTARG
      ;;
    p)
      echo "Using Provisioning Profile: $OPTARG" >&2
      PROFILE=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Clean xcode project
clean="xcodebuild clean -project $PROJECT.xcodeproj -configuration Release -alltargets"
eval $clean

# Clean old builds
rm -rf builds

# Archive xcode project
archive="xcodebuild archive -project $PROJECT.xcodeproj -scheme BuildScheme -archivePath builds/$PROJECT.xcarchive"
eval $archive

# Export IPA file from archive
exportbuild="xcodebuild -exportArchive -archivePath builds/$PROJECT.xcarchive -exportPath builds/$PROJECT -exportFormat ipa -exportProvisioningProfile \"$PROFILE\""
eval $exportbuild
