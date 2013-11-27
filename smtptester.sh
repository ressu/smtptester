#!/usr/bin/env bash

MAIL_USER=mail_auth_user
MAIL_PASS=mail_auth_password

MAIL_HOST=helo.host.name
MAIL_TO=target@example.com
MAIL_FROM=source@example.com
MAIL_SERVER=mailserver.example.com

# We use the perl based utility smtp-cli for testing
SCRIPT_URL=https://raw.github.com/mludvig/smtp-cli/master/smtp-cli

# Set filename for the script and trap a deletion on script exit
SMTP_CLI=`mktemp`
trap "rm -f $SMTP_CLI" EXIT

# Input message data for test deliveries
read -d '' MESSAGE_DATA <<EOM || true
Subject: SMTP Delivery test
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

This message tests mail delivery through various methods

%MESSAGETYPE%
EOM

# Start off by downloading the script in to a temporary file:
wget --no-check-certificate -O $SMTP_CLI -q $SCRIPT_URL

### HERE BE DRAGONS.. And ugly code

# Run the checks
CHECK_TYPE='Unauthenticated'
perl $SMTP_CLI --missing-modules-ok --hello-host=$MAIL_HOST --server=$MAIL_SERVER --from=$MAIL_FROM --to=$MAIL_TO --data=<(echo "$MESSAGE_DATA" | sed -e "s/%MESSAGETYPE%/$CHECK_TYPE/") --port=25

# Authenticated
CHECK_TYPE='Authenticated'
perl $SMTP_CLI --missing-modules-ok --hello-host=$MAIL_HOST --server=$MAIL_SERVER --from=$MAIL_FROM --to=$MAIL_TO --data=<(echo "$MESSAGE_DATA" | sed -e "s/%MESSAGETYPE%/$CHECK_TYPE/") --user=$MAIL_USER --pass=$MAIL_PASS --port 465
perl $SMTP_CLI --missing-modules-ok --hello-host=$MAIL_HOST --server=$MAIL_SERVER --from=$MAIL_FROM --to=$MAIL_TO --data=<(echo "$MESSAGE_DATA" | sed -e "s/%MESSAGETYPE%/$CHECK_TYPE/") --user=$MAIL_USER --pass=$MAIL_PASS --port 587
