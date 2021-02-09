echo "setting 'stats.laststart' tag"
sh curl_tags_api/set-device-tag.sh "stats.last_application_start" $(date +%s)
echo "starting application"
npm start
