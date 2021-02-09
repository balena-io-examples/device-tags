echo "setting 'stats.laststart' tag"
sh curl_tags_api/set-device-tag.sh "stats.laststart" $(date +%s)
echo "starting application"
npm start
