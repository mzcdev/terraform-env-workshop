#!/usr/bin/env bash

# Log everything we do.
set -x
exec > /var/log/user-data.log 2>&1

hostname "${HOSTNAME}"

rm -rf /etc/motd
cat <<EOF > /etc/motd

#########################################################
#                                                       #
#   모든 로그는 원격지 로그 서버에 저장되고 있습니다.   #
#   비인가자의 경우 접속을 해지하여 주시기 바랍니다.    #
#                                                       #
#########################################################

>> ${HOSTNAME} <<

EOF

runuser -l ec2-user -c "curl -sL https://raw.githubusercontent.com/opspresso/toaster/master/tools.sh | bash"
runuser -l ec2-user -c "curl -sL https://raw.githubusercontent.com/opspresso/toaster/master/install.sh | bash"
