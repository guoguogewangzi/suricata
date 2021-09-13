#/bin/bash

systemctl restart docker

sleep 5s

docker run --rm -d -it --net=host --cap-add=net_admin --cap-add=sys_nice -v /root/logs:/var/log/suricata jasonish/suricata:latest -i ens33



path=`find /var/lib/docker/volumes/ -name "*suricata.yaml*" | xargs ls -alt | tail -n 1 | cut -c 47-154`

#echo $path

#echo "sed -i.bak 's/\/var\/lib\/suricata\/rules/\/var\/log\/suricata\/rules/g' $path"


sed -i.bak 's/\/var\/lib\/suricata\/rules/\/var\/log\/suricata\/rules/g' $path


id=`docker ps | grep Up | cut -d " " -f 1`

docker exec -it $id /bin/bash

#离线检测命令
#/usr/bin/suricata -r /var/log/suricata/pcap/ -l /var/log/suricata/ -k none
