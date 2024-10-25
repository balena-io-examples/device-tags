echo "setting 'stats.laststart' tag"
sh curl_tags_api/set-device-tag.sh "stats.last_application_start" $(date +"%Y-%m-%dT%H:%M:%S%z")
echo "starting application"
npm start
