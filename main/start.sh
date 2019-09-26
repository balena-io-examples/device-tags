echo "setting 'stats.laststart' tag"
sh tags_api/set-device-tag.sh "stats.laststart" $(date +%s)
echo "starting application"
npm start
