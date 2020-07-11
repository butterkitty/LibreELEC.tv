counter=0
advancedSettings="/storage/.kodi/userdata/advancedsettings.xml"

if [ $1 -lt 5 ]; then # If the waitonnetwork time is less than 5, we may need more than that for the network to come up in full, so make it 5 in this context
  maxCounter=5
else
  maxCounter=$1
fi

if grep -qF "<!--<videodatabase>" ${advancedSettings} && awk '/<videodatabase>/{flag=1;next}/<\/videodatabase>/{flag=0}flag' ${advancedSettings} | grep -q "<type>mysql"; then # Start with a mysql enabled advancedsettings.xml, IF it is in use at all
  sed -i ':a;N;$!ba;s/<!--<videodatabase>\(.*\)<\/videodatabase>-->/<videodatabase>\1<\/videodatabase>/g' ${advancedSettings}
fi
if grep -qF "<!--<musicdatabase>" ${advancedSettings} && awk '/<musicdatabase>/{flag=1;next}/<\/musicdatabase>/{flag=0}flag' ${advancedSettings} | grep -q "<type>mysql"; then
  sed -i ':a;N;$!ba;s/<!--<musicdatabase>\(.*\)<\/musicdatabase>-->/<musicdatabase>\1<\/musicdatabase>/g' ${advancedSettings}
fi


while ! /bin/ping -c1 google.com ; do # If there is no real internet connection, loop through. Checking using google.com as a very reliable source
  if [ $counter -eq $maxCounter ]; then # If we've tried to ping for a real internet connection as many times as the network is set to wait
    if ! grep -qF "<!--<videodatabase>" ${advancedSettings} && awk '/<videodatabase>/{flag=1;next}/<\/videodatabase>/{flag=0}flag' ${advancedSettings} | grep -q "<type>mysql"; then # If the advancedsettings.xml is mysql enabled, disable it
      sed -i ':a;N;$!ba;s/<videodatabase>\(.*\)<\/videodatabase>/<!--&-->/g' ${advancedSettings}
    fi
    if ! grep -qF "<!--<musicdatabase>" ${advancedSettings} && awk '/<musicdatabase>/{flag=1;next}/<\/musicdatabase>/{flag=0}flag' ${advancedSettings} | grep -q "<type>mysql"; then
      sed -i ':a;N;$!ba;s/<musicdatabase>\(.*\)<\/musicdatabase>/<!--&-->/g' ${advancedSettings}
    fi
    exit 0
  fi
  sleep 1
  counter=$(( $counter+1 ))
done
exit 0
