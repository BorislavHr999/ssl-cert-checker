#!/bin/bash

DOMAIN=$1
if [ -z "$DOMAIN" ]; then
  echo "Usage: ./check_ssl.sh <domain>"
  exit 1
fi

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo ""
echo -e "Checking SSL certificate for domain: ${YELLOW}$DOMAIN${NC}..."

EXPIRY_DATE=$(echo | openssl s_client -servername $DOMAIN -connect $DOMAIN:443 2>/dev/null | openssl x509 -noout -enddate | cut -d= -f2)

if [ -z "$EXPIRY_DATE" ]; then
  echo -e "${RED}Failed to retrieve SSL certificate for $DOMAIN.${NC}"
  exit 1
fi

EXPIRY_EPOCH=$(date -d "$EXPIRY_DATE" +%s)
CURRENT_EPOCH=$(date +%s)
CURRENT_EPOCH=$((EXPIRY_EPOCH - CURRENT_EPOCH))
DAYS_REMAINING=$((CURRENT_EPOCH / 86400))

echo "==============================="
echo "Expiry Date : $EXPIRY_DATE"

if [ $DAYS_REMAINING -le 0 ]; then
  echo -e "Status      : ${RED}EXPIRED${NC}"
elif [ $DAYS_REMAINING -le 15 ]; then
  echo -e "Status      : ${RED}EXPIRING SOON${NC} (${DAYS_REMAINING} days remaining)"
elif [ $DAYS_REMAINING -le 30 ]; then
  echo -e "Status      : ${YELLOW}VALID${NC} (${DAYS_REMAINING} days remaining)"
else
  echo -e "Status      : ${GREEN}VALID${NC} (${DAYS_REMAINING} days remaining)"
fi

echo "==============================="
echo ""