UNZIPPED_FILE_NAME=wso2am-2.1.0
DOWNLOAD_ZIP_FILE_NAME=wso2am-2.1.0.zip
ON_PREM_GATEWAY_DOWNLOAD_LINK=https://s3.amazonaws.com/wso2cloud-resources/on-premise-gateway/wso2am-2.1.0.zip

echo "Downloading WSO2 On-Prem API Gateway..."
wget $ON_PREM_GATEWAY_DOWNLOAD_LINK
echo "Setting up WSO2 On-prem API Gateway..."
unzip -q $DOWNLOAD_ZIP_FILE_NAME
pwd
ls
#Move to On-premise root directory.
#cd $UNZIPPED_FILE_NAME


#Binding Heroku dynamic port to Axis2 synapse port.
sed -i 's/ORG_KEY=""/ORG_KEY="${WSO2_CLOUD_ORG_KEY}"/' wso2am-2.1.0/bin/configure-gateway.sh
sed -i 's/EMAIL=""/EMAIL="${WSO2_CLOUD_EMAIL}"/' wso2am-2.1.0/bin/configure-gateway.sh
sed -i 's/PASSWORD=""/PASSWORD="${WSO2_CLOUD_PASSWORD}"/' wso2am-2.1.0/bin/configure-gateway.sh 
echo 'sed -i "s/8280/$PORT/" repository/conf/axis2/axis2.xml' >> wso2am-2.1.0/bin/configure-gateway.sh
echo 'bash bin/wso2server.sh -Dsetup' >> wso2am-2.1.0/bin/configure-gateway.sh
