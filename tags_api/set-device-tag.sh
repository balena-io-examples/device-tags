TAG_KEY=$1
TAG_VALUE=$2

RESIN_DEVICE_ID=$(curl "https://api.resin.io/v3/device?\$select=id,uuid&\$filter=uuid%20eq%20'$RESIN_DEVICE_UUID'" -H "Authorization: Bearer $RESIN_API_KEY" | jq '.d[0].id')

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH
TAG_EXISTS=$(sh get-device-tag.sh "$TAG_KEY" "$RESIN_DEVICE_ID" | jq ".d[0] != null")

if [ "$TAG_EXISTS" = "false" ] ; then
	curl -X POST "https://api.resin.io/v3/device_tag" \
		-H "Authorization: Bearer $RESIN_API_KEY" \
		-H "Content-Type: application/json" \
		--data-binary '{"tag_key":"'$TAG_KEY'","device":'$RESIN_DEVICE_ID',"value":"'$TAG_VALUE'"}'
else
	curl -X PATCH "https://api.resin.io/v3/device_tag?\$filter=tag_key%20eq%20'$TAG_KEY'" \
		-H "Authorization: Bearer $RESIN_API_KEY" \
		-H "Content-Type: application/json" \
		--data-binary '{"tag_key":"'$TAG_KEY'", "device":'$RESIN_DEVICE_ID', "value":"'$TAG_VALUE'"}'
fi
