UNZIPPED_FILE_NAME=wso2am-2.1.0
DOWNLOAD_ZIP_FILE_NAME=wso2am-2.1.0.zip
ON_PREM_GATEWAY_DOWNLOAD_LINK=https://s3.amazonaws.com/wso2cloud-resources/on-premise-gateway/wso2am-2.1.0.zip

# Check for mandatory pre-requisites
command -v wget >/dev/null 2>&1 || { echo >&2 "wget was not found. Please install wget first."; exit 1; }
command -v unzip >/dev/null 2>&1 || { echo >&2 "unzip was not found. Please install unzip first."; exit 1; }

if [ ! -f $DOWNLOAD_ZIP_FILE_NAME ] || [ ! -d $UNZIPPED_FILE_NAME ]; then
    echo "Downloading WSO2 On-Prem API Gateway..."
    wget -q $ON_PREM_GATEWAY_DOWNLOAD_LINK
fi

if [ ! -f $DOWNLOAD_ZIP_FILE_NAME ]
    then
        echo "$DOWNLOAD_ZIP_FILE_NAME doesn't exist in current file location."
        exit 1
    else
        if [ ! -d $UNZIPPED_FILE_NAME ]; then
            #Unzip downloaded On-prem gateway to current location and remove the zip file.
            unzip -q $DOWNLOAD_ZIP_FILE_NAME
             
            #Binding Heroku dynamic port to Axis2 synapse port.
	    sed -i 's/ORG_KEY=""/ORG_KEY="${WSO2_CLOUD_ORG_KEY}"/' $UNZIPPED_FILE_NAME/bin/configure-gateway.sh
	    sed -i 's/EMAIL=""/EMAIL="${WSO2_CLOUD_EMAIL}"/' $UNZIPPED_FILE_NAME/bin/configure-gateway.sh
	    sed -i 's/PASSWORD=""/PASSWORD="${WSO2_CLOUD_PASSWORD}"/' $UNZIPPED_FILE_NAME/bin/configure-gateway.sh
	    echo 'sed -i "s/8280/$PORT/" wso2am-2.1.0/repository/conf/axis2/axis2.xml' >> $UNZIPPED_FILE_NAME/bin/configure-gateway.sh
	    echo 'bash wso2am-2.1.0/bin/wso2server.sh' >> $UNZIPPED_FILE_NAME/bin/configure-gateway.sh
            rm -rf DOWNLOAD_ZIP_FILE_NAME
        fi
fi

sh $UNZIPPED_FILE_NAME/bin/configure-gateway.sh
