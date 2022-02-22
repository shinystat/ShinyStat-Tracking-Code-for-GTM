___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "ShinyStat Analytics - Tracking Code",
  "categories": ["ANALYTICS"],
  "brand": {
    "id": "brand_dummy",
    "displayName": "",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAABhGlDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV9TRS0VQYuIOGSoThZERRylikWwUNoKrTqYXPoFTRqSFBdHwbXg4Mdi1cHFWVcHV0EQ/ABxdHJSdJES/5cUWsR4cNyPd/ced+8AoV5mqtkxAaiaZSRjUTGTXRW7XiGgHz0IYFBiph5PLabhOb7u4ePrXYRneZ/7c/QqOZMBPpF4jumGRbxBPLNp6Zz3iUOsKCnE58TjBl2Q+JHrsstvnAsOCzwzZKST88QhYrHQxnIbs6KhEk8ThxVVo3wh47LCeYuzWq6y5j35C4M5bSXFdZojiGEJcSQgQkYVJZRhIUKrRoqJJO1HPfzDjj9BLplcJTByLKACFZLjB/+D392a+alJNykYBTpfbPtjFOjaBRo12/4+tu3GCeB/Bq60lr9SB2Y/Sa+1tPAR0LcNXFy3NHkPuNwBhp50yZAcyU9TyOeB9zP6piwwcAsE1tzemvs4fQDS1NXyDXBwCIwVKHvd493d7b39e6bZ3w8nu3KJp2IRqAAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEgAACxIB0t1+/AAAAAd0SU1FB+YCEgkMOXB4YsAAAAAZdEVYdENvbW1lbnQAQ3JlYXRlZCB3aXRoIEdJTVBXgQ4XAAABb0lEQVR42u3asUrDQBzH8d+1MYkVahFawSIOopu4uxVxEcTFSR/BRZ/ByYLv4Dv4CkJB9AWcREWwgha01hZ751AhOF10kJJ8/8tl+N+QD7/c5UKMc84px1VQzgsAAAAAAAAAAAAAAAByWkH2bint2c78BHDdrvoXrRTTjKLG+tjevr3Zl+yzP/pzJ1JcTwDse1f9o4MUmYkUNa7GNwC2I9nHFDmxMqwBAAAAAO8B/7lDv7blei/+rTauyJRnswcwvGvJXjf9sVw8VLCywyMw9gmw7Xtp+OmP9ExNJiplD2Bw1pR7uvT2hXunKs4vswsAAADfA35XHx25h3N/XzGSWdjIIMDgTe722N8XLv0ZgDUAAAAAAAAAAAAAAAAAAMj3cdgEEypu7qYgS8wK9VW56bp3igknR2OpKlPd9vdP1b6PuaFU2fL3B+XkOl6Tsz3/HBONRn6WZg0AAAAAAAAAAAAAAAAAAAAAAAAAAMhXfQGZYEguLPOibAAAAABJRU5ErkJggg\u003d\u003d"
  },
  "description": "This template is for using ShinyStat Analytics on sites with GTM. Find more info on ShinyStat Analytics at https://www.shinystat.com",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "username",
    "displayName": "ShinyStat Tracking ID",
    "simpleValueType": true,
    "notSetText": "ShinyStat Account is mandatory",
    "valueValidators": [
      {
        "type": "STRING_LENGTH",
        "args": [
          3,
          50
        ]
      },
      {
        "type": "REGEX",
        "args": [
          "^[a-zA-Z0-9-]+$"
        ]
      },
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "Enter ShinyStat \u003cstong\u003eTracking ID\u003c/strong\u003e. You can find it inside your dashboard on \"Account management\" menu"
  },
  {
    "type": "SELECT",
    "name": "abbo",
    "displayName": "Subscription type",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": 1,
        "displayValue": "Free"
      },
      {
        "value": 2,
        "displayValue": "Demo/Pro/Business"
      }
    ],
    "simpleValueType": true,
    "notSetText": "- Select -",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "POSITIVE_NUMBER"
      }
    ],
    "help": "Select your ShinyStat Subscription type"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const logToConsole = require('logToConsole');
const encodeUriComponent = require('encodeUriComponent');
const injectScript = require('injectScript');
const queryPermission = require('queryPermission');
const getUrl = require('getUrl');

const shiny = 'https://codice' + (data.abbo=='2'?'business':'') + '.shinystat.com/cgi-bin/getcod.cgi?NODW=yes&USER=' + encodeUriComponent(data.username) + '&PAG=' + encodeUriComponent(getUrl());

const log = (message) => {
  logToConsole('ShinyStat for GTM:', message);
};

const onSuccess = () => {
  log('Loaded successfully.');
  data.gtmOnSuccess();
};

const onFailure = () => {
  log('Loading failed.');
  data.gtmOnFailure();
};

if(typeof(data.username) === 'undefined' || data.username == ""){
  log('Username undefined.');
  data.gtmOnFailure();
}
else if(typeof(data.abbo) === 'undefined' || data.abbo === 'undefined' || data.abbo == ""){
  log('Subscription type unselected');
  data.gtmOnFailure();
}
else {
  // Check if we got permission to use the custom domain
  if (queryPermission('inject_script', shiny)) {
    injectScript(shiny, onSuccess, onFailure, shiny);
  } else {
    log('No permission to load script. Check the "Inject scripts" in the "Permissions" tab of Google Tab Manager.');
    data.gtmOnFailure();
  }
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://codice.shinystat.com/*"
              },
              {
                "type": 1,
                "string": "https://codicebusiness.shinystat.com/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 22/2/2022, 15:44:38


