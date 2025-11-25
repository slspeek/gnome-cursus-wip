#!/usr/bin/env bash
for IMAGE in img/*
do
  if ! grep  $IMAGE pres/*.md *.md &> /dev/null;
      then echo $IMAGE wordt niet gebruikt ; 
  fi;
done