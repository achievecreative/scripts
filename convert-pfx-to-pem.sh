#!/bin/bash

#pfx file name
pxf_file_name=$1

#pfx password
pfx_pwd=$2

#pem file output name
pem_file_name=$3

#temporary name
pem_file_name_with_key=$pem_file_name.with.key.pem
pem_file_name_without_key=$pem_file_name.without.key.pem
pem_file_name_key=$pem_file_name.key


#extract cert
openssl pkcs12 -in $pxf_file_name -out $pem_file_name_without_key -nokeys -passin pass:$pfx_pwd

#extract key
openssl pkcs12 -in $pxf_file_name -out $pem_file_name_with_key -passin pass:$pfx_pwd -passout pass:$pfx_pwd

#generated rsa key
openssl rsa -in $pem_file_name_with_key -out $pem_file_name_key -passin pass:$pfx_pwd

#combine into pem file
cat $pem_file_name_without_key $pem_file_name_key > $pem_file_name.pem

#clean up, remove temporary files
rm $pem_file_name_with_key
rm $pem_file_name_without_key
rm $pem_file_name_key
