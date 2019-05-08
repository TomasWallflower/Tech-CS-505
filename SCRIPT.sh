#!/bin/sh

data=$(curl -s -u "JMENO:HESLO" "http://LOKALNI-IP-MODULU/admin/cgi-bin/edition.cgi" --data "gt=501,502,559,880,531,511,873,874,513")
tempCH=$(echo "$(echo "$data" | sed 's/...//g' | sed 's/,/ /g' | awk '{print $1}') / 10" | bc)
tempCHdemanded=$(echo "$data" | sed 's/...//g' | sed 's/,/ /g' | awk '{print $2}')
tempFLUE=$(echo "$(echo "$data" | sed 's/...//g' | sed 's/,/ /g' | awk '{print $3}') / 10" | bc)
tempFEEDER=$(echo "$(echo "$data" | sed 's/...//g' | sed 's/,/ /g' | awk '{print $4}') / 10" | bc)
FAN=$(echo "$data" | sed 's/..._//g' | sed 's/,/ /g' | awk '{print $5}')
FEEDER=$(echo "$data" | sed 's/..._//g' | sed 's/,/ /g' | awk '{print $6}')
FUEL=$(echo "$data" | sed 's/...//g' | sed 's/,/ /g' | awk '{print $7}')
timeFUEL=$(echo "$data" | sed 's/...//g' | sed 's/,/ /g' | awk '{print $8}')
pumpCH=$(echo "$data" | sed 's/...//g' | sed 's/,/ /g' | awk '{print $9}')

clear
echo 'Central heating water temperature: "$tempCH"'
echo 'Central heating water demanded temperature: "$tempCHdemanded"'
echo 'Flue gas temperature: "$tempFLUE"'
echo 'Feeder temperature: "$tempFEEDER"'
echo 'Fan works at: "$FAN"%'
echo 'Feeder operation: "$FEEDER"'
echo 'Fuel level: $(echo "$FUEL / 512" | bc)%'
echo 'Fuel is enough for: "$timeFUEL" hours'
echo 'Central heating pump operation: "$pumpCH"'
