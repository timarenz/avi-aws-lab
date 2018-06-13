#!/bin/bash

environment_name="cisco"

for i in 1 5 10
do
  make apply environment=$environment_name-$i &
  make apply environment=$environment_name-$(expr $i + 1) &
  make apply environment=$environment_name-$(expr $i + 2) &
  make apply environment=$environment_name-$(expr $i + 3) &
  make apply environment=$environment_name-$(expr $i + 4) &
  wait
done