#!/bin/bash

# iOS Enterprise Build Script
# for Xcode 6+
# Written by David Benko

SCHEME="BuildScheme"
BUILDDIRECTORY="builds"

while getopts ":a:p:s:d:h" opt; do
  case $opt in
    a)
    PROJECT=$OPTARG
    ;;
    p)
    PROFILE=$OPTARG
    ;;
    s)
    SCHEME=$OPTARG
    ;;
    d)
    BUILDDIRECTORY=$OPTARG
    ;;
    h)
    echo "-a (App Name) *required" >&1
    echo "-p (Provisioning Profile Name) *required" >&1
    echo "-s (Scheme Name)" >&1
    echo "-d (Build Directory)" >&1
    exit 0
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

# Check for required params
if [[ -z $PROJECT  ||  -z $PROFILE ]];
  then
    echo "-a (App Name) and -p (Provisioning Profile) must be included" >&2
    exit 1
fi

echo "Building Project: $PROJECT" >&1
echo "Provisioning Profile: $PROFILE" >&1
echo "Scheme: $SCHEME" >&1
echo "Build Directory: $BUILDDIRECTORY" >&1

# Clean xcode project
clean="xcodebuild clean -project $PROJECT.xcodeproj -configuration Release -alltargets"
eval $clean

# Clean old builds
cleanbuilds="rm -rf $BUILDDIRECTORY"
eval $cleanbuilds

# Archive xcode project
archive="xcodebuild archive -project $PROJECT.xcodeproj -scheme \"$SCHEME\" -archivePath $BUILDDIRECTORY/$PROJECT.xcarchive"
eval $archive

# Export IPA file from archive
exportbuild="xcodebuild -exportArchive -archivePath $BUILDDIRECTORY/$PROJECT.xcarchive -exportPath $BUILDDIRECTORY/$PROJECT -exportFormat ipa -exportProvisioningProfile \"$PROFILE\""
eval $exportbuild
