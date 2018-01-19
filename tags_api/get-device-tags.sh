API_KEY=$RESIN_API_KEY
if [ "$USER_API_KEY" ] ; then
	API_KEY=$USER_API_KEY
fi

curl -X GET "https://api.resin.io/v3/device_tag" \
	-H "Content-Type:application/json" \
	-H "Authorization: Bearer $API_KEY"
