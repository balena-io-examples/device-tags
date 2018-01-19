API_KEY=$RESIN_API_KEY
if [ "$USER_API_KEY" ] ; then
	API_KEY=$USER_API_KEY
fi

TAG_KEY=$1
RESIN_DEVICE_ID=$2
if ! [ "$RESIN_DEVICE_ID" ] ; then
	RESIN_DEVICE_ID=$(curl "https://api.resin.io/v3/device?\$select=id,uuid&\$filter=uuid%20eq%20'$RESIN_DEVICE_UUID'" -H "Authorization: Bearer $API_KEY" | jq '.d[0].id')
fi

curl -X GET "https://api.resin.io/v3/device_tag?\$filter=((device%20eq%20$RESIN_DEVICE_ID)%20and%20(tag_key%20eq%20'$TAG_KEY'))" \
	-H "Content-Type:application/json" \
	-H "Authorization: Bearer $API_KEY"
