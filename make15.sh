#!/bin/bash
for i in {1..15}
do
  make apply environment=frey-$i
done