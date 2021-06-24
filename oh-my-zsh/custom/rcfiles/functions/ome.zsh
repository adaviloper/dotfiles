alias staging-billing="eb ssh staging-2020-04-13-01"
alias staging="eb ssh staging-ome-main-2021-03-25"
alias production="eb ssh production-2020-04-24"

demo () {
  demoDir
  if [[ $1 == "today" ]]
  then
    vim "$(date +'%Y')-$(date +'%m')-$(date +'%d').md"
  fi
}

demoDir () {
  cd ~/Code/workbench/sprint-demos/$(date +"%Y")
}

bastion3 () {
  ssh1 10.0.4.31
}

bastion4 () {
  ssh2 10.0.4.31
}

dev21 () {
  ssh21 10.0.4.86
}

dev22 () {
  ssh22 10.0.4.86
}

devlb1 () {
  ssh1 10.0.4.47
}

devlb2 () {
  ssh2 10.0.4.47
}

# SSH through bastion1 at known private IP
# Usage: ssh1 <privateIP>
ssh1 () {
        ssh forge@"${1}" -o "proxycommand ssh -W %h:%p adrian@25.81.0.213"
}

# SSH through bastion2 at known private IP
# Usage: ssh1 <privateIP>
ssh2 () {
        ssh forge@"${1}" -o "proxycommand ssh -W %h:%p adrian@25.63.170.49"
}

# retrieve private IP from known public IP
# Usage: getIP <publicIP>
getIP () {
ssh adrian@25.43.216.247 cat /var/www/html/instancesPublic.csv | grep ${1} | awk -F "," '{print $3}'
}

# SSH to instance from known public IP (through bastion1)
# relies on CSV file on internal server - redundancy efforts are underway!
# Usage: ssh3 <publicIP>
ssh3 () {
	connectIP=$(ssh adrian@25.43.216.247 cat /var/www/html/instancesPublic.csv | grep ${1} | awk -F "," '{print $3}') && ssh1 ${connectIP}
}


# SSH to instance from known public IP (through bastion2)
# relies on CSV file on internal server - redundancy efforts are underway!
# Usage: ssh4 <publicIP>
ssh4 () {
	connectIP=$(ssh adrian@25.43.216.247 cat /var/www/html/instancesPublic.csv | grep ${1} | awk -F "," '{print $3}') && ssh2 ${connectIP}
}

# Copy file to host from known private IP
# Places file in home directory of forge user
# Usage: scp1 <file> <privateIP>
scp1 () {
        scp -o "proxycommand ssh -W %h:%p adrian@bastion1.ome.farm" "${1}" forge@"${2}":~
}

# Copy file to host from known private IP
# Places file in home directory of forge user
scp2 () {
        scp -o "proxycommand ssh -W %h:%p adrian@bastion2.ome.farm" "${1}" forge@"${2}":~
}
