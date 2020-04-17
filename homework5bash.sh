#!/bin/bash

mkdir /user/homework5Input
cd /user/homework5Input
git clone https://github.com/vmlynnj/homework5.git
for x in {1..22}; do wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/chromosomes/chr$x.fa.gz; done;
wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/chromosomes/chrX.fa.gz
wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/chromosomes/chrY.fa.gz
gunzip *
hdfs dfs -mkrdir /user/homework5Input
for x in *.fa; do hdfs dfs -put $x homework5Input; done;
export PATH=${JAVA_HOME}/bin:${PATH}
echo $PATH
export HADOOP_CLASSPATH=${JAVA_HOME}/lib/tools.jar
echo $HADOOP_CLASSPATH
cd ./homework5Input
hadoop com.sun.tools.javac.Main *.java
jar cvf homework.jar *.class
hadoop jar homework.jar Kmer homework5Input homework5Output 3