#!/bin/bash
curl -s "https://aviationweather.gov/api/data/metar?ids=KMCI&format=json&taf=false&hours=12&bbox=40%2C-90%2C45%2C-85" > aviation.json
echo "ReceiptTime values:"
cat aviation.json | jq -r '.[] | .receiptTime' | head -n 6
temp=$(cat aviation.json | jq -r '.[] | .temp')
total=0
count=0
for temp in $temp; do
	total=$(($total+$temp))
	count=$(($count + 1))
done

average=$(($total / $count))
echo "Average Temperature: $average"
clouds=$(cat aviation.json | jq -r '.[] | .clouds | length')
cloudy=0
for cloud in $clouds; do
    if [ "$cloud" != "CLR" ]; then
        cloudy=$(($cloudy + 1))
    fi
done

if [ $cloudy -gt $(($count / 2)) ]; then
    echo "Mostly Cloudy: true"
else
    echo "Mostly Cloudy: false"
fi

