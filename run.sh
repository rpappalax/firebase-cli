#!/bin/bash

# set the following env vars:
# GOOGLE_APPLICATION_CREDENTIALS
# GOOGLE_SERVICE_ACCOUNT
# GOOGLE_PROJECT

# download the following files to current dir
# flank.jar
# app.apk
# test.apk
# flank-x86.yml (config file)

PATH_TEST="."
gcloud auth activate-service-account --key-file "${GOOGLE_APPLICATION_CREDENTIALS}"
gcloud config set account "${GOOGLE_SERVICE_ACCOUNT}" 
gcloud config set project "${GOOGLE_PROJECT}"

set +e
flank_template="$PATH_TEST/flank-x86.yml"
APK_APP="$PATH_TEST/app-x86-debug.apk"
APK_TEST="$PATH_TEST/app-debug-androidTest.apk"
RESULTS_DIR="$PATH_TEST/results"
/usr/bin/java -jar $PATH_TEST/flank.jar android run \
    --config=$flank_template \
    --app=$APK_APP \
    --test=$APK_TEST \
    --local-result-dir="${RESULTS_DIR}" \
    --project="${GOOGLE_PROJECT}"

