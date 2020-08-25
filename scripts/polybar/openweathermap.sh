#!/usr/bin/env bash

source /home/juozas/nix-config/variables.env

get_icon() {
  case $1 in
  01d) icon="" ;;
  01n) icon="" ;;
  02d) icon="" ;;
  02n) icon="" ;;
  03d) icon="" ;;
  03n) icon="" ;;
  04d) icon="" ;;
  04n) icon="" ;;
  09*) icon="" ;;
  10d) icon="" ;;
  10n) icon="" ;;
  11d) icon="" ;;
  11n) icon="" ;;
  13*) icon="" ;;
  50*) icon="" ;;
  *) icon=" " ;;
  esac

  echo "$icon"
}

KEY=${OPENWEATHER_API_KEY} # secrets.env
CITY="Glasgow,UK"
UNITS="metric"
SYMBOL="°"

API="https://api.openweathermap.org/data/2.5"

if [ -n "$CITY" ]; then
  if [ "$CITY" -eq "$CITY" ] 2>/dev/null; then
    CITY_PARAM="id=$CITY"
  else
    CITY_PARAM="q=$CITY"
  fi

  weather=$(curl -sf "$API/weather?appid=$KEY&$CITY_PARAM&units=$UNITS")
else
  location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

  if [ -n "$location" ]; then
    location_lat="$(echo "$location" | jq '.location.lat')"
    location_lon="$(echo "$location" | jq '.location.lng')"

    weather=$(curl -sf "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
  fi
fi

if [ -n "$weather" ]; then
  weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
  weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")

  echo "$(get_icon "$weather_icon") " " $weather_temp$SYMBOL"
fi
