#!/bin/bash
for i in {1..15}
do
  make destroy environment=frey-$i owner=frey
done