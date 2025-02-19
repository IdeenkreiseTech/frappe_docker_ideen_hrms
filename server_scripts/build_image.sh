git_password=xxx
TAG=1.0.0

cd ../
yes|sudo docker builder prune --all

# Create the JSON string with proper formatting
app1='{"url": "https://IdeenkreiseTech:'"$git_password"'@github.com/IdeenkreiseTech/hrms.git","branch": "version-15"}'
app2='{"url": "https://IdeenkreiseTech:'"$git_password"'@github.com/IdeenkreiseTech/erpnext.git","branch": "version-15"}'
app3='{"url": "https://IdeenkreiseTech:'"$git_password"'@github.com/IdeenkreiseTech/ideen_hrms.git","branch": "develop"}'
export APPS_JSON='['"$app1"','"$app2"','"$app3"']'
export APPS_JSON_BASE64=$(echo ${APPS_JSON} | base64 -w 0)

sudo docker build \
  --build-arg=FRAPPE_PATH=https://github.com/IdeenkreiseTech/frappe \
  --build-arg=FRAPPE_BRANCH=v15.55.0 \
  --build-arg=PYTHON_VERSION=3.11.9 \
  --build-arg=NODE_VERSION=18.20.2 \
  --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64 \
  --tag=ghcr.io/ideenkreisetech/ideen_hrms/ideen_hrms:$TAG \
  --file=images/custom/Containerfile . \
  --no-cache

sudo docker login ghcr.io -u IdeenkreiseTech -p $git_password

sudo docker push ghcr.io/ideenkreisetech/ideen_hrms/ideen_hrms:$TAG
