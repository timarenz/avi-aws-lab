#!/bin/bash

environment_name="cisco"

for i in 1 5 10
do
  make destroy environment=$environment_name-$i &
  make destroy environment=$environment_name-$(expr $i + 1) &
  make destroy environment=$environment_name-$(expr $i + 2) &
  make destroy environment=$environment_name-$(expr $i + 3) &
  make destroy environment=$environment_name-$(expr $i + 4) &
  wait
done