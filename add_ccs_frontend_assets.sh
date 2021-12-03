#!/usr/bin/env bash

# Check the script is being run in a directory with a 'package.json'
if ! test -f "package.json"
then
  echo "ABORTING SCRIPT: You must be in a project which uses node"
  exit 1
fi

# Check the script is being run in the govuk-prototype-kit
if ! grep -q '"name": "govuk-prototype-kit"' package.json
then
  echo "ABORTING SCRIPT: You must be in the ccs-prototype-kit to run this script"
  exit 2
fi


# Remove old files
echo "STEP 1/5: Remove old files if they exist"

if test -d "node_modules/ccs-frontend-kit/Assets/images"
then
  IMAGE_LIST=$(ls node_modules/ccs-frontend-kit/Assets/images)

  for file in $IMAGE_LIST
  do
    if test -f "app/assets/images/$file"
    then
      rm "app/assets/images/$file"
    fi
  done
fi

if test -d "app/assets/fonts"
then
  rm -rf app/assets/fonts
fi

if test -d "app/assets/svg"
then
  rm -rf app/assets/svg
fi

if test -d "app/assets/javascripts/ccs"
then
  rm -rf app/assets/javascripts/ccs
fi

if test -d "public"
then
  rm -rf public
fi


# Add the relevant package
echo "STEP 2/5: Installing 'ccs-frontend-kit' with npm"

npm install --silent ccs-frontend-kit

# Check the packages have been correctly installed
if ! (grep -Fq "ccs-frontend-kit" package.json && test -d "node_modules/ccs-frontend-kit")
then
  echo "ABORTING SCRIPT: Node modules for 'ccs-frontend-kit' have not been properly installed"
  exit 3
fi


# Copy files from node modules to the asses folder
echo "STEP 3/5: Copying files to the 'app/assets' directory"

cp -a ./node_modules/ccs-frontend-kit/Assets/images/. app/assets/images
cp -R ./node_modules/ccs-frontend-kit/Assets/fonts app/assets/fonts
cp -R ./node_modules/ccs-frontend-kit/Assets/svg app/assets/svg

# Check files have been copied correctly
IMAGE_FILES="$(ls node_modules/ccs-frontend-kit/Assets/images)"
STOP=false

for file in $IMAGE_FILES
do
  if ! test -f "app/assets/images/$file"
  then
    echo "ERROR: '$file' missing from 'app/assets/images'"
    STOP=true
  fi
done

if ! test -d "app/assets/fonts"
then
  echo "ERROR: Fonts missing from 'app/assets'"
  STOP=true
fi

if ! test -d "app/assets/svg"
then
  echo "ERROR: SVG missing from 'app/assets/svg'"
  STOP=true
fi

if $STOP
then 
  echo "ABORTING SCRIPT: Assets have not been properly copied to the 'app/assets/images'"
  exit 4
fi


# Import the new stylesheets into the end of 'app/assets/sass/application.scss'
echo "STEP 4/5: Adding import of CCS styles to 'app/assets/sass/application.scss'"

APPLICATION_SCSS_FILE="app/assets/sass/application.scss"
IMPORT_LINE='@import "node_modules/ccs-frontend-kit/Assets/styles/styles.scss";'

if ! grep -Fq "$IMPORT_LINE" $APPLICATION_SCSS_FILE
then
  echo "$IMPORT_LINE" >> $APPLICATION_SCSS_FILE
fi


# Import JavaScripts into the project
echo "STEP 5/5: Adding import of CCS styles to 'app/assets/sass/application.scss'"

JAVASCRIPT_DIR="app/assets/javascripts/ccs"

mkdir $JAVASCRIPT_DIR
cp ./node_modules/ccs-frontend-kit/Assets/scripts/app.js $JAVASCRIPT_DIR
cp ./node_modules/ccs-frontend-kit/Assets/scripts/libraries/objectFitPolyfill.js $JAVASCRIPT_DIR

# Check the JavaScript files have been correctly copied
if ! (test -f "$JAVASCRIPT_DIR/app.js" && test -f "$JAVASCRIPT_DIR/objectFitPolyfill.js")
then
  echo "ABORTING SCRIPT: Javascript files have not been copied correctly"
  exit 5
fi

# Add the script tags for the JavaScript
SCRIPTS_FILE="app/views/includes/scripts.html"

if ! (grep -Fq '<script src="/public/javascripts/ccs/app.js"></script>' $SCRIPTS_FILE && grep -Fq '<script src="/public/javascripts/ccs/objectFitPolyfill.js"></script>' $SCRIPTS_FILE)
then
  {
    echo ""
    echo '<script src="/public/javascripts/ccs/app.js"></script>'
    echo '<script src="/public/javascripts/ccs/objectFitPolyfill.js"></script>'
  } >> $SCRIPTS_FILE
fi


# Finish the programme
echo "PROCESS COMPLETE: CCS assets have been added"
exit 0