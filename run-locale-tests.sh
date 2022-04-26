#!/bin/bash
LOCALE_ARRAY=()
SEPARATE_LOCALES=$(cat ./config/single.config.yml | grep 'location_' | awk '{ gsub(":", "") ; print $1 }' | tr '\n' ' ')

for element in $SEPARATE_LOCALES
do
  LOCALE_ARRAY+=$element' '
done

for element in $LOCALE_ARRAY
do
  echo $element
  echo $(bundle exec cucumber --tag @testing LOCATION=$element)
done
