#!/bin/bash

STEP_NAME=$1
UPSTREAM_STEP_NAME=$2
# RESULT=$3  #use result to specify status?
RESULT=$3
DATE=$(date +%Y-%m-%d" "%H:%M:%S)
# TOOL_ID=env0
URL=https://$INSTANCE_NAME.service-now.com/api/sn_devops/devops/tool/orchestration
#URL=https://webhook.site/eb4a87b3-6006-4d14-ba01-44c447927db8
#app.env0.com/p/$ENV0_PROJECT_ID/environments/$ENV0_ENVIRONMENT_ID/deployments/$ENV0_DEPLOYMENT_LOG_ID#$UPSTREAM_STEP_NAME\
# https://docs.env0.com/docs/custom-flows#exposed-env0-system-environment-variables All environment variables

echo "STEP_NAME : $STEP_NAME , UPSTREAM_STEP_NAME : $UPSTREAM_STEP_NAME , RESULT : $RESULT , TOOL_ID : $TOOL_ID "
echo "Webhook notification invoked to $URL $URL?toolId=$TOOL_ID "

WEBHOOK_DATA="{
\"taskExecution\": {
  \"toolId\": \"$TOOL_ID\",
  \"buildNumber\": \"$ENV0_DEPLOYMENT_LOG_ID\",
  \"nativeId\": \"$ENV0_ENVIRONMENT_NAME#$STEP_NAME/$ENV0_DEPLOYMENT_LOG_ID\",
  \"name\": \"$ENV0_ENVIRONMENT_NAME#$STEP_NAME/$ENV0_DEPLOYMENT_LOG_ID\",
  \"id\": \"$ENV0_ENVIRONMENT_NAME#$STEP_NAME/$ENV0_DEPLOYMENT_LOG_ID\",
  \"url\": \"app.env0.com/p/$ENV0_PROJECT_ID/environments/$ENV0_ENVIRONMENT_ID/deployments/$ENV0_DEPLOYMENT_LOG_ID#$STEP_NAME\",
  \"isMultiBranch\": \"false\",
  \"branchName\": \"$ENV0_DEPLOYMENT_REVISION\",
  \"pipelineExecutionUrl\": \"api.env0.com/p/$ENV0_PROJECT_ID/environments/$ENV0_ENVIRONMENT_ID/deployments/$ENV0_DEPLOYMENT_LOG_ID\",
  \"orchestrationTaskUrl\": \"api.env0.com/p/$ENV0_PROJECT_ID/environments/$ENV0_ENVIRONMENT_ID/$STEP_NAME\",
  \"orchestrationTaskName\": \"$ENV0_PROJECT_ID/$ENV0_ENVIRONMENT_NAME#$STEP_NAME\",
  \"result\": \"$RESULT\",
  \"startDateTime\": \"$DATE\",
  \"endDateTime\":\"$DATE\",
  \"upstreamId\": \"$UPSTREAM_STEP_NAME\"
},
\"orchestrationTask\": {
  \"orchestrationTaskURL\": \"api.env0.com/p/$ENV0_PROJECT_ID/environments/$ENV0_ENVIRONMENT_ID/$STEP_NAME\",
  \"orchestrationTaskName\": \"$ENV0_PROJECT_ID/$ENV0_ENVIRONMENT_NAME#$STEP_NAME\",
  \"branchName\": \"$ENV0_DEPLOYMENT_REVISION\",
  \"toolId\": \"$TOOL_ID\"
}
}"


echo "Webhook Data $WEBHOOK_DATA" 

curl -X POST -H "Content-Type: application/json" -u "$USERNAME:$PASSWORD" $URL?toolId=$TOOL_ID -d "$WEBHOOK_DATA"

