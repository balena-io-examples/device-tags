curl -sSL -X GET "$BALENA_API_URL/v3/device_tag" \
	-H "Content-Type:application/json" \
	-H "Authorization: Bearer $BALENA_API_KEY"
