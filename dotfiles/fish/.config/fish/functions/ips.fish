function ips
    set_color --bold green
    echo "Getting all IP addresses ..."
    set_color normal
    ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sort | awk '{ sub(/inet6? (addr:)? ?/, ""); print }'
end

function gateway
    set_color --bold green
    echo "Getting default gateway ..."
    set_color normal
    route -n get default | grep gateway | awk '{ print $2 }'
end

function ii
    set_color --bold green
    echo "Getting system information ..."
    set_color normal
    echo -e "\nYou are logged on $HOST"
    echo -e "$NC "
    system_profiler SPSoftwareDataType
    echo -e "\nAdditionnal information:$NC "
    uname -a
    echo -e "\nUsers logged on:$NC "
    w -h
    echo -e "\nCurrent date :$NC "
    date
    echo -e "\nMachine stats :$NC "
    uptime
    echo -e "\nCurrent network location :$NC "
    scselect
    echo -e "\nPublic facing IP Address :$NC "
    remoteip
    echo -e "\nDNS Configuration:$NC "
    scutil --dns
    echo
end

function ips4
    set_color --bold green
    echo "Getting IPv4 addresses ..."
    set_color normal
    ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | grep -v inet6 | awk '{ sub(/inet6? (addr:)? ?/, ""); print }'
end

function ips6
    set_color --bold green
    echo "Getting IPv6 addresses ..."
    set_color normal
    ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | grep inet6 | awk '{ sub(/inet6? (addr:)? ?/, ""); print }'
end

function remoteip
    set_color --bold green
    echo -n "Getting public IP address ... "
    set_color normal
    doggo --type A --query myip.opendns.com --nameserver resolver1.opendns.com --ipv4 --short
end
