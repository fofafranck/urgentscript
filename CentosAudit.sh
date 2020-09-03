#!/bin/bash


#Description: Centos7 Audit
#Author: Fabrice F
#Date: August 2020


echo -e "\n***********************************************\n" > /var/log/centos7audit-$(date +%F)
echo -e "\n*****  Centos 7 audit *********************\n" >> /var/log/centos7audit-$(date +%F)
echo -e "\n*****************************************\n"   >> /var/log/centos7audit-$(date +%F)

## Check hosts file

echo -e "\n Check the hosts file\n" >> /var/log/centos7audit-$(date +%F)
 if [ -f /etc/hosts ] ; then
    echo "File /etc/hosts exist" >> /var/log/centos7audit-$(date +%F)
 else
   echo "File /etc/hosts does not exist" >> /var/log/centos7audit-$(date +%F)
 fi

## CHeck Selinux

echo -e "\nChecking selinus\n" >> /var/log/centos7audit-$(date +%F)
echo -e "\n The selinux is set to $(getenforce) \n" >> /var/log/centos7audit-$(date +%F)

## nobody user' uid

echo -e "\nCheck nobody's uid\n"  >> /var/log/centos7audit-$(date +%F)
echo -e "\nThe user nobody's uid is $(grep ^nobody /etc/passwd|awk -F: '{print$3}') \n" >> /var/log/centos7audit-$(date +%F)

## Check for samba package

echo -e "\nChecking samba package\n" >> /var/log/centos7audit-$(date +%F)
rpm -qa |grep samba  >/dev/null 2>&1

  if [ $? -eq 0 ]; then
     echo -e "\n Package samba installed\n" >> /var/log/centos7audit-$(date +%F)
  else
     echo -e "\nPackage samba not installed\n" >> /var/log/centos7audit-$(date +%F)
  fi

## Check for curl package

echo -e "\nChecking curl package\n" >> /var/log/centos7audit-$(date +%F)
rpm -qa |grep curl  >/dev/null 2>&1

  if [ $? -eq 0 ]; then
     echo -e "\n Package curl installed\n" >> /var/log/centos7audit-$(date +%F)
  else
     echo -e "\nPackage curl not installed\n" >> /var/log/centos7audit-$(date +%F)
  fi
## Check for docker package

echo -e "\nChecking docker package\n" >> /var/log/centos7audit-$(date +%F)
rpm -qa |grep docker  >/dev/null 2>&1

  if [ $? -eq 0 ]; then
     echo -e "\n Package docker installed\n" >> /var/log/centos7audit-$(date +%F)
  else
     echo -e "\nPackage docker not installed\n" >> /var/log/centos7audit-$(date +%F)
  fi
## Checking the auditd

echo -e "\nChecking the auditd\n" >> /var/log/centos7audit-$(date +%F)
systemctl status auditd | grep Loaded | awk -F";" '{print " auditd is"$2}' >> /var/log/centos7audit-$(date +%F)
systemctl status auditd | awk 'NR ==3 {print "auditd is " $3}' | tr -d '()' >> /var/log/centos7audit-$(date +%F)

## Check network file

echo -e "\n Check the network file\n" >> /var/log/centos7audit-$(date +%F)
 if [ -f /etc/sysconfig/network ] ; then
    echo "File /etc/sysconfig/network exist" >> /var/log/centos7audit-$(date +%F)
 else
   echo "File /etc/sysconfig/network does not exist" >> /var/log/centos7audit-$(date +%F)
 fi
## Check hostname
echo -e "\nThe hostname for this server is $(hostname) \n" >> /var/log/centos7audit-$(date +%F)

##Check system bits
echo -e "\nthe system is $(getconf LONG_BIT) \n" >> /var/log/centos7audit-$(date +%F)

## Check if the 8.8.8.8 DNS entry is on the /etc/resolv.conf file
echo -e "\nCheck if the 8.8.8.8 DNS entry is on the /etc/resolv.conf file\n" >> /var/log/centos7audit-$(date +%F)
cat /etc/resolv.conf |grep 8.8.8.8 >> /var/log/centos7audit-$(date +%F)
if
     [ $? -eq 0 ] ; then
echo "there is a dns entry with 8.8.8.8 in the resolv.conf file" >> /var/log/centos7audit-$(date +%F)
else
echo "there is not a dns entry with 8.8.8.8 in the resolv.conf file" >> /var/log/centos7audit-$(date +%F)
fi

##  Check what is the ip address of the serveur
echo -e "\nCheck what is the ip address of the serveur\n" >> /var/log/centos7audit-$(date +%F)
echo "The Ip address of the server is $( hostname -I | awk '{print $1}' )" >> /var/log/centos7audit-$(date +%F)

##  Check  the linus flavor running and the version
echo -e "\n the os running in this server is $(cat /etc/*release | awk '{ if(NR==1) print $1$2$4 }') \n" >> /var/log/centos7audit-$(date +%F)

##  Check the first digit of the kernel version
echo -e "\n the first digit of the kernel version is $( uname -r |awk -F. '{ print$1 }' ) \n" >> /var/log/centos7audit-$(date +%F)

##  Check the total size of the memory
echo -e "\n the total size of the memory is $( free -m |awk '{if (NR==2) print$2 }' ) \n" >> /var/log/centos7audit-$(date +%F)

##  Check if the logfile is configured in the sudo tool
echo -e "\nCheck if the logfile is configured in the sudo tool\n" >> /var/log/centos7audit-$(date +%F)
cat /etc/sudoers |grep logfile >> /var/log/centos7audit-$(date +%F)
if
  [ $? -eq 0 ] ; then
echo “ the logfile is configured on the sudo tool” >> /var/log/centos7audit-$(date +%F)
else
echo “the logfile is not configured on the sudo tool” >> /var/log/centos7audit-$(date +%F)
fi

                        
