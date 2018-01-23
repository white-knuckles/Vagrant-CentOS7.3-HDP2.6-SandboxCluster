#!/usr/bin/env bash

vagrant up ambari1
vagrant up master1
vagrant up slave1
vagrant up slave2
open -a safari http://ambari1:8080/